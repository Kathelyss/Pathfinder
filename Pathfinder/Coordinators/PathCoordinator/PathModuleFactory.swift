import Foundation

protocol PathModuleFactory {

    func createPathModule(title: String, graph: [Node], items: [Node]) -> PathModule
}
