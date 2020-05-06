import UIKit

struct EmptyViewModel {
    let title: String
    let description: String
    let image: UIImage
}

extension EmptyViewModel {

    static let noGeneralInfo = EmptyViewModel(title: "Пока ничего нет",
                                              description: "Загрузите конфигурацию склада и накладную для начала работы",
                                              image: .tabBarGeneral)

    static let noWaybill = EmptyViewModel(title: "Пока ничего нет",
                                          description: "Упорядоченный список товаров из накладной отобразится здесь, как только завершится расчёт",
                                          image: .tabBarWaybill)

    static let noPath = EmptyViewModel(title: "Пока ничего нет",
                                       description: "Карта склада отобразится здесь, как только завершится загрузка",
                                       image: .tabBarPath)
}
