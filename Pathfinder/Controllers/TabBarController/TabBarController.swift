import UIKit

protocol TabBarModule: Presentable {

    var onModuleLoaded: ParameterClosure<TabBarController>? { get set }

    func switchTab(to tabIndex: Int)
}

final class TabBarController: UIViewController, InitializableView, TabBarModule {

    private var tabBarItems: [TabBarItemView]?

    override var childForStatusBarStyle: UIViewController? {
        selectedViewController
    }

    // MARK: - TabBarModule

    var onModuleLoaded: ParameterClosure<TabBarController>?

    func switchTab(to tabIndex: Int) {
        selectedIndex = tabIndex
    }

    // MARK: - UITabBarController Inteface Copy

    private(set) var selectedViewController: UIViewController?

    let tabBar = TabBarView()

    var viewControllers: [UIViewController]?

    var selectedIndex: Int = 0 {
        didSet {
            selectViewController(atIndex: selectedIndex)
        }
    }

    func setViewControllers(_ viewControllers: [UIViewController]?, tabBarItems: [TabBarItem]?) {
        self.viewControllers = viewControllers
        self.tabBarItems = tabBarItems?.map { $0.tabBarItem }
        self.tabBarItems?.enumerated().forEach {
            $0.element.tag = $0.offset
        }
        tabBar.setItems(self.tabBarItems)
        selectViewController(atIndex: selectedIndex)
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
        tabBar.delegate = self
        onModuleLoaded?(self)
    }

    // MARK: - Initializable View

    func addViews() {

        view.addSubview(tabBar)
    }

    func configureLayout() {

        tabBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
            make.height.equalTo(Constants.tabBarHeight)
        }
    }

    func configureAppearance() {
        view.backgroundColor = .white
    }

    // MARK: - Private

    private func selectViewController(atIndex index: Int) {
        if let controller = viewControllers?[index],
            let item = tabBarItems?[index],
            selectedViewController != controller {

            tabBar.selectedItem = item
            changeChildController(to: controller)
            setNeedsStatusBarAppearanceUpdate()
            postNotification(withIndex: index)
        }
    }

    private func changeChildController(to controller: UIViewController) {

        selectedViewController?.removeFromParentController()

        addChildController(controller, container: view)
        view.bringSubviewToFront(tabBar)

        controller.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        selectedViewController = controller
    }

    private func postNotification(withIndex index: Int) {
        NotificationCenter.default.post(name: .tabBarDidSelectIndex,
                                        object: self,
                                        userInfo: [Constants.tabBarUserInfoKey: index])
    }
}

// MARK: - TabBarViewDelegate
extension TabBarController: TabBarViewDelegate {

    func tabBar(_ tabBar: TabBarView, didSelect item: TabBarItemView) {
        let index = item.tag
        selectViewController(atIndex: index)
    }
}

// MARK: - Constants
private extension Constants {
    static let tabBarHeight: CGFloat = 80
    static let tabBarRevealedSafeArea = Constants.tabBarHeight
    static let tabBarPartiallyRevealedOffset = tabBarRevealedSafeArea * 0.7
    static let tabBarPartiallyRevealedSafeArea = Constants.tabBarRevealedSafeArea - Constants.tabBarPartiallyRevealedOffset

    static let tabBarUserInfoKey = "TabBarSelectedIndex"
}

extension Notification.Name {
    static let tabBarDidSelectIndex = Notification.Name("tabBarDidSelectIndex")
}
