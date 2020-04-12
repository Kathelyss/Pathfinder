import UIKit
import SnapKit

final class TabBarItemView: BaseView {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private var currentState: State = .default

    // MARK: - Life Cycle

    init(title: String, image: UIImage) {
        super.init(frame: .zero)

        titleLabel.text = title
        imageView.image = image
    }

    override func addViews() {
        super.addViews()

        addSubview(imageView)
        addSubview(titleLabel)
    }

    override func configureLayout() {
        super.configureLayout()

        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.smallInset)
            make.centerX.equalToSuperview()
            make.width.equalTo(imageView.snp.height)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constants.tinyInset)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.tinyInset)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        configureAppearance(forState: currentState)

        titleLabel.textAlignment = .center
    }

    // MARK: - Public

    func setState(_ state: State) {
        currentState = state
        configureAppearance(forState: state)
    }

    // MARK: - Private

    private func configureAppearance(forState state: State) {
        titleLabel.textColor = state.textColor
        imageView.tintColor = state.tintColor
        backgroundColor = state.backgroundColor
    }
}

extension TabBarItemView {

    enum State {
        case selected
        case `default`

        var textColor: UIColor {
            switch self {
            case .selected:
                return .white

            case .default:
                return .systemGreen
            }
        }

        var tintColor: UIColor {
            switch self {
            case .selected:
                return .white

            case .default:
                return .systemGreen
            }
        }

        var backgroundColor: UIColor {
            switch self {
            case .selected:
                return UIColor.systemGreen.withAlphaComponent(0.8)

            case .default:
                return .white
            }
        }
    }
}
