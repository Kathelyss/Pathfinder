import CoreGraphics

class Node: Hashable, Codable, CustomStringConvertible {

    // MARK: - Protocol conformance
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.coordinates == rhs.coordinates
    }

    // MARK: - Properties

    let coordinates: CGPoint
    var description: String {
        return "(\(coordinates.x), \(coordinates.y))"
    }

    // MARK: - A*
    var neighbours: [Node] = []
    var previousPathNode: Node?
    var g: Double = Double.greatestFiniteMagnitude
    var h: Double = Double.greatestFiniteMagnitude
    var f: Double {
        return g + h
    }

    // MARK: - Initializer

    init(coordinates: CGPoint) {
        self.coordinates = coordinates
    }

    func updateNeighbours(with nodes: [Node]) {
        neighbours = nodes
    }
}
