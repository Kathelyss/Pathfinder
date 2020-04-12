import UIKit

protocol AppRoutable {

    var window: UIWindow { get }

    func setWindowRoot(module: Presentable, animated: Bool)
    func makeWindowKeyAndVisible()

    func openWindow(withModule presentable: Presentable, level: UIWindow.Level.AppLevel)
    func closeWindow(level: UIWindow.Level.AppLevel)
}

extension AppRoutable {

    func setWindowRoot(module: Presentable, animated: Bool = true) {
        window.changeRootController(controller: module.toPresent(), animated: animated)
    }

    func makeWindowKeyAndVisible() {
        window.makeKeyAndVisible()
    }
}
