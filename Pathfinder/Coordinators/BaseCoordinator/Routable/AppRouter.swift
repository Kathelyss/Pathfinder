import UIKit

final class AppRouter {

    private var windows: [UIWindow.Level.AppLevel: UIWindow] = [:]

    let window: UIWindow

    var rootController: UIViewController? {
        window.rootViewController
    }

    convenience init() {
        let level = UIWindow.Level.AppLevel.normal
        let window = UIWindow(level: level)
        self.init(window: window)
    }

    init(window: UIWindow) {
        self.window = window
    }

    func openWindow(withModule presentable: Presentable, level: UIWindow.Level.AppLevel = .normal) {
        let window = windows[level] ?? UIWindow(level: level)
        windows[level] = window

        if !window.isKeyWindow {
            window.makeKeyAndVisible()
        }
        
        window.changeRootController(controller: presentable.toPresent(), animated: true)
    }

    func closeWindow(level: UIWindow.Level.AppLevel = .normal) {
        guard let window = windows[level] else {
            return
        }

        windows[level] = nil
        window.rootViewController?.view.isUserInteractionEnabled = false
        window.rootViewController = nil
        window.isHidden = true
    }
}

// MARK: - WindowRoutable
extension AppRouter: AppRoutable {}

// MARK: - ModalRoutable
extension AppRouter: ModalRoutable {}
