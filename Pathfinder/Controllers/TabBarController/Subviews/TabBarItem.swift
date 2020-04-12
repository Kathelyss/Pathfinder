import UIKit

enum TabBarItem: Int, CaseIterable {
    case info
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

        case .map:
            return "Карта"
        }
    }

    var image: UIImage {
        switch self {
        case .info:
            return .actions

        case .map:
            return .add
        }
    }
}
