import UIKit

protocol ModalRoutable {

    var rootController: UIViewController? { get }

    func presentModule(_ module: Presentable,
                       animated: Bool,
                       embedInNavigation navigationStyle: NavigationController.Style?,
                       completion: VoidBlock?)
    func dismissModule(animated: Bool, completion: VoidBlock?)
}

extension ModalRoutable {

    func presentModule(_ module: Presentable,
                       animated: Bool = true,
                       embedInNavigation navigationStyle: NavigationController.Style? = nil,
                       completion: VoidBlock? = nil) {

        let controller: UIViewController
        if navigationStyle != nil {
            controller = module.toPresent().embedInNavigation()
        } else {
            controller = module.toPresent()
        }

        rootController?.asyncPresent(controller, animated: animated, completion: completion)
    }

    func dismissModule(animated: Bool = true, completion: VoidBlock? = nil) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
}

