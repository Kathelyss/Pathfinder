/// Protocol with methods that should be called in constructor methods of view.
public protocol InitializableView {

    /// Main method that should call other methods in particular order.
    func initializeView()

    /// Method for adding views to current view.
    func addViews()

    /// Method for binding to data or user actions.
    func bindViews()

    /// Appearance configuration method.
    func configureAppearance()

    /// Localization method.
    func localize()

    /// Confgiure layout of subviews.
    func configureLayout()
}

public extension InitializableView {

    func initializeView() {
        addViews()
        configureLayout()
        bindViews()
        configureAppearance()
        localize()
    }

    func addViews() {
        //
    }

    func bindViews() {
        //
    }

    func configureAppearance() {
        //
    }

    func localize() {
        //
    }

    func configureLayout() {
        //
    }
}
