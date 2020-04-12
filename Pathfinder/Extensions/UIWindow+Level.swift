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

extension UIWindow {

    /// Method changes root controller in window.
    ///
    /// - Parameter controller: New root controller.
    /// - Parameter animated: Indicates whether to use animation or not.
    public func changeRootController(controller: UIViewController, animated: Bool = true) {
        
    }
}
