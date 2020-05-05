import Foundation

struct Matrix<T> {
    let rows: Int, columns: Int
    var grid: [T]

    init() {
        rows = 0
        columns = 0
        grid = []
    }

    init(rows: Int, columns: Int, initValue: T) {
        self.rows = rows
        self.columns = columns
        grid = []

        for _ in 1...(self.rows * self.columns) {
            grid.append(initValue)
        }
    }

    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }

    func indexIsValid(row: Int) -> Bool {
        return row >= 0 && row < rows
    }

    subscript(row: Int, column: Int) -> T {
        get {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

struct Ant {
    var trail = [Int]()
}

class AntColonyOptimizator {
    let alpha = 3.0
    let beta = 2.0
    let rho = 0.01
    let Q = 2.0

    var numCities: Int
    var numAnts: Int

    var ants = [Ant]()
    var pheromones = Matrix<Double>()
    var dists = Matrix<Int>()

    init(_ numberOfCities: Int, numberOfAnts: Int) {

        numCities = numberOfCities
        numAnts = numberOfAnts

        print("\nInitializing dummy graph distances")

        dists = makeGraphDistances()

        print("\nInitializing ants to random trails\n")

        ants = initAnts()

        for i in 0..<numAnts {
            print("\(i): [ ")

            for j in 0..<numCities {
                print("\(ants[i].trail[j]) ")
            }

            print("] len = \(length(ants[i].trail))\n")
        }

        print("\nInitializing pheromones on trails")

        pheromones = initPheromones()
    }

    func makeGraphDistances() -> Matrix<Int> {
        var distMatrix = Matrix<Int>(rows: numCities, columns: numCities, initValue: 0)

        for i in 0..<numCities {
            for j in i+1..<numCities {
                let d = (Int(arc4random()) % 8) + 1  //1...9
                distMatrix[i, j] = d
                distMatrix[j, i] = d
            }
        }

        return distMatrix
    }

    func distance(cityX: Int, cityY: Int) -> Double {
        return Double(dists[cityX, cityY])
    }

    func initAnts() -> [Ant] {
        var antArray = [Ant]()

        for _ in 0..<numAnts {
            var ant = Ant()
            let start = Int(arc4random()) % numCities
            ant.trail = randomTrail(start)
            antArray.append(ant)
        }

        return antArray
    }

    func randomTrail(_ start: Int) -> [Int] {
        var trail = [Int](repeating: 0, count: numCities)

        for i in 0..<numCities {
            trail[i] = i
        }

        //Fisher-Yates shuffle algorithm
        for i in 0..<numCities {
            let r0 = Int(arc4random()) % (numCities-i)
            let r = r0 + i
            let tmp = trail[r]
            trail[r] = trail[i]
            trail[i] = tmp
        }

        let idx = indexOfTarget(trail: trail, target: start);

        let temp = trail[0]
        trail[0] = trail[idx]
        trail[idx] = temp

        return trail;
    }

    func indexOfTarget(trail: [Int], target: Int) -> Int {
        for i in 0..<trail.count {
            if trail[i] == target {
                return i
            }
        }

        assert(true, "Target not found")
        return -1
    }

    func bestTrail() -> [Int] {
        var bestLength = length(ants[0].trail)
        var idxBestLength = 0

        for k in 1..<numAnts {
            let len = length(ants[k].trail)

            if len < bestLength {
                bestLength = len
                idxBestLength = k
            }
        }

        return ants[idxBestLength].trail
    }

    func length(_ trail: [Int]) -> Double {
        var result = 0.0

        for i in 0..<trail.count-1 {
            result += distance(cityX: trail[i], cityY: trail[i+1])
        }

        return result
    }

    func initPheromones() -> Matrix<Double> {
        var pheromoneArray = Matrix<Double>(rows: numCities, columns: numCities, initValue: 0.0)

        for i in 0..<pheromoneArray.rows {
            for j in 0..<pheromoneArray.columns {
                pheromoneArray[i, j] = 0.01
            }
        }

        return pheromoneArray
    }

    func updateAnts() {
        let numCities = pheromones.rows

        for k in 0..<numAnts {
            let startCity = Int(arc4random()) % numCities
            ants[k].trail = buildTrail(k: k, start: startCity)
        }
    }

    func buildTrail(k: Int, start: Int) -> [Int] {
        let numCities = pheromones.rows
        var trail = [Int](repeating: 0, count: numCities)
        var visited = [Bool](repeating: false, count: numCities)
        trail[0] = start
        visited[start] = true

        for i in 0..<numCities-1 {
            var cityX = trail[i]
            var next = nextCity(k: k, cityX: cityX, visited: visited)
            trail[i+1] = next
            visited[next] = true
        }

        return trail
    }

    func nextCity(k: Int, cityX: Int, visited: [Bool]) -> Int {
        let probs = moveProbabilities(k: k, cityX: cityX, visited: visited)
        var cumul = [Double](repeating: 0.0, count: probs.count + 1)

        for i in 0..<probs.count {
            cumul[i+1] = cumul[i] + probs[i]
        }

        //per suggestion
        cumul[cumul.count-1] = 1.0

        let p = Double(arc4random())/0x100000000  //random double between 0.0 and 1.0

        for i in 0..<cumul.count-1 {
            if p >= cumul[i] && p < cumul[i+1] {
                return i
            }
        }

        assert(true, "Failure to return valid city in NextCity")
        return -1
    }

    func moveProbabilities(k: Int, cityX: Int, visited: [Bool]) -> [Double] {
        let numCities = pheromones.rows
        var taueta = [Double](repeating: 0.0, count: numCities)
        var sum = 0.0

        for i in 0..<taueta.count {
            if i == cityX {
                taueta[i] = 0.0
            } else if visited[i] {
                taueta[i] = 0.0
            } else {
                taueta[i] = pow(pheromones[cityX, i], alpha) *
                    pow(1.0 / distance(cityX: cityX, cityY: i), beta)

                if taueta[i] < 0.0001 {
                    taueta[i] = 0.0001
                } else if taueta[i] > Double.greatestFiniteMagnitude / Double(numCities * 100) {
                    taueta[i] = Double.greatestFiniteMagnitude / Double(numCities * 100)
                }
            }

            sum += taueta[i]
        }

        var probs = [Double](repeating: 0.0, count: numCities)

        for i in 0..<probs.count {
            probs[i] = taueta[i] / sum
        }

        return probs
    }

    func updatePheromones() {
        for i in 0..<pheromones.rows {
            for j in i+1..<pheromones.rows {
                for k in 0..<numAnts {
                    let len = length(ants[k].trail)
                    let decrease = (1.0-rho) * pheromones[i, j]
                    var increase = 0.0

                    if edgeInTrail(cityX: i, cityY: j, trail: ants[k].trail) {
                        increase = Q/Double(len)
                    }

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

    func edgeInTrail(cityX: Int, cityY: Int, trail: [Int]) -> Bool {
        let lastIndex = trail.count - 1
        let idx = indexOfTarget(trail: trail, target: cityX)

        if idx == 0 && trail[1] == cityY {
            return true
        } else if idx == 0 && trail[lastIndex] == cityY {
            return true
        } else if idx == 0 {
            return false
        } else if idx == lastIndex && trail[lastIndex - 1] == cityY {
            return true
        } else if idx == lastIndex && trail[0] == cityY {
            return true
        } else if idx == lastIndex {
            return false
        } else if trail[idx - 1] == cityY {
            return true
        } else if trail[idx + 1] == cityY {
            return true
        } else {
            return false
        }
    }

    func display(trail: [Int]) {
        for i in 0..<trail.count {
            print("\(trail[i]) ")

            if i > 0 && i % 20 == 0 {
                print()
            }
        }

        print()
    }

    func run(maxTime: Int) {
        var newBestTrail = bestTrail()
        var bestLength = length(newBestTrail)

        print("\nBest initial trail length: \(bestLength)")

        var time = 0

        print("\nEntering UpdateAnts - UpdatePheromones loop\n")

        while time < maxTime {
            updateAnts()
            updatePheromones()

            let currBestTrail = bestTrail()
            let currBestLength = length(currBestTrail)

            if currBestLength < bestLength {
                bestLength = currBestLength
                newBestTrail = currBestTrail

                print("New best length of \(bestLength) found at time \(time)")
            }

            //++time
            time += 1
        }

        print("\nTime complete")

        print("\nBest trail found:")
        display(trail: newBestTrail)
        print("\nLength of best trail found: \(bestLength)")
    }
}

//print("Begin Ant Colony Optimization demo")
//
//let numCities = 20
//let numAnts = 4
//let maxTime = 100
//
//print("\nNumber of cities in problem = \(numCities)")
//
//let antColonyOptimizator = AntColonyOptimizator(numCities, numberOfAnts: numAnts)
//
//antColonyOptimizator.run(maxTime)
//
//print("\nEnd Ant Colony Optimization demo");
