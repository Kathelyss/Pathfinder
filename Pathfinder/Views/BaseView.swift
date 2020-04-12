import UIKit

class BaseView: UIView, InitializableView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        initializeView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - InitializableView

    func addViews() {
        // empty for subclasses overriding
    }

    func bindViews() {
        // empty for subclasses overriding
    }

    func configureLayout() {
        // empty for subclasses overriding
    }

    func configureAppearance() {
        // empty for subclasses overriding
    }

    func localize() {
        // empty for subclasses overriding
    }
}
