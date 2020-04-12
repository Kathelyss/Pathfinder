import UIKit

protocol Presentable: class {

    func toPresent() -> UIViewController
}

// MARK: - Default implementation for UIViewController
extension Presentable where Self: UIViewController {

    func toPresent() -> UIViewController {
        self
    }
}

extension UIAlertController: Presentable { }
extension UINavigationController: Presentable { }
