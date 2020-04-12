import Foundation

final class InfoCoordinator: BaseCoordinator {

    private let router: Router
    private let moduleFactory: InfoModuleFactory
    private let mainStorage: MainStorage

    init(router: Router,
         moduleFactory: InfoModuleFactory,
         mainStorage: MainStorage) {

        self.router = router
        self.moduleFactory = moduleFactory
        self.mainStorage = mainStorage
    }

    override func start() {
        showInfoModule()
    }

    // MARK: - Module

    private func showInfoModule() {
        let module = moduleFactory.createInfoModule()
        router.setRootModule(module)
    }
}
