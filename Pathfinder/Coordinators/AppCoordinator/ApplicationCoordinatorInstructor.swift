import Foundation

final class ApplicationCoordinatorInstructor: CoordinatorInstructor {

    func getCurrentState() -> ApplicationState {
        return .mainFlow
    }
}
