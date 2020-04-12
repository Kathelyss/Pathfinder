import UIKit

protocol InfoModule: Presentable {

}

final class InfoViewController: UIViewController, InitializableView, InfoModule {

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
    }

    func localize() {
        navigationItem.title = "Основной экран"
    }
}
