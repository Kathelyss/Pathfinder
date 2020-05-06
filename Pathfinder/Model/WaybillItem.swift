struct Article {
    let id: Int
    let name: String
    let description: String
}

struct ItemLocation {
    let rackNumber: Int
    let shelfNumber: Int
    let position: Int
    let coordinate: Coordinate
}

struct Coordinate {
    let x: Int
    let y: Int
}

struct WaybillItem {
    let id: Int
    let article: Article
    let quantity: Int
    let location: ItemLocation
}


struct MockEndPoints {

    static let articles = [Article](repeating: Article(id: 1,
                                                       name: "Батарейка",
                                                       description: "Это моканый артикль ура"),
                                    count: 15)

    static let items = [WaybillItem](repeating: WaybillItem(id: 1,
                                                            article: Article(id: 1,
                                                                             name: "Батарейка",
                                                                             description: "Это моканый артикль ура"),
                                                            quantity: 5,
                                                            location: ItemLocation(rackNumber: 1,
                                                                                   shelfNumber: 2,
                                                                                   position: 3,
                                                                                   coordinate: Coordinate(x: 15, y: 7))),
                                     count: 15)
}
