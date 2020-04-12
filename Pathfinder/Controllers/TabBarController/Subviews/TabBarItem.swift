import UIKit

enum TabBarItem: Int, CaseIterable {
    case info
    case list
    case map

    var tabBarItem: TabBarItemView {
        TabBarItemView(title: title, image: image)
    }
}

private extension TabBarItem {

    var title: String {
        switch self {
        case .info:
            return "Инфо"

        case .list:
            return "Накладная"

        case .map:
            return "Карта"
        }
    }

    var image: UIImage {
        switch self {
        case .info:
            return .add

        case .list:
            return .actions

        case .map:
            return .remove
        }
    }
}
