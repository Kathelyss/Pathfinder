import Foundation

class MainStorage {

    var graph: [Node] {
        return createGraph(with: MockEndPoints.nodes)
    }

    var items: [Node] {
        return [graph[1], graph[3], graph[6], graph[12]]
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
}
