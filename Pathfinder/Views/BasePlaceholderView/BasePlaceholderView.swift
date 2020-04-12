import UIKit

/// Layoutless placeholder view. This class is used as views holder & configurator.
/// You should inherit it and implement layout.
open class BasePlaceholderView: UIView, InitializableView {

    /// Title label of placeholder view.
    public let titleLabel = UILabel()

    /// Description label of placeholder view.
    public let descriptionLabel = UILabel()

    /// Center image view of placeholder view.
    public let centerImageView = UIImageView()

    /// Action button of placeholder view.
    public private(set) lazy var button = createButton()

    public override init(frame: CGRect) {
        super.init(frame: frame)

        initializeView()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Subclass override

    /// Override to create your own subclass button.
    ///
    /// - Returns: UIButton (sub)class.
    open func createButton() -> UIButton {
        return UIButton()
    }

    // MARK: - InitializableView

    open func addViews() {
        // override in subclass
    }

    open func bindViews() {
        // override in subclass
    }

    open func configureAppearance() {
        // override in subclass
    }

    open func localize() {
        // override in subclass
    }

    open func configureLayout() {
        // override in subclass
    }
}

public extension BasePlaceholderView {

    /// Method for base configuration BasePlaceholderView instance.
    ///
    /// - Parameter viewModel: Placeholder view visual attributes without layout.
    func baseConfigure(with viewModel: BasePlaceholderViewModel) {
//        titleLabel.configure(with: viewModel.title)
//
//        descriptionLabel.isHidden = !viewModel.hasDescription
//        viewModel.description?.configure(view: descriptionLabel)
//
//        centerImageView.isHidden = !viewModel.hasCenterImage
//        centerImageView.image = viewModel.centerImage
//
//        button.isHidden = !viewModel.hasButton
//        viewModel.buttonTitle?.configure(view: button)
    }
}
