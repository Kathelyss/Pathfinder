import CoreGraphics

struct Article {
    let name: String
    let description: String
}

struct ItemLocation {
    let rackNumber: Int
    let shelfNumber: Int
    let position: Int
    let coordinate: CGPoint
}

struct WaybillItem {
    let article: Article
    let quantity: Int
    let location: ItemLocation
}

struct MockEndPoints {

    static let articles = [Article](repeating: Article(name: "Батарейка",
                                                       description: "Это моканый артикль ура"),
                                    count: 15)

    static let items = [WaybillItem](repeating: WaybillItem(article: Article(name: "Батарейка",
                                                                             description: "Это моканый артикль ура"),
                                                            quantity: 5,
                                                            location: ItemLocation(rackNumber: 1,
                                                                                   shelfNumber: 2,
                                                                                   position: 3,
                                                                                   coordinate: CGPoint(x: 1, y: 3))),
                                     count: 15)

    static let nodes = [Node(coordinates: CGPoint(x: 0, y: 0), isEntrance: true), Node(coordinates: CGPoint(x: 0, y: 1)),
                        Node(coordinates: CGPoint(x: 0, y: 2)), Node(coordinates: CGPoint(x: 0, y: 3)),
                        Node(coordinates: CGPoint(x: 1, y: 0)), Node(coordinates: CGPoint(x: 1, y: 3)),
                        Node(coordinates: CGPoint(x: 2, y: 0)), Node(coordinates: CGPoint(x: 2, y: 1)),
                        Node(coordinates: CGPoint(x: 2, y: 3)), Node(coordinates: CGPoint(x: 3, y: 0)),
                        Node(coordinates: CGPoint(x: 3, y: 1)), Node(coordinates: CGPoint(x: 3, y: 2)),
                        Node(coordinates: CGPoint(x: 3, y: 3))]
}
