import Foundation

final class MapCoordinator: BaseCoordinator {

    private let router: Router
    private let moduleFactory: MapModuleFactory
    private let mainStorage: MainStorage

    init(router: Router,
         moduleFactory: MapModuleFactory,
         mainStorage: MainStorage) {

        self.router = router
        self.moduleFactory = moduleFactory
        self.mainStorage = mainStorage
    }

    override func start() {
        showMapModule()
    }

    // MARK: - Module

    private func showMapModule() {
        let module = moduleFactory.createMapModule()
        router.setRootModule(module)
    }
}
