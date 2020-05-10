import UIKit

class PathView: UIView {

    let lineWidth = CGFloat(5)
    var nodes: [Node] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    public override func draw(_ rect: CGRect) {
        guard !nodes.isEmpty else {
            return
        }

        guard let context = UIGraphicsGetCurrentContext() else {
            print("Error: no context found!")
            return
        }

        context.setLineWidth(lineWidth)

        nodes.forEach { drawCircle(nodeLocation: getCoordinates(for: $0)) }
//        let startPoint = getCoordinates(for: nodes[0])
//        context.move(to: startPoint)
//        var nextPoint = CGPoint(x: 0, y: 0)
//        for i in 1..<nodes.count {
//            nextPoint = getCoordinates(for: nodes[i])
//            context.addLine(to: nextPoint)
//        }
//
//        context.setStrokeColor(#colorLiteral(red: 0, green: 0.1826862782, blue: 0.7505155457, alpha: 0.4952910959))
//        context.setLineCap(.round)
//        context.setLineDash(phase: CGFloat(10), lengths: [CGFloat(15), CGFloat(10)])
//        context.strokePath()
//        if let first = nodes.first, let pathStart = allPathNodes.first, first != pathStart {
//            drawCircle(nodeLocation: getCoordinates(for: first))
//        }
//        if let last = nodes.last, let pathEnd = allPathNodes.last, last != pathEnd, nodes.count > 1 {
//            drawArrow(penultimateNodeLocation: getCoordinates(for: nodes[nodes.count - 2]),
//                      lastNodeLocation: getCoordinates(for: last))
//        }
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
        context.setFillColor(UIColor.systemTeal.cgColor)
        context.fillPath()
    }

    func drawArrow(penultimateNodeLocation: CGPoint, lastNodeLocation: CGPoint) {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Error: no context found!")
            return
        }

        var firstPoint = CGPoint(x: 0, y: 0)
        var secondPoint = CGPoint(x: 0, y: 0)
        context.setLineWidth(lineWidth)
        let arrowOffset = CGFloat(8)
        if lastNodeLocation.x < penultimateNodeLocation.x {
            firstPoint = CGPoint(x: lastNodeLocation.x + arrowOffset, y: lastNodeLocation.y + arrowOffset)
            secondPoint = CGPoint(x: lastNodeLocation.x + arrowOffset, y: lastNodeLocation.y - arrowOffset)
            //to left
        } else if lastNodeLocation.x > penultimateNodeLocation.x {
            firstPoint = CGPoint(x: lastNodeLocation.x - arrowOffset, y: lastNodeLocation.y + arrowOffset)
            secondPoint = CGPoint(x: lastNodeLocation.x - arrowOffset, y: lastNodeLocation.y - arrowOffset)
            //to right
        } else if lastNodeLocation.y < penultimateNodeLocation.y {
            firstPoint = CGPoint(x: lastNodeLocation.x - arrowOffset, y: lastNodeLocation.y + arrowOffset)
            secondPoint = CGPoint(x: lastNodeLocation.x + arrowOffset, y: lastNodeLocation.y + arrowOffset)
            //up
        } else if lastNodeLocation.y > penultimateNodeLocation.y {
            firstPoint = CGPoint(x: lastNodeLocation.x - arrowOffset, y: lastNodeLocation.y - arrowOffset)
            secondPoint = CGPoint(x: lastNodeLocation.x + arrowOffset, y: lastNodeLocation.y - arrowOffset)
            //down
        }
        context.setLineCap(.round)
        context.setLineDash(phase: CGFloat(0), lengths: [CGFloat(1), CGFloat(0)])
        context.move(to: firstPoint)
        context.addLine(to: lastNodeLocation)
        context.addLine(to: secondPoint)

        context.setStrokeColor(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        context.strokePath()
    }

    func getCoordinates(for node: Node) -> CGPoint {
        let xMultiplier = bounds.size.width / Constant.xCellCount
        let yMultiplier = bounds.size.height / Constant.yCellCount
        return CGPoint(x: (node.coordinates.x * xMultiplier + lineWidth) * 10,
                       y: (node.coordinates.y * yMultiplier + lineWidth) * 10)
    }
}

struct Constant {
    public static let xCellCount = CGFloat(37.5)
    public static let yCellCount = CGFloat(57)
}
