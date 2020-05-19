import UIKit

class BaseCoordinator: Coordinatable {

    private(set) var childCoordinators: [Coordinatable] = []

    // MARK: - Coordinatable

    var onFinish: ParameterClosure<Coordinatable>?

    func start() {
        assertionFailure("Method start() has not been implemented")
    }

    // MARK: - Public

    func add(child coordinator: Coordinatable) {
        for element in childCoordinators where element === coordinator {
            remove(child: element)
            return
        }
        childCoordinators.append(coordinator)
    }

    func remove(child coordinator: Coordinatable?) {
        guard childCoordinators.isNotEmpty else {
            return
        }
        guard let coordinator = coordinator else {
            return
        }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            return
        }
    }

    func finishFlow() {
        onFinish?(self)
    }

    /// Создать стандартую связь между координаторами:
    /// Добавить передаваемый координатор в качестве дочернего, а по завершению убрать из дочерних
    @discardableResult
    func bindTo(_ coordinator: Coordinatable) -> Coordinatable {
        coordinator.onFinish = { [weak self] in
            self?.remove(child: $0)
        }
        add(child: coordinator)

        return coordinator
    }
}
