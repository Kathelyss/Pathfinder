import UIKit

protocol PathModule: Presentable {

}

final class PathViewController: UIViewController, InitializableView, PathModule {

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
    }

    func localize() {
        navigationItem.title = "Карта склада"
    }
}
