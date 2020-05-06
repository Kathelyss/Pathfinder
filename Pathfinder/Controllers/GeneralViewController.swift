import UIKit
import TableKit

protocol GeneralModule: Presentable {

}

final class GeneralViewController: BaseConfigurableController<GeneralViewModel>, GeneralModule {

    private let emptyView = EmptyView()
    private let buttonsView = RequestButtonsView()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
        configureTableView()
    }

    override func addViews() {
        super.addViews()

        view.addSubview(emptyView)
        view.addSubview(buttonsView)
        view.addSubview(tableView)
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

        tableView.snp.makeConstraints {
            $0.top.equalTo(buttonsView.snp.bottom).offset(Constants.smallInset)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.tabbarHeight)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        emptyView.configure(with: .noGeneralInfo)
        tableView.isHidden = true
        emptyView.isHidden = false
    }

    override func localize() {
        super.localize()

        navigationItem.title = "Данные"
    }

    override func bindViews() {
        super.bindViews()

        buttonsView.onUpdateButtonTap = {
            // MOCK: /getStorageInfo - plan image + matrix
        }

        buttonsView.onRequestButtonTap = { [weak self] in
            self?.viewModel.requestWaybill()
            self?.tableView.isHidden = false
            self?.tableView.reloadData()
        }

        buttonsView.onClearButtonTap = { [weak self] in
            self?.viewModel.currentWaybillItems.removeAll()
            self?.tableView.isHidden = true
            self?.tableView.reloadData()
        }
    }

    private func configureTableView() {
        tableView.dataSource = self

        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        tableView.alwaysBounceVertical = true
        tableView.allowsSelection = false
    }
}

// MARK: - UITableViewDataSource

extension GeneralViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currentWaybillItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseIdentifier,
                                                    for: indexPath) as? ItemCell {
            let cellViewModel = viewModel.cellModels[indexPath.row]
            cell.configure(with: cellViewModel)
            return cell
        }
        fatalError("Cell couldn't be dequeued")
    }
}
