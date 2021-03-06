import Foundation

typealias OptimalPath = (path: [GraphNode], length: Int)

final class AStarPathfinder {

    func findShortestPathBetween(_ node1: GraphNode, _ node2: GraphNode) -> OptimalPath? {
        do {
            return try findPathWithAStarAlgorithm(from: node1, to: node2)
        } catch PathfinderError.noPathFound {
            print("Unable to find path between \(node1.description) & \(node2.description)")
        } catch {
            print("Something bad happened")
        }

        return nil
    }
}

private extension AStarPathfinder {

    func findCheapestFScoreNodeIn(_ set: [GraphNode]) -> GraphNode? {
        return set.min { $0.f < $1.f }
    }

    func heuristicCostEstimate(_ currentNode: GraphNode, _ goalNode: GraphNode) -> Double {
        return Double(abs(currentNode.coordinates.x - goalNode.coordinates.x) +
            abs(currentNode.coordinates.y - goalNode.coordinates.y))
    }

    func findPathWithAStarAlgorithm(from startNode: GraphNode, to goalNode: GraphNode) throws -> OptimalPath {
        var closedSet = [GraphNode]()            // Множество вершин, которые уже обработаны (раскрыты)
        var openSet: [GraphNode] = [startNode]   // Множество вершин(очередь), которые предстоит обработать (раскрыть)

        startNode.g = 0                     // g(x). Стоимость пути от начальной вершины. У start g(x) = 0
        startNode.h = heuristicCostEstimate(startNode, goalNode)    // Эвристическая оценка расстояния до цели. h(x)

        while !openSet.isEmpty {
            guard let currentNode = findCheapestFScoreNodeIn(openSet) else {
                throw PathfinderError.somethingWentWrong
            }

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
                    neighbourNode.previousNode = currentNode
                    neighbourNode.g = tentativeGScore
                    neighbourNode.h = heuristicCostEstimate(neighbourNode, goalNode)
                }
            }
        }

        throw PathfinderError.noPathFound
    }

    func reconstructPath(_ startNode: GraphNode, _ goalNode: GraphNode) -> OptimalPath {
        var path = [GraphNode]()
        var currentNode = goalNode
        var cost = 0
        while currentNode != startNode {
            cost += 1
            path.append(currentNode)
            guard let previousNodeInPath = currentNode.previousNode else { // у стартовой вершины нет cameFrom
                break
            }

            currentNode = previousNodeInPath
        }

        path.append(startNode)
        return (path.reversed(), cost)
    }
}
