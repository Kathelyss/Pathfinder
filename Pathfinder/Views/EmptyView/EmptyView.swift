import UIKit
import SnapKit

final class EmptyView: BasePlaceholderView {

    override func addViews() {
        super.addViews()

        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(centerImageView)
    }

    override func configureLayout() {
        super.configureLayout()

        centerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.size.equalTo(100)
        }

        titleLabel.snp.makeConstraints { make in
            make.width.centerX.equalToSuperview()
            make.bottom.equalTo(centerImageView.snp.top).offset(-Constants.bigInset)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(centerImageView.snp.bottom).offset(Constants.bigInset)
            make.leading.trailing.equalToSuperview().inset(Constants.hugeInset)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = .monospacedDigitSystemFont(ofSize: 24, weight: .medium)
        titleLabel.textColor = .systemGreen

        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .monospacedDigitSystemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = UIColor.systemGreen.withAlphaComponent(0.7)

        centerImageView.tintColor = UIColor.systemGreen.withAlphaComponent(0.4)
    }
}

extension EmptyView: ConfigurableView {
    
    func configure(with viewModel: EmptyViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        centerImageView.image = viewModel.image
    }
}
