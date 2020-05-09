import UIKit

typealias OptimalTuple = (path: [Node], length: Int)

final class PathViewModel {

    var navigationTitle: String = ""

    var graph: [Node] = []
    var path: [Node] = []

    init(title: String) {
        navigationTitle = title
        graph = createGraph(with: MockEndPoints.nodes)
    }

    func parseNodes() throws -> [Node] {
        let url = Bundle.main.url(forResource: "nodes", withExtension: "plist")!
        let data = try Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try decoder.decode([Node].self, from: data)
    }

    func createGraph(with nodes: [Node]) -> [Node] {
        nodes.forEach { node in
            let neighbours = nodes.filter {
                ($0.coordinates.x == node.coordinates.x &&
                    ($0.coordinates.y == node.coordinates.y + 1 || $0.coordinates.y == node.coordinates.y - 1)) ||
                    ($0.coordinates.y == node.coordinates.y &&
                        ($0.coordinates.x == node.coordinates.x + 1 || $0.coordinates.x == node.coordinates.x - 1))
            }
            node.updateNeighbours(with: neighbours)
        }
        return nodes
    }

    func createRoute() {
        // MOCK: add isEntrance flag to Node
        // MOCK: find nearest nodes to waybill nodes + add entrance node
        let waybillPositions = graph // [entranceNode, graph[1], graph[2], graph[3], graph[4]]
        var matrix = Matrix(rows: waybillPositions.count,
                            columns: waybillPositions.count,
                            initValue: 0)

        let aSP = AStarPathfinder()
        for i in 0..<waybillPositions.count {
            for j in i+1..<waybillPositions.count {
                guard let pathLength = aSP.findShortestPathBetween(waybillPositions[i],
                                                                   waybillPositions[j])?.length else {
                    break
                }

                matrix[i, j] = pathLength
                matrix[j, i] = pathLength
            }
        }

        let aco = AntColonyRouteCreator(dists: matrix)
        aco.run().forEach {
            path.append(waybillPositions[$0])
        }
        // MOCK: отрисовать получившийся маршрут на карте с номерами вершин
    }
}
