import Foundation

protocol WaybillModuleFactory {

    func createWaybillModule() -> WaybillModule
    func createPathModule(title: String, graph: [GraphNode], items: [GraphNode]) -> PathModule
}
