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

    static let items = [WaybillItem(article: Article(name: "Батарейка АА", description: ""), quantity: 7,
                                    location: ItemLocation(rackNumber: 1, shelfNumber: 4, position: 12, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Провод USB-C", description: ""), quantity: 2,
                                    location: ItemLocation(rackNumber: 12, shelfNumber: 5, position: 1, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Зарядка Lightning", description: ""), quantity: 7,
                                    location: ItemLocation(rackNumber: 5, shelfNumber: 5, position: 4, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Роутер Mi", description: ""), quantity: 1,
                                    location: ItemLocation(rackNumber: 3, shelfNumber: 7, position: 9, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Клавиатура Smartbuy", description: ""), quantity: 1,
                                    location: ItemLocation(rackNumber: 6, shelfNumber: 3, position: 3, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Мышь defender", description: ""), quantity: 10,
                                    location: ItemLocation(rackNumber: 5, shelfNumber: 2, position: 8, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Салфетки для монитора", description: ""), quantity: 13,
                                    location: ItemLocation(rackNumber: 4, shelfNumber: 1, position: 10, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Наушники AirPods", description: ""), quantity: 1,
                                    location: ItemLocation(rackNumber: 11, shelfNumber: 7, position: 15, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Часы AppleWatch", description: ""), quantity: 1,
                                    location: ItemLocation(rackNumber: 35, shelfNumber: 5, position: 7, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Колонка JBL", description: ""), quantity: 3,
                                    location: ItemLocation(rackNumber: 8, shelfNumber: 4, position: 20, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Переходник USB-C - jack", description: ""), quantity: 2,
                                    location: ItemLocation(rackNumber: 7, shelfNumber: 6, position: 16, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Зарядное устройство для MacBook Pro", description: ""), quantity: 4,
                                    location: ItemLocation(rackNumber: 16, shelfNumber: 2, position: 4, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Карта памяти 64GB", description: ""), quantity: 2,
                                    location: ItemLocation(rackNumber: 1, shelfNumber: 1, position: 5, coordinate: CGPoint(x: 7, y: 10))),
                        WaybillItem(article: Article(name: "Флеш-накопитель", description: ""), quantity: 6,
                                    location: ItemLocation(rackNumber: 21, shelfNumber: 1, position: 2, coordinate: CGPoint(x: 7, y: 10)))]

    static let nodes = [GraphNode(coordinates: CGPoint(x: 0, y: 0), isEntrance: true), GraphNode(coordinates: CGPoint(x: 0, y: 1)),
                        GraphNode(coordinates: CGPoint(x: 0, y: 2)), GraphNode(coordinates: CGPoint(x: 0, y: 3)),
                        GraphNode(coordinates: CGPoint(x: 1, y: 0)), GraphNode(coordinates: CGPoint(x: 1, y: 3)),
                        GraphNode(coordinates: CGPoint(x: 2, y: 0)), GraphNode(coordinates: CGPoint(x: 2, y: 1)),
                        GraphNode(coordinates: CGPoint(x: 2, y: 3)), GraphNode(coordinates: CGPoint(x: 3, y: 0)),
                        GraphNode(coordinates: CGPoint(x: 3, y: 1)), GraphNode(coordinates: CGPoint(x: 3, y: 2)),
                        GraphNode(coordinates: CGPoint(x: 3, y: 3))]
}
// передать стеллажи
// 
