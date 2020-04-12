import Foundation

final class GeneralCoordinator: BaseCoordinator {

    private let router: Router
    private let moduleFactory: GeneralModuleFactory
    private let mainStorage: MainStorage

    init(router: Router,
         moduleFactory: GeneralModuleFactory,
         mainStorage: MainStorage) {

        self.router = router
        self.moduleFactory = moduleFactory
        self.mainStorage = mainStorage
    }

    override func start() {
        showGeneralModule()
    }

    // MARK: - Module

    private func showGeneralModule() {
        let module = moduleFactory.createGeneralModule()
        router.setRootModule(module)
    }
}
