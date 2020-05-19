import CoreGraphics

final class GraphNode: Hashable, Codable, CustomStringConvertible {

    // MARK: - Protocol conformance
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }

    static func == (lhs: GraphNode, rhs: GraphNode) -> Bool {
        return lhs.coordinates == rhs.coordinates
    }

    // MARK: - Properties

    let coordinates: CGPoint
    let isEntrance: Bool
    var description: String {
        return "(\(Int(coordinates.x)), \(Int(coordinates.y)))"
    }

    // MARK: - A*
    var neighbours: [GraphNode] = []
    var previousNode: GraphNode?
    var g: Double = Double.greatestFiniteMagnitude
    var h: Double = Double.greatestFiniteMagnitude
    var f: Double {
        return g + h
    }

    // MARK: - Initializer

    init(coordinates: CGPoint, isEntrance: Bool = false) {
        self.coordinates = coordinates
        self.isEntrance = isEntrance
    }

    func updateNeighbours(with nodes: [GraphNode]) {
        neighbours = nodes
    }
}
