import UIKit

protocol WaybillModule: Presentable {

}

final class WaybillViewController: BaseConfigurableController<WaybillViewModel>, WaybillModule {

    private let emptyView = EmptyView()

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }

    override func addViews() {
        super.addViews()

        view.addSubview(emptyView)
    }

    override func configureLayout() {
        super.configureLayout()

        emptyView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        emptyView.configure(with: .noWaybill)
    }

    override func localize() {
        super.localize()

        navigationItem.title = "Накладная"
    }
}
