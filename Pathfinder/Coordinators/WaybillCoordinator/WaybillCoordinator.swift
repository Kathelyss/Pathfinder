import Foundation

final class WaybillCoordinator: BaseCoordinator {

    private let router: Router
    private let moduleFactory: WaybillModuleFactory
    private let mainStorage: MainStorage

    init(router: Router,
         moduleFactory: WaybillModuleFactory,
         mainStorage: MainStorage) {

        self.router = router
        self.moduleFactory = moduleFactory
        self.mainStorage = mainStorage
    }

    override func start() {
        showWaybillModule()
    }

    // MARK: - Module

    private func showWaybillModule() {
        let module = moduleFactory.createWaybillModule()
        router.setRootModule(module)
    }
}
