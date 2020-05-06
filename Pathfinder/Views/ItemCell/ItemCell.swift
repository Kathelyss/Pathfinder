import UIKit
import TableKit

final class ItemCell: UITableViewCell, InitializableView, ConfigurableCell {

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let forwardIcon = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initializeView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addViews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(forwardIcon)
    }

    func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Constants.smallInset)
            $0.leading.equalToSuperview().inset(Constants.mediumInset)
            $0.trailing.equalTo(forwardIcon.snp.leading).offset(-Constants.smallInset)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.tinyInset)
            $0.leading.equalToSuperview().inset(Constants.mediumInset)
            $0.trailing.equalTo(forwardIcon.snp.leading).offset(-Constants.smallInset)
            $0.bottom.equalToSuperview().inset(Constants.smallInset)
        }

        forwardIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Constants.smallInset)
            $0.height.equalTo(35)
        }
    }

    func configureAppearance() {
        titleLabel.font = .monospacedSystemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .systemGreen

        subtitleLabel.font = .monospacedSystemFont(ofSize: 12, weight: .regular)
        subtitleLabel.textColor = .systemGray
        subtitleLabel.numberOfLines = 0

        forwardIcon.image = .forwardIcon
        forwardIcon.tintColor = .systemGray
        forwardIcon.contentMode = .scaleAspectFit
    }
    
    func configure(with viewModel: ItemCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        forwardIcon.isHidden = viewModel.isIconHidden
    }
}
