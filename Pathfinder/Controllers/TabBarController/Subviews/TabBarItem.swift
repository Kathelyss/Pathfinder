import UIKit

enum TabBarItem: Int, CaseIterable {
    case general
    case path

    var tabBarItem: TabBarItemView {
        TabBarItemView(title: title, image: image)
    }
}

private extension TabBarItem {

    var title: String {
        switch self {
        case .general:
            return "Данные"

        case .path:
            return "Маршрут"
        }
    }

    var image: UIImage {
        switch self {
        case .general:
            return .tabBarWaybill

        case .path:
            return .tabBarPath
        }
    }
}
