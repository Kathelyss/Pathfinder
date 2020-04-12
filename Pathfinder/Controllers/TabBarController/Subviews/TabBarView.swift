import UIKit
import SnapKit

final class TabBarView: BaseView {

    private let stackView = UIStackView()
    private let roundedContainer = UIView()
    private var isObserving = true

    override var isUserInteractionEnabled: Bool {
        didSet {
            if isObserving {
                isObserving = false
                roundedContainer.isUserInteractionEnabled = isUserInteractionEnabled
                isUserInteractionEnabled = true
                isObserving = true
            }
        }
    }

    // MARK: - UITabBar Interface Copy

    weak var delegate: TabBarViewDelegate?

    var items: [TabBarItemView]?

    var selectedItem: TabBarItemView? {
        didSet {
            items?.forEach { item in
                item.setState(.default)
            }
            selectedItem?.setState(.selected)
        }
    }

    func setItems(_ items: [TabBarItemView]?) {
        self.items = items

        items?.forEach { currentItem in
            currentItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemTapHandler)))
            stackView.addArrangedSubview(currentItem)
        }
    }

    // MARK: - Life Cycle

    override func addViews() {
        super.addViews()

        addSubview(roundedContainer)
        roundedContainer.addSubview(stackView)
    }

    override func configureLayout() {
        super.configureLayout()

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        roundedContainer.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill

        roundedContainer.layer.cornerRadius = Constants.cornerRadius
        roundedContainer.clipsToBounds = true

        layer.cornerRadius = Constants.cornerRadius
    }

    override func layoutSubviews() {
        super.layoutSubviews()

//        addRoundedShadow(shadowColor: .vtbDarkBlue,
//                         shadowOpacity: 0.1,
//                         shadowOffset: CGSize(width: 0, height: 22),
//                         shadowRadius: 22)
    }

    // MARK: - Private functions

    @objc private func itemTapHandler(_ tapGestureRecognizer: UITapGestureRecognizer) {

        guard let tappedView = tapGestureRecognizer.view as? TabBarItemView else {
            return
        }

        delegate?.tabBar(self, didSelect: tappedView)
    }
}
