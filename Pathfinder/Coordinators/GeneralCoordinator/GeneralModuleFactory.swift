import Foundation

protocol GeneralModuleFactory {

    func createGeneralModule() -> GeneralModule
    func createPathModule(title: String, graph: [GraphNode], items: [GraphNode]) -> PathModule
}
