import UIKit
import ObjectiveC

private var associatedObjectHandle: UInt8 = 0

// MARK: - Embed in navigation

extension UIViewController {

    func embedInNavigation() -> NavigationController {
        NavigationController(rootViewController: self)
    }
}

// MARK: - Async present

extension UIViewController {

    func asyncPresent(_ controller: UIViewController, animated: Bool = true, completion: VoidBlock? = nil) {
        DispatchQueue.main.async { [weak self] in
            self?.present(controller, animated: animated, completion: completion)
        }
    }
}

// MARK: - Add and remove child controller

extension UIViewController {

    func addChildController(_ viewController: UIViewController, container: UIView? = nil) {
        addChild(viewController)
        container?.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }

    func removeFromParentController() {
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

// MARK: - Back buttons

extension UIViewController {

    func setBackButton(with action: Selector = #selector(defaultBackAction)) {
        let backButtonItem = UIBarButtonItem(image: .navigationBack,
                                             style: .plain,
                                             target: self,
                                             action: action)
        navigationItem.leftBarButtonItem = backButtonItem
    }

    func setCloseButton(with action: Selector? = nil, alignLeft: Bool = true) {
        let action = action ?? #selector(defaultCloseAction)
        let closeButtonItem = UIBarButtonItem(image: .navigationClose,
                                              style: .plain,
                                              target: self,
                                              action: action)

        if alignLeft {
            navigationItem.leftBarButtonItem = closeButtonItem
        } else {
            navigationItem.rightBarButtonItem = closeButtonItem
        }
    }

    // MARK: - Actions
    @objc private func defaultBackAction() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func defaultCloseAction() {
        dismiss(animated: true, completion: nil)
    }
}
