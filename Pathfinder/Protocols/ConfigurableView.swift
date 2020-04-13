import UIKit

/**
 *  Protocol that ensures that specific type can can apply new view state with view model
 */
public protocol ConfigurableView {
    associatedtype ViewModelType

    /**
     Applies new view state with view model object

     - parameter viewModel: view model to apply new view state

     - returns: nothing
     */
    func configure(with _: ViewModelType)
}

public extension ConfigurableView where Self: UIView {

    /// Convenience initializer for configurable UIView subclass.
    ///
    /// - Parameter viewModel: View model to configure view after initialization.
    init(viewModel: ViewModelType) {
        self.init()
        self.configure(with: viewModel)
    }
}
