import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let applicationCoordinator: ApplicationCoordinatorInterface = {
        ApplicationCoordinator(router: AppRouter(),
                               moduleFactory: ModuleFactory(),
                               coordinatorFactory: CoordinatorFactory())
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        applicationCoordinator.start()

        return true
    }
}
