import UIKit

protocol MapModule: Presentable {

}

final class MapViewController: UIViewController, InitializableView, MapModule {

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
    }

    func localize() {
        navigationItem.title = "Карта склада"
    }
}
