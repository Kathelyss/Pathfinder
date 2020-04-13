import UIKit

public protocol ConfigurableController: InitializableView {

    associatedtype ViewModelT

    var viewModel: ViewModelT { get }

    func configureBarButtons()

    func initialLoadView()
}

public extension ConfigurableController where Self: UIViewController {

    func initializeView() {
        assertionFailure("Use \(String(describing: initialLoadView)) for UIViewController instead!")
    }

    /// Method that should be called in viewDidLoad method of UIViewController.
    func initialLoadView() {
        addViews()
        configureLayout()
        configureAppearance()
        configureBarButtons()
        localize()
        bindViews()
    }
}
