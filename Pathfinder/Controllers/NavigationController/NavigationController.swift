import UIKit

final class NavigationController: UINavigationController, InitializableView, UIGestureRecognizerDelegate {

    enum Style {
        case white
        case gray

        var color: UIColor {
            switch self {
            case .white:
                return .white

            case .gray:
                return .gray
            }
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        interactivePopGestureRecognizer?.delegate = self
    }

    // MARK: - Methods

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)

        if let viewController = viewControllers.last {
            handleNewViewController(viewController)
        }
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)

        handleNewViewController(viewController)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        let controller = super.popViewController(animated: animated)

        handlePopOfViewController(controller)

        return controller
    }

    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let controllers = super.popToRootViewController(animated: animated)

        handlePopOfViewController(controllers?.first)

        return controllers
    }

    // MARK: - Initializable View

    func configureAppearance() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()

        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.systemGreen,
            .font: UIFont.monospacedSystemFont(ofSize: 20, weight: .medium)
        ]

        view.backgroundColor = .white
    }

    // MARK: - Private

    private func handleNewViewController(_ viewController: UIViewController?) {
        if viewControllers.count > 1 {
            viewController?.setBackButton()
        }

        let animationDelay: TimeInterval = 0.005 // this is necessary, so that "viewWillDissappear" is called after
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDelay) {
            if viewController?.hidesBottomBarWhenPushed ?? false {
//                TabBarAnimator.shared.changeTabBarPosition(to: .hidden)
            }
        }
    }

    private func handlePopOfViewController(_ viewController: UIViewController?) {
        hideBottomBarIfNeeded(for: viewController)
        handleNewViewController(topViewController)
    }

    private func hideBottomBarIfNeeded(for viewController: UIViewController?) {
        if viewController?.hidesBottomBarWhenPushed ?? false, !(topViewController?.hidesBottomBarWhenPushed ?? true) {
//            TabBarAnimator.shared.changeTabBarPosition(to: .revealed)
        }
    }
}
