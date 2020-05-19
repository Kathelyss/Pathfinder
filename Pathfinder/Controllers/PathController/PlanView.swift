import UIKit

class PlanView: UIView {

    var shelfs: [GraphNode] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    var items: [GraphNode] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    var path: [GraphNode] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    public override func draw(_ rect: CGRect) {
        guard items.isNotEmpty else {
            // if there's no shelfs on map, than we have nothing to draw at all
            return
        }

        guard let context = UIGraphicsGetCurrentContext() else {
            print("Error: no context found!")
            return
        }

        context.setLineWidth(Constants.lineWidth)
        shelfs.forEach { drawSquare(nodeOrigin: getCoordinates(for: $0)) }

        if items.isNotEmpty {
            items.forEach { drawCircle(nodeLocation: getCoordinates(for: $0)) }
        }

        if path.isNotEmpty {
            drawInitialPath()
            // add new layer with path
        }
    }
}

private extension PlanView {

    func getCoordinates(for node: GraphNode) -> CGPoint {
        let xMultiplier = bounds.size.width / Constants.xCellCount
        let yMultiplier = bounds.size.height / Constants.yCellCount
        return CGPoint(x: (node.coordinates.x * xMultiplier + Constants.lineWidth),
                       y: (node.coordinates.y * yMultiplier + Constants.lineWidth))
    }

    func drawSquare(nodeOrigin: CGPoint) {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Error: no context found!")
            return
        }

        context.setLineWidth(1)
        context.move(to: nodeOrigin)
        context.addRect(CGRect(x: nodeOrigin.x,
                               y: nodeOrigin.y,
                               width: Constants.cellWidth,
                               height: Constants.cellWidth))
        context.setFillColor(UIColor.systemTeal.cgColor)
        context.fillPath()
    }

    func drawCircle(nodeLocation: CGPoint) {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Error: no context found!")
            return
        }

        context.setLineWidth(5)
        context.move(to: nodeLocation)
        let radius = CGFloat(8)
        context.addEllipse(in: CGRect(x: nodeLocation.x - radius,
                                      y: nodeLocation.y - radius,
                                      width: radius * 2,
                                      height: radius * 2))
        context.setFillColor(UIColor.systemPink.cgColor)
        context.fillPath()
    }

    func drawInitialPath() {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Error: no context found!")
            return
        }

        context.move(to: getCoordinates(for: path[0]))
        for i in 1..<path.count {
            context.addLine(to: getCoordinates(for: path[i]))
        }

        context.setStrokeColor(#colorLiteral(red: 0, green: 0.1826862782, blue: 0.7505155457, alpha: 0.4952910959))
        context.setLineCap(.round)
        context.setLineDash(phase: CGFloat(10), lengths: [CGFloat(15), CGFloat(10)])
        context.strokePath()
    }

    func drawPassedPath(from: GraphNode, to: GraphNode) {
        // MOCK: отрисовка пройденных стеллажей
        // закрасить from вершину
        // закрасить ребро
        // закрасить to вершину
    }
}

extension Constants {
    static let lineWidth = CGFloat(5)
    static let xCellCount: CGFloat = 20
    static let yCellCount: CGFloat = 20
    static let cellWidth: CGFloat = 20
}
