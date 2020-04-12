import UIKit

protocol GeneralModule: Presentable {

}

final class GeneralViewController: UIViewController, InitializableView, GeneralModule {

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
    }

    func localize() {
        navigationItem.title = "Основной экран"
    }
}
