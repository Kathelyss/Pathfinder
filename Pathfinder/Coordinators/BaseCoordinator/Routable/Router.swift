import UIKit

final class Router {

    private(set) weak var navigationController: UINavigationController?

    var rootController: UIViewController? {
        navigationController
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: - ModalRoutable
extension Router: ModalRoutable {}

// MARK: - StackRoutable
extension Router: StackRoutable {}
