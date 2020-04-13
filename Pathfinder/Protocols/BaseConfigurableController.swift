import UIKit

/// Base controller that should be configured with view model.
open class BaseConfigurableController<ViewModel>: UIViewController, ConfigurableController {

    /// A view model instance used by this controller.
    public let viewModel: ViewModel

    /// Initializer with view model parameter.
    ///
    /// - Parameter viewModel: A view model to configure this controller.
    public init(viewModel: ViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ConfigurableController

    open func addViews() {
        // override in subclass
    }

    open func configureLayout() {
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

    open func configureBarButtons() {
        // override in subclass
    }
}
