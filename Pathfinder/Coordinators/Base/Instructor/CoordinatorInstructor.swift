import Foundation

protocol CoordinatorInstructor {

    associatedtype Instruction: InstructorState

    func getCurrentState() -> Instruction
}
