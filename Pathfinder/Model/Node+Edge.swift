import CoreGraphics

class Node: Hashable, Codable, CustomStringConvertible {
    var hashValue: Int {
        return name.hashValue
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.name == rhs.name
    }

    let name: String
    let coordinates: CGPoint
    var edges: [Edge] = []
    var description: String {
        return "\(name) - (x: \(coordinates.x), y: \(coordinates.y))"
    }

    var g: Double = 0.0
    var h: Double = 0.0
    var f: Double {
        return g + h
    }
    var neighbourNodes: [Node] = []
    var cameFrom: Node?

    init(name: String, coordinates: CGPoint) {
        self.name = name
        self.coordinates = coordinates
    }

    func connectTo(node: Node, edgeLength: Int, firstEdgeWeight: Int, secondEdgeWeight: Int) {
        self.edges.append(Edge(first: self, second: node, length: edgeLength, weight: firstEdgeWeight))
        node.edges.append(Edge(first: node, second: self, length: edgeLength, weight: secondEdgeWeight))
    }

}

class Edge: Codable, CustomStringConvertible {
    let firstNode: Node
    let secondNode: Node
    let length: Int
    let weight: Int //for stairs
    var description: String {
        return "\(firstNode.name) - > \(secondNode.name) = \(length)"
    }

    init(first: Node, second: Node, length: Int, weight: Int) {
        firstNode = first
        secondNode = second
        self.length = length
        self.weight = weight
    }
}
