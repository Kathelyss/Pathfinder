import UIKit

extension UIWindow.Level {

    enum AppLevel: Int {
        case normal = 0
        case alert
        case error

        var value: UIWindow.Level {
            UIWindow.Level.normal + CGFloat(rawValue)
        }
    }
}

extension UIWindow {

    convenience init(level: UIWindow.Level.AppLevel) {
        self.init(frame: UIScreen.main.bounds)
        windowLevel = level.value
    }
}

public extension UIWindow {

    /// default scale
    static let snapshotScale: CGFloat = 1.5
    /// default root controller animation duration
    static let snapshotAnimationDuration = 0.5

    /// Method changes root controller in window.
    ///
    /// - Parameter controller: New root controller.
    /// - Parameter animated: Indicates whether to use animation or not.
    func changeRootController(controller: UIViewController, animated: Bool = true) {
        if animated {
            animateRootViewControllerChanging(controller: controller)
        }

        let previousRoot = rootViewController
        previousRoot?.dismiss(animated: false) {
            previousRoot?.view.removeFromSuperview()
        }

        rootViewController = controller
        makeKeyAndVisible()
    }

    /**
     method animates changing root controller

     - parameter controller: new root controller
     */
    private func animateRootViewControllerChanging(controller: UIViewController) {
        if let snapshot = snapshotView(afterScreenUpdates: true) {
            controller.view.addSubview(snapshot)
            UIView.animate(withDuration: UIWindow.snapshotAnimationDuration, animations: {
                snapshot.layer.opacity = 0.0
                snapshot.layer.transform = CATransform3DMakeScale(UIWindow.snapshotScale,
                                                                  UIWindow.snapshotScale,
                                                                  UIWindow.snapshotScale)
            }, completion: { _ in
                snapshot.removeFromSuperview()
            })
        }
    }
}
