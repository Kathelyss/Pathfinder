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

        module.onItemTap = { [weak self] itemCoordinates in
            self?.showPathModule(itemCoordinates)
        }

        router.setRootModule(module)
    }

    private func showPathModule(_ pinCoordinates: Int) {
        // открывается карта с отметкой товара (show path module с пином по координатам товара)
        let module = moduleFactory.createPathModule()
        router.pushModule(module, animated: true, hideNavBar: false)
    }
}
