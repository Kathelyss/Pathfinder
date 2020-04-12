import UIKit

protocol ApplicationModuleFactory {

}

extension ModuleFactory: InfoModuleFactory {}
extension ModuleFactory: ListModuleFactory {}
extension ModuleFactory: MapModuleFactory {}
