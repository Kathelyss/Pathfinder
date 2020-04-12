import UIKit

protocol ListModule: Presentable {

}

final class ListViewController: UIViewController, InitializableView, ListModule {

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
    }

    func localize() {
        navigationItem.title = "Накладная"
    }
}
