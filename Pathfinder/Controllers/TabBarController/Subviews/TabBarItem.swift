import UIKit

enum TabBarItem: Int, CaseIterable {
    case map

    var tabBarItem: TabBarItemView {
        TabBarItemView(title: title, image: image)
    }
}

private extension TabBarItem {

    var title: String {
        switch self {
        case .map:
            return "Map"
        }
    }

    var image: UIImage {
        switch self {
        case .map:
            return .tabBarMap
        }
    }
}
