import UIKit

final class RequestButtonsView: BaseView {

    private let stackView = UIStackView()
    private let updateWarehouseStateButton = StyledButton()
    private let requestWaybillButton = StyledButton()
    private let clearTaskButton = StyledButton()

    var onUpdateButtonTap: VoidBlock?
    var onRequestButtonTap: VoidBlock?
    var onClearButtonTap: VoidBlock?

    override func addViews() {
        super.addViews()

        [updateWarehouseStateButton, requestWaybillButton, clearTaskButton].forEach {
            stackView.addArrangedSubview($0)
        }

        addSubview(stackView)
    }

    override func configureLayout() {
        super.configureLayout()

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        stackView.axis = .horizontal
        stackView.spacing = Constants.smallInset
        stackView.distribution = .fillEqually
    }

    override func bindViews() {
        super.bindViews()

        updateWarehouseStateButton.addTarget(self, action: #selector(updateButtonAction), for: .touchUpInside)
        requestWaybillButton.addTarget(self, action: #selector(requestButtonAction), for: .touchUpInside)
        clearTaskButton.addTarget(self, action: #selector(clearButtonAction), for: .touchUpInside)
    }

    override func localize() {
        super.localize()

        updateWarehouseStateButton.setTitle("Обновить склад", for: .normal)
        requestWaybillButton.setTitle("Получить накладную", for: .normal)
        clearTaskButton.setTitle("Очистить задание", for: .normal)
    }
}

// MARK: - Actions

private extension RequestButtonsView {

    @objc func updateButtonAction() {
        onUpdateButtonTap?()
    }

    @objc func requestButtonAction() {
        onRequestButtonTap?()
    }

    @objc func clearButtonAction() {
        onClearButtonTap?()
    }
}
