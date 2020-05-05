import UIKit

protocol GeneralModule: Presentable {

}

final class GeneralViewController: BaseConfigurableController<GeneralViewModel>, GeneralModule {

    private let separatorView = BaseSeparatorView()
    private let emptyView = EmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }

    override func addViews() {
        super.addViews()

        view.addSubview(separatorView)
        view.addSubview(emptyView)
    }

    override func configureLayout() {
        super.configureLayout()

        separatorView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(actualLayoutGuide)
            make.height.equalTo(Constants.separatorHeight)
        }

        emptyView.snp.makeConstraints { make in
            make.top.equalTo(actualLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        emptyView.configure(with: .noGeneralInfo)
    }

    override func localize() {
        super.localize()

        navigationItem.title = "Данные"
    }
}
