import UIKit

final class StyledButton: UIButton {

    override public var isHighlighted: Bool {
        didSet {
            titleColor = isHighlighted ? .white : .systemTeal
            backgroundColor = isHighlighted ? .systemTeal : .white
        }
    }

    // MARK: - Initializer

    init() {
        super.init(frame: .zero)

        configureAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        addRoundedShadow()
    }

    func configureAppearance() {
        backgroundColor = .white
        titleColor = .systemTeal
        textFont = .monospacedSystemFont(ofSize: 14, weight: .medium)
        titleLabel?.numberOfLines = 0
        titleLabel?.textAlignment = .center
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemTeal.cgColor
        layer.cornerRadius = Constants.cornerRadius
    }
}
