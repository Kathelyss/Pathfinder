import Foundation
import CoreGraphics

class Path {
    public let totalLength: Int
    public let totalWeight: Int
    public let node: Node
    public let previousPath: Path?

    var nodes: [Node] {
        var nodes: [Node] = [self.node]
        var iterativePath = self
        while let path = iterativePath.previousPath {
            nodes.append(path.node)
            iterativePath = path
        }
        return nodes
    }

    init(to node: Node, via edge: Edge? = nil, previousPath path: Path? = nil) {
        if let previousPath = path, let viaEdge = edge {
            self.totalLength = viaEdge.length + previousPath.totalLength
            self.totalWeight = viaEdge.weight + previousPath.totalWeight
        } else {
            self.totalLength = 0
            self.totalWeight = 0
        }
        self.node = node
        self.previousPath = path
    }

}
