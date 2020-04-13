import UIKit

struct EmptyViewModel {
    let title: String
    let description: String
    let image: UIImage
}

extension EmptyViewModel {

    static let general = EmptyViewModel(title: "Пока ничего нет",
                                        description: "Возможные опции отобразятся здесь, как только заработает бекенд",
                                        image: .tabBarGeneral)

    static let waybill = EmptyViewModel(title: "Пока ничего нет",
                                        description: "Список товаров из накладной отобразится здесь, как только заработает бекенд",
                                        image: .tabBarWaybill)

    static let path = EmptyViewModel(title: "Пока ничего нет",
                                     description: "Оптимальный маршрут отобразится здесь, как только заработает бекенд",
                                     image: .tabBarPath)
}
