import Foundation

protocol WaybillModuleFactory {

    func createWaybillModule() -> WaybillModule
    func createPathModule() -> PathModule
}
