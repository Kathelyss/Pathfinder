import Foundation

protocol WaybillModuleFactory {

    func createWaybillModule() -> WaybillModule
    func createPathModule(title: String, graph: [Node], items: [Node]) -> PathModule
}
