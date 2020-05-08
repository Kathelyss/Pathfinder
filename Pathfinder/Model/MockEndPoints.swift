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
                                                                                   coordinate: CGPoint(x: 15, y: 7))),
                                     count: 15)
}
