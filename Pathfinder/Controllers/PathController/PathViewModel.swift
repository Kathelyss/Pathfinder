import UIKit
import RxSwift
import RxCocoa

final class PathViewModel {

    private let pathFoundRelay = PublishRelay<Void>()
    private let itemsRecievedRelay = PublishRelay<Void>()

    var pathFoundDriver: Driver<Void> {
        return pathFoundRelay.asDriver(onErrorDriveWith: .empty())
    }

    var itemsRecievedDriver: Driver<Void> {
        return itemsRecievedRelay.asDriver(onErrorDriveWith: .empty())
    }

    var navigationTitle: String = ""

    var graph: [GraphNode]
    var items: [GraphNode] = []
    var path: [GraphNode] = []

    init(title: String, graph: [GraphNode], items: [GraphNode]) {
        navigationTitle = title
        self.graph = graph

        // MOCK: add items recieved event
        self.items = items
        itemsRecievedRelay.accept(())
    }

    func createRoute() {
        guard let entranceNode = graph.first(where: { $0.isEntrance }) else {
            fatalError("There is no entrance node")
        }

//        let walkableNodes = findWalkableNodes(for: positions, in: graph)
//        walkableNodes.insert(entranceNode, at: 0)
        items.append(entranceNode)
        let walkableNodes = [entranceNode, graph[1], graph[3], graph[6], graph[12]]
        var matrix = Matrix(rows: walkableNodes.count,
                            columns: walkableNodes.count,
                            initValue: 0)

        let aStar = AStarPathfinder()
        for i in 0..<walkableNodes.count {
            for j in i+1..<walkableNodes.count {
                guard let pathLength = aStar.findShortestPathBetween(walkableNodes[i],
                                                                     walkableNodes[j])?.length else {
                    break
                }

                matrix[i, j] = pathLength
                matrix[j, i] = pathLength
            }
        }

        let antColonyOptimizator = AntColonyRouteCreator(dists: matrix)
        antColonyOptimizator.findOptimalRoute().forEach {
            path.append(walkableNodes[$0])
        }

        var whichIs = ""
        path.forEach {
            whichIs += $0 == path.last ? $0.description : "\($0.description) -> "
        }
        print("\(whichIs)")
        pathFoundRelay.accept(())
    }

    func findWalkableNodes(for positions: [GraphNode], in graph: [GraphNode]) -> [GraphNode] {
        var walkableNodes = [GraphNode]()
        positions.forEach { itemPosition in
            guard let freeNeighbour = itemPosition.getFreeNeighbours().first else {
                return
            }

            walkableNodes.append(freeNeighbour)
        }

        return walkableNodes
    }
}

extension GraphNode {
    // MOCK: find nearest nodes to waybill nodes
    func getFreeNeighbours() -> [GraphNode] {
        return [neighbours[0]]
    }
}
