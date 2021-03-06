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

        module.onItemTap = { [weak self] item in
            self?.showPathModule(item)
        }

        router.setRootModule(module)
    }

    private func showPathModule(_ item: WaybillItem) {
        let module = moduleFactory.createPathModule(title: item.article.name,
                                                    graph: [],
                                                    items: [GraphNode(coordinates: item.location.coordinate)])
        router.pushModule(module, animated: true, hideNavBar: false)
    }
}
