import Foundation

final class ListCoordinator: BaseCoordinator {

    private let router: Router
    private let moduleFactory: ListModuleFactory
    private let mainStorage: MainStorage

    init(router: Router,
         moduleFactory: ListModuleFactory,
         mainStorage: MainStorage) {

        self.router = router
        self.moduleFactory = moduleFactory
        self.mainStorage = mainStorage
    }

    override func start() {
        showListModule()
    }

    // MARK: - Module

    private func showListModule() {
        let module = moduleFactory.createListModule()
        router.setRootModule(module)
    }
}
