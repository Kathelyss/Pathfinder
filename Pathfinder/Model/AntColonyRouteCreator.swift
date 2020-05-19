import Foundation

final class AntColonyRouteCreator {
    var distancesMatrix = Matrix<Int>()
    var ants = [Ant]()
    var pheromones = Matrix<Double>()

    // MARK: - Initializer

    init(dists: Matrix<Int>) {
        distancesMatrix = dists
        printDistMatrix()
        ants = initAnts(count: Constants.numberOfAnts)
        pheromones = Matrix<Double>(rows: distancesMatrix.columns,
                                    columns: distancesMatrix.columns,
                                    initValue: 0.01)
    }

    func findOptimalRoute() -> [Int] {
        var shortestRoute = findShortestPath()
        var bestLength = lengthOf(shortestRoute)
        var time = 0

        while time < Constants.timeLimit {
            updateAnts()
            updatePheromones()

            let newShortestRoute = findShortestPath()
            let newBestLength = lengthOf(newShortestRoute)

            if newBestLength < bestLength {
                bestLength = newBestLength
                shortestRoute = newShortestRoute
            }
            time += 1
        }

        var resString = "Route: "
        for i in 0..<shortestRoute.count {
            resString += "\(shortestRoute[i]), "
        }
        print("\(resString), length = \(bestLength)")
        return shortestRoute
    }
}

private extension AntColonyRouteCreator {

    func findShortestPath() -> [Int] {
        var bestLength = lengthOf(ants[0].path)
        var bestLengthIndex = 0

        for i in 1..<ants.count {
            let length = lengthOf(ants[i].path)
            if length < bestLength {
                bestLength = length
                bestLengthIndex = i
            }
        }

        return ants[bestLengthIndex].path
    }

    // MARK: - Initial setup

    func printDistMatrix() {
        print("\nGraph distances are:")
        var row = ""
        for i in 0..<distancesMatrix.columns {
            for j in 0..<distancesMatrix.columns {
                row += "\(distancesMatrix[i, j]) "
            }
            row += "\n"
        }
        print(row)
    }

    func initAnts(count: Int) -> [Ant] {
        var array = [Ant]()

        for _ in 0..<count {
            var ant = Ant()
            let start = Int(arc4random()) % distancesMatrix.columns
            ant.path = generateRandomPath(start)
            array.append(ant)
        }

        return array
    }

    func generateRandomPath(_ start: Int) -> [Int] {
        var path = [Int](repeating: 0, count: distancesMatrix.columns)
        for i in 0..<distancesMatrix.columns {
            path[i] = i
        }

        //Fisher-Yates shuffle algorithm
        for i in 0..<distancesMatrix.columns {
            let r0 = Int(arc4random()) % (distancesMatrix.columns - i)
            let r = r0 + i
            let tmp = path[r]
            path[r] = path[i]
            path[i] = tmp
        }

        guard let startIndex = path.firstIndex(of: start) else {
            print("Error")
            return []
        }

        let tmp = path[0]
        path[0] = path[startIndex]
        path[startIndex] = tmp

        return path
    }

    func lengthOf(_ path: [Int]) -> Int {
        var result = 0
        for i in 0..<path.count - 1 {
            result += distancesMatrix[path[i], path[i + 1]]
        }
        return result
    }

    // MARK: - update ants

    func updateAnts() {
        ants.enumerated().forEach { (index, ant) in
            let startNode = Int(arc4random()) % distancesMatrix.columns
            ants[index].path = createPath(from: startNode)
        }
    }

    func createPath(from start: Int) -> [Int] {
        var path = [Int](repeating: 0, count: distancesMatrix.columns)
        var visitedNodes = [Bool](repeating: false, count: distancesMatrix.columns)
        path[0] = start
        visitedNodes[start] = true

        for i in 0..<distancesMatrix.columns - 1 {
            let nextNode = getNextNode(for: path[i], visitedNodes)
            path[i + 1] = nextNode
            visitedNodes[nextNode] = true
        }

        path.append(start) // зацикливаем маршрут (приходим в начало пути)
        return path
    }

    func getNextNode(for node: Int, _ visitedNodes: [Bool]) -> Int {
        let probabilities = updateMovingProbabilities(node, visitedNodes)
        var cumul = [Double](repeating: 0.0, count: probabilities.count + 1)

        for i in 0..<probabilities.count {
            cumul[i + 1] = cumul[i] + probabilities[i]
        }

        // per suggestion
        cumul[cumul.count - 1] = 1.0

        let p = Double(arc4random())/0x100000000  //random double between 0.0 and 1.0

        for i in 0..<cumul.count - 1 {
            if p >= cumul[i] && p < cumul[i + 1] {
                return i
            }
        }

        assert(true, "Failure to return valid node in getNextNode")
        return -1
    }

    // MARK: - update probabilities

    func updateMovingProbabilities(_ node: Int, _ visitedNodes: [Bool]) -> [Double] {
        var taueta = [Double](repeating: 0.0, count: distancesMatrix.columns)
        var sum = 0.0

        for i in 0..<taueta.count {
            if i == node || visitedNodes[i] {
                taueta[i] = 0.0
            } else {
                taueta[i] = pow(pheromones[node, i], Constants.alpha) * pow(1.0 / Double(distancesMatrix[node, i]), Constants.beta)

                if taueta[i] < 0.0001 {
                    taueta[i] = 0.0001
                } else if taueta[i] > Double.greatestFiniteMagnitude / Double(distancesMatrix.columns * 100) {
                    taueta[i] = Double.greatestFiniteMagnitude / Double(distancesMatrix.columns * 100)
                }
            }

            sum += taueta[i]
        }

        var probs = [Double](repeating: 0.0, count: distancesMatrix.columns)

        for i in 0..<probs.count {
            probs[i] = taueta[i] / sum
        }

        return probs
    }

    // MARK: - update pheromones

    func updatePheromones() {
        for i in 0..<pheromones.rows {
            for j in i+1..<pheromones.rows {
                for k in 0..<ants.count {
                    let decrease = (1.0 - Constants.rho) * pheromones[i, j]
                    let increase = isEdgeBetween(i, j, in: ants[k].path) ? 0.0 : 1/Double(lengthOf(ants[k].path))
                    pheromones[i, j] = decrease + increase

                    if pheromones[i, j] < 0.0001 {
                        pheromones[i, j] = 0.0001
                    } else if pheromones[i, j] > 100000.0 {
                        pheromones[i, j] = 100000.0
                    }

                    pheromones[j, i] = pheromones[i, j]
                }
            }
        }
    }

    func isEdgeBetween(_ node1: Int, _ node2: Int, in path: [Int]) -> Bool {
        let lastIndex = path.count - 1
        guard let nodeIndex = path.firstIndex(of: node1) else {
            print("Error")
            return false
        }

        if nodeIndex == 0 && path[1] == node2 {
            return true
        } else if nodeIndex == 0 && path[lastIndex] == node2 {
            return true
        } else if nodeIndex == 0 {
            return false
        } else if nodeIndex == lastIndex && path[lastIndex - 1] == node2 {
            return true
        } else if nodeIndex == lastIndex && path[0] == node2 {
            return true
        } else if nodeIndex == lastIndex {
            return false
        } else if path[nodeIndex - 1] == node2 {
            return true
        } else if path[nodeIndex + 1] == node2 {
            return true
        } else {
            return false
        }
    }
}

extension Constants {
    static let alpha = 3.0
    static let beta = 2.0
    static let rho = 0.01
    static let timeLimit = 100
    static let numberOfAnts = 10
}
