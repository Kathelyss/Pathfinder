import UIKit

protocol GeneralModule: Presentable {

}

final class GeneralViewController: BaseConfigurableController<GeneralViewModel>, GeneralModule {

    private let emptyView = EmptyView()
    private let buttonsView = RequestButtonsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }

    override func addViews() {
        super.addViews()

        view.addSubview(emptyView)
        view.addSubview(buttonsView)
    }

    override func configureLayout() {
        super.configureLayout()

        emptyView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        buttonsView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide).inset(Constants.smallInset)
            $0.leading.trailing.equalToSuperview().inset(Constants.smallInset)
            $0.height.equalTo(40)
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

    override func bindViews() {
        super.bindViews()

        buttonsView.onUpdateButtonTap = {
            // /getStorageInfo
        }

        buttonsView.onRequestButtonTap = {
            // /getWaybill -> результат отображается таблицей под кнопками
        }

        buttonsView.onClearButtonTap = {
            // mainStorage.clear()
        }
    }
}

