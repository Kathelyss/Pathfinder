import UIKit

protocol MapModule: Presentable {

}

final class MapViewController: UIViewController, MapModule {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
    }
}
