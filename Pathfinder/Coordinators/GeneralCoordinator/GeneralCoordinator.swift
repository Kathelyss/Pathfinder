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
