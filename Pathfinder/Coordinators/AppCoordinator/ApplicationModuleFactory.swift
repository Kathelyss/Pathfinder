import UIKit

protocol ApplicationModuleFactory {

}

extension ModuleFactory: GeneralModuleFactory {}
extension ModuleFactory: WaybillModuleFactory {}
extension ModuleFactory: PathModuleFactory {}
