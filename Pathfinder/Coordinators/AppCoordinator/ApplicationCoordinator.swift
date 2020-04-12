import Foundation

final class ApplicationCoordinator: BaseCoordinator {

    // MARK: - Properties

    private let instructor: ApplicationCoordinatorInstructor
    private let router: AppRouter
    private let moduleFactory: ApplicationModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let storage: ApplicationStorage

    private var tabBarCoordinator: Coordinatable?

    // MARK: - Initialization

    init(router: AppRouter, moduleFactory: ApplicationModuleFactory, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
        let storage = ApplicationStorage()
        self.storage = storage
        self.instructor = ApplicationCoordinatorInstructor()
    }

    // MARK: - Start

    override func start() {
        handleCurrentState()
    }

    // MARK: - Flows

    private func runMainFlow() {
        let group = coordinatorFactory.makeMainCoordinator(applicationStorage: storage, mainStorage: MainStorage())

        tabBarCoordinator = group.coordinator

        group.coordinator.onFinish = { [weak self] in
            self?.tabBarCoordinator = nil
            self?.remove(child: $0)
        }

        add(child: group.coordinator)
        group.coordinator.start()

        router.setWindowRoot(module: group.presentable)
    }

    // MARK: - Helpers

    private func handleCurrentState() {
        switch instructor.getCurrentState() {
        case .mainFlow:
            runMainFlow()
        }
    }
}

// MARK: - ApplicationCoordinatorInterface
extension ApplicationCoordinator: ApplicationCoordinatorInterface {

}
