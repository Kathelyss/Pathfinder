import Foundation

protocol PathModuleFactory {

    func createPathModule(title: String, graph: [GraphNode], items: [GraphNode]) -> PathModule
}
