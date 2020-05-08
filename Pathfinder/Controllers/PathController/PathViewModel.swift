import UIKit

final class PathViewModel {

    var navigationTitle: String = ""

    var graph: [Node] = []
    var path: [Node] = []

    init(title: String) {
        navigationTitle = title
        graph = createGraph()
        calculateRoute()
    }

    func parseNodes() throws -> [Node] {
        let url = Bundle.main.url(forResource: "nodes", withExtension: "plist")!
        let data = try Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try decoder.decode([Node].self, from: data)
    }

    func calculateRoute() {
        do {
            _ = try findAStarPath(from: graph[10], to: graph[5])
        } catch PathfinderError.noPathFound {
            print("no path found")
        } catch {
            print("some else shit happened")
        }
    }

    func createGraph() -> [Node] {
        let node1 = Node(coordinates: CGPoint(x: 0, y: 0))
        let node2 = Node(coordinates: CGPoint(x: 0, y: 1))
        let node3 = Node(coordinates: CGPoint(x: 0, y: 2))
        let node4 = Node(coordinates: CGPoint(x: 0, y: 3))

        let node5 = Node(coordinates: CGPoint(x: 1, y: 0))
        let node6 = Node(coordinates: CGPoint(x: 1, y: 3))

        let node7 = Node(coordinates: CGPoint(x: 2, y: 0))
        let node8 = Node(coordinates: CGPoint(x: 2, y: 1))
        let node9 = Node(coordinates: CGPoint(x: 2, y: 3))

        let node10 = Node(coordinates: CGPoint(x: 3, y: 0))
        let node11 = Node(coordinates: CGPoint(x: 3, y: 1))
        let node12 = Node(coordinates: CGPoint(x: 3, y: 2))
        let node13 = Node(coordinates: CGPoint(x: 3, y: 3))

        let res = [node1, node2, node3, node4, node5, node6, node7, node8, node9, node10, node11, node12, node13]

        res.forEach { node in
            let neighbours = res.filter {
                ($0.coordinates.x == node.coordinates.x && ($0.coordinates.y == node.coordinates.y + 1 || $0.coordinates.y == node.coordinates.y - 1))
                    || ($0.coordinates.y == node.coordinates.y && ($0.coordinates.x == node.coordinates.x + 1 || $0.coordinates.x == node.coordinates.x - 1))
            }
            node.updateNeighbours(with: neighbours)
        }

        return res
    }

    func findAStarPath(from startNode: Node, to goalNode: Node) throws -> [Node] {
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

                let tentativeGScore = currentNode.g + distanceBetween(currentNode, neighbourNode)
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

    func distanceBetween(_ firstNode: Node, _ secondNode: Node) -> Double {
        return 1.0
    }

    func reconstructPath(_ startNode: Node, _ goalNode: Node) -> [Node] {
        var path = [Node]()
        var currentNode = goalNode
        var cost = 0.0
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
        // MOCK: append cost to ACO matrix
        return path.reversed()
    }

    func findCheapestFScoreNodeIn(_ set: [Node]) -> Node? {
        return set.min { $0.f < $1.f }
    }

    func heuristicCostEstimate(_ node: Node, _ goalNode: Node) -> Double {
        let res = Double(abs(node.coordinates.x - goalNode.coordinates.x) + abs(node.coordinates.y - goalNode.coordinates.y))
        print("Heuristic cost estimate for \(node.description) & \(goalNode.description) is \(res)")
        return res
    }
}
