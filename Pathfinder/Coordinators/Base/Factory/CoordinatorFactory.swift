import Foundation

final class CoordinatorFactory {

    private let moduleFactory = ModuleFactory()

    func makeMainCoordinator(applicationStorage: ApplicationStorage,
                             mainStorage: MainStorage) -> CoordinatorGroup<TabBarCoordinatorProtocol> {

        let tabBarModule = moduleFactory.createTabBarModule()
        let storage = TabBarStorage(mainStorage: mainStorage, tabBarModule: tabBarModule)
        let coordinator = TabBarCoordinator(applicationStorage: applicationStorage,
                                            storage: storage,
                                            moduleFactory: moduleFactory,
                                            coordinatorFactory: self)

        return CoordinatorGroup(coordinator: coordinator, presentable: tabBarModule)
    }
}
