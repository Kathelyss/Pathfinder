import UIKit

protocol WaybillModule: Presentable {

}

final class WaybillViewController: UIViewController, InitializableView, WaybillModule {

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
    }

    func localize() {
        navigationItem.title = "Накладная"
    }
}
