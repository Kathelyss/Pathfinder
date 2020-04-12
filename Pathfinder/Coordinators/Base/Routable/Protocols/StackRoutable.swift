import UIKit

protocol StackRoutable {

    var navigationController: UINavigationController? { get }

    func pushModule(_ module: Presentable, animated: Bool, hideNavBar: Bool)
    func popModule(animated: Bool)
    func popToRoot(animated: Bool)
    func setRootModule(_ module: Presentable, animated: Bool, hideNavBar: Bool)
    func clearStack()
}

extension StackRoutable {

    func pushModule(_ module: Presentable, animated: Bool = true, hideNavBar: Bool = false) {
        navigationController?.isNavigationBarHidden = hideNavBar
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(module.toPresent(), animated: animated)
    }

    func popModule(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }

    func setRootModule(_ module: Presentable, animated: Bool = true, hideNavBar: Bool = false) {
        let controller = module.toPresent()
        navigationController?.isNavigationBarHidden = hideNavBar
        navigationController?.setViewControllers([controller], animated: animated)
    }

    func clearStack() {
        // animated must be false, otherwise it doesn't work.
        navigationController?.setViewControllers([], animated: false)
    }
}
