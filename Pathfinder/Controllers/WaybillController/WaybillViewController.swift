import UIKit

protocol WaybillModule: Presentable {
    var onItemTap: ParameterClosure<Coordinate>? { get set }
    var onStorageClear: VoidBlock? { get set }
}

final class WaybillViewController: BaseConfigurableController<WaybillViewModel>, WaybillModule {

    private let emptyView = EmptyView()
    private let tableView = UITableView()

    var onItemTap: ParameterClosure<Coordinate>?
    var onStorageClear: VoidBlock?

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
        configureTableView()
        // MOCK: replace on automatic data loading
        viewModel.getOrderedWaybillItems()
    }

    override func addViews() {
        super.addViews()

        view.addSubview(emptyView)
        view.addSubview(tableView)
    }

    override func configureLayout() {
        super.configureLayout()

        emptyView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.tabbarHeight)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        emptyView.configure(with: .noWaybill)
        // MOCK: replace on automatic data loading
        tableView.isHidden = false
        emptyView.isHidden = true
    }

    override func localize() {
        super.localize()

        navigationItem.title = "Накладная"
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseIdentifier)
        tableView.alwaysBounceVertical = true
    }
}

// MARK: - UITableViewDelegate

extension WaybillViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onItemTap?(viewModel.orderedItems[indexPath.row].location.coordinate)
    }
}

// MARK: - UITableViewDataSource

extension WaybillViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.orderedItems.count
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

