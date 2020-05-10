import UIKit

final class PathViewModel {

    var navigationTitle: String = ""

    var graph: [Node]
    var positions: [Node]
    var path: [Node] = []

    init(title: String, graph: [Node], items: [Node]) {
        navigationTitle = title
        self.graph = graph
        positions = items
    }

    func createRoute() {
        guard let entranceNode = graph.first(where: { $0.isEntrance }) else {
            fatalError("There is no entrance node")
        }

        // MOCK: find nearest nodes to waybill nodes
        let requiredWalkableNodes = [entranceNode, graph[1], graph[3], graph[6], graph[12]]
        var matrix = Matrix(rows: requiredWalkableNodes.count,
                            columns: requiredWalkableNodes.count,
                            initValue: 0)

        let aStar = AStarPathfinder()
        for i in 0..<requiredWalkableNodes.count {
            for j in i+1..<requiredWalkableNodes.count {
                guard let pathLength = aStar.findShortestPathBetween(requiredWalkableNodes[i],
                                                                     requiredWalkableNodes[j])?.length else {
                    break
                }

                matrix[i, j] = pathLength
                matrix[j, i] = pathLength
            }
        }

        let antColonyOptimizator = AntColonyRouteCreator(dists: matrix)
        antColonyOptimizator.findOptimalRoute().forEach {
            path.append(requiredWalkableNodes[$0])
        }

        var whichIs = ""
        path.forEach {
            whichIs += $0 == path.last ? $0.description : "\($0.description) -> "
        }
        print("\(whichIs)")
        // MOCK: отрисовать получившийся маршрут (path) на карте с номерами вершин
    }
}
