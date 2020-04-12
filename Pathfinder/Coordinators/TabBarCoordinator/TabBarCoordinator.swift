import UIKit

final class TabBarCoordinator: BaseCoordinator {

    private let applicationStorage: ApplicationStorage
    private let tabBarModule: TabBarModule
    private let storage: TabBarStorage
    private let moduleFactory: ModuleFactory
    private let coordinatorFactory: CoordinatorFactory

    init(applicationStorage: ApplicationStorage,
         storage: TabBarStorage,
         moduleFactory: ModuleFactory,
         coordinatorFactory: CoordinatorFactory) {
        self.storage = storage
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        self.tabBarModule = storage.tabBarModule
        self.applicationStorage = applicationStorage
    }

    override func start() {
        let controllers = TabBarItem.allCases.map { makeTabBarItemCoordinator(for: $0).toPresent() }
        tabBarModule.onModuleLoaded = { tabBarController in
            tabBarController.setViewControllers(controllers, tabBarItems: TabBarItem.allCases)
        }
    }

    private func makeTabBarItemCoordinator(for item: TabBarItem) -> Presentable {

        let rootController = NavigationController()

        let router = Router(navigationController: rootController)
        let coordinator: Coordinatable

        switch item {
        case .general:
            coordinator = GeneralCoordinator(router: router,
                                             moduleFactory: moduleFactory,
                                             mainStorage: storage)
        case .waybill:
            coordinator = WaybillCoordinator(router: router,
                                             moduleFactory: moduleFactory,
                                             mainStorage: storage)

        case .path:
            coordinator = PathCoordinator(router: router,
                                          moduleFactory: moduleFactory,
                                          mainStorage: storage)
        }

        coordinator.onFinish = onFinish
        add(child: coordinator)
        coordinator.start()

        return rootController
    }

    private func switchTabBarItem(to index: Int, isInitial: Bool) {
        tabBarModule.switchTab(to: index)
    }
}
