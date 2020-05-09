import Foundation

typealias OptimalTuple = (path: [Node], length: Int)

final class AStarPathfinder {

    func findShortestPathBetween(_ node1: Node, _ node2: Node) -> OptimalTuple? {
        do {
            return try findPathWithAStarMethod(from: node1, to: node2)
        } catch PathfinderError.noPathFound {
            print("Unable to find path between \(node1.description) & \(node2.description)")
        } catch {
            print("Something bad happened")
        }

        return nil
    }
}

private extension AStarPathfinder {

    func findCheapestFScoreNodeIn(_ set: [Node]) -> Node? {
        return set.min { $0.f < $1.f }
    }

    func heuristicCostEstimate(_ currentNode: Node, _ goalNode: Node) -> Double {
        return Double(abs(currentNode.coordinates.x - goalNode.coordinates.x) +
            abs(currentNode.coordinates.y - goalNode.coordinates.y))
    }

    func findPathWithAStarMethod(from startNode: Node, to goalNode: Node) throws -> OptimalTuple {
        var closedSet = [Node]()            // Множество вершин, которые уже обработаны (раскрыты)
        var openSet: [Node] = [startNode]   // Множество вершин(очередь), которые предстоит обработать (раскрыть)

        startNode.g = 0                     // g(x). Стоимость пути от начальной вершины. У start g(x) = 0
        startNode.h = heuristicCostEstimate(startNode, goalNode)    // Эвристическая оценка расстояния до цели. h(x)

        while !openSet.isEmpty {
            guard let currentNode = findCheapestFScoreNodeIn(openSet) else {
                throw PathfinderError.somethingWentWrong
            }

            print("----\nConsider node: \(currentNode.description)")

            if currentNode == goalNode {
                return reconstructPath(startNode, goalNode)
            }

            openSet.removeAll { $0 == currentNode }
            closedSet.append(currentNode)

            currentNode.neighbours.forEach { neighbourNode in
                guard !closedSet.contains(neighbourNode) else {
                    return
                }

                let tentativeGScore = currentNode.g + 1 // distance between currentNode and it's neighbour is 1
                var isTentativeBetter = false

                if !openSet.contains(neighbourNode) {
                    openSet.append(neighbourNode)
                    isTentativeBetter = true
                } else {
                    isTentativeBetter = tentativeGScore < neighbourNode.g
                }

                if isTentativeBetter {
                    neighbourNode.previousPathNode = currentNode
                    neighbourNode.g = tentativeGScore
                    neighbourNode.h = heuristicCostEstimate(neighbourNode, goalNode)
                }
            }
        }

        throw PathfinderError.noPathFound
    }

    func reconstructPath(_ startNode: Node, _ goalNode: Node) -> OptimalTuple {
        var path = [Node]()
        var currentNode = goalNode
        var cost = 0
        while currentNode != startNode {
            cost += 1
            path.append(currentNode)
            guard let previousNodeInPath = currentNode.previousPathNode else { // у стартовой вершины нет cameFrom
                break
            }

            currentNode = previousNodeInPath
        }

        path.append(startNode)

        var result = ""
        path.reversed().forEach {
            result += $0 == path.reversed().last ? $0.description : "\($0.description) -> "
        }
        print("Found path: \(result), length: \(cost)")
        return (path.reversed(), cost)
    }
}
