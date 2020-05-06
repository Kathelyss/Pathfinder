import UIKit

final class UpperInfoView: BaseView {

    private let roundedContainer = UIView()
    private var titleLabel = UILabel()

    override func layoutSubviews() {
        super.layoutSubviews()

        addRoundedShadow()
    }

    override func addViews() {
        super.addViews()

        addSubview(roundedContainer)
        roundedContainer.addSubview(titleLabel)
    }

    override func configureLayout() {
        super.configureLayout()

        roundedContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.tinyInset)
            $0.top.bottom.equalToSuperview().inset(Constants.tinyInset)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        roundedContainer.layer.cornerRadius = Constants.cornerRadius
        roundedContainer.clipsToBounds = true
        roundedContainer.backgroundColor = .white
        layer.cornerRadius = Constants.cornerRadius

        titleLabel.textColor = .systemBlue
        titleLabel.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
    }
}

extension UpperInfoView: ConfigurableView {

    func configure(with viewModel: UpperInfoViewModel) {
        titleLabel.text = viewModel.text
    }
}
