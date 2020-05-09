import UIKit

final class UpperInfoView: BaseView {

    private let stackView = UIStackView()
    private let routeButton = StyledButton()
    private let roundedContainer = UIView()
    private var titleLabel = UILabel()

    var onButtonTap: VoidBlock?

    override func layoutSubviews() {
        super.layoutSubviews()

        addRoundedShadow()
    }

    override func addViews() {
        super.addViews()

        roundedContainer.addSubview(titleLabel)
        [roundedContainer, routeButton].forEach {
            stackView.addArrangedSubview($0)
        }
        addSubview(stackView)
    }

    override func bindViews() {
        super.bindViews()

        routeButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    override func configureLayout() {
        super.configureLayout()

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        routeButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }

        roundedContainer.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(80)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.tinyInset)
            $0.top.bottom.equalToSuperview().inset(Constants.tinyInset)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center

        roundedContainer.isHidden = true
        roundedContainer.layer.cornerRadius = Constants.cornerRadius
        roundedContainer.clipsToBounds = true
        roundedContainer.backgroundColor = .white
        layer.cornerRadius = Constants.cornerRadius

        titleLabel.textColor = .systemBlue
        titleLabel.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }

    override func localize() {
        super.localize()

        routeButton.setTitle("Построить маршрут", for: .normal)
    }

    @objc private func buttonAction() {
        layoutIfNeeded()
//        roundedContainer.isHidden = false
//        routeButton.isHidden = true
        onButtonTap?()
    }
}

extension UpperInfoView: ConfigurableView {

    func configure(with viewModel: UpperInfoViewModel) {
        titleLabel.text = viewModel.text
    }
}
