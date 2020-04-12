import Foundation

final class PathCoordinator: BaseCoordinator {

    private let router: Router
    private let moduleFactory: PathModuleFactory
    private let mainStorage: MainStorage

    init(router: Router,
         moduleFactory: PathModuleFactory,
         mainStorage: MainStorage) {

        self.router = router
        self.moduleFactory = moduleFactory
        self.mainStorage = mainStorage
    }

    override func start() {
        showPathModule()
    }

    // MARK: - Module

    private func showPathModule() {
        let module = moduleFactory.createPathModule()
        router.setRootModule(module)
    }
}
