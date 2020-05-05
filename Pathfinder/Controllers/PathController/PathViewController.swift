import UIKit

protocol PathModule: Presentable {

}

final class PathViewController: BaseConfigurableController<PathViewModel>, PathModule {

    private let emptyView = EmptyView()
    private var planImageView = UIImageView()
    private var upperInfoView = UpperInfoView()

    private var scrollView = UIScrollView()
    private var clearButton = UIButton()

    var pathView: PathView!
    var isPathViewAdded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        scrollViewDidZoom(scrollView)

        if !isPathViewAdded {
            pathView = PathView(frame: planImageView.bounds)
            pathView.backgroundColor = .clear
            planImageView.addSubview(pathView)
            isPathViewAdded = true

            pathView.allPathNodes = viewModel.path
        }

        showSuccessView()
    }
    
    override func addViews() {
        super.addViews()

        view.addSubview(planImageView)
        view.addSubview(emptyView)
        view.addSubview(upperInfoView)
    }

    override func configureLayout() {
        super.configureLayout()

        emptyView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        planImageView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide).inset(Constants.defaultInset)
            $0.leading.trailing.equalToSuperview().inset(Constants.defaultInset)
            $0.bottom.equalToSuperview().inset(Constants.tabbarHeight + Constants.defaultInset)
        }

        upperInfoView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide).inset(Constants.smallInset)
            $0.leading.trailing.equalToSuperview().inset(Constants.defaultInset)
            $0.height.lessThanOrEqualTo(80)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        planImageView.contentMode = .scaleAspectFit
        planImageView.image = .smallPlanImage
        setupScrollView()
        clearButton.isHidden = true
        emptyView.isHidden = !planImageView.isHidden
//        upperInfoView.isHidden = !isPathViewAdded
    }

    override func localize() {
        super.localize()

        emptyView.configure(with: .noPath)
        upperInfoView.configure(with: .mockInfo)
        navigationItem.title = "Маршрут"
    }
}

// MARK: - Alerts

private extension PathViewController {

    func showSuccessView() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)

        let titleFont = [NSAttributedString.Key.font: UIFont.monospacedSystemFont(ofSize: 16, weight: .bold)]
        let messageFont = [NSAttributedString.Key.font: UIFont.monospacedSystemFont(ofSize: 14, weight: .medium)]

        let titleAttrString = NSMutableAttributedString(string: "Корзина собрана", attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: "Комплектация товара завершена.\n\nОчистить маршрут?",
                                                          attributes: messageFont)

        alert.setValue(titleAttrString, forKey: "attributedTitle")
        alert.setValue(messageAttrString, forKey: "attributedMessage")

        alert.addAction(UIAlertAction(title: "Очистить", style: .default, handler: nil))
        // handler: clearRoute + /updateStorageInfo

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.maxY, width: 0, height: 0)
            popoverController.permittedArrowDirections = [.down]
        }

        present(alert, animated: true)
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Oшибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - LEGACY

extension PathViewController {

    func drawPath(fromText: String = "", toText: String = "") {
        do {
            let path = try viewModel.findPath(in: viewModel.allNodes, from: fromText, to: toText)
            viewModel.path = path
            pathView.allPathNodes = viewModel.path
            clearButton.isHidden = false
            setPins()
        } catch PathfinderError.noPathFound {
            showErrorAlert(message: "Невозможно построить маршрут")
        } catch {
            showErrorAlert(message: "Что-то пошло не так")
        }
    }

    func tapClearRouteButton(_ sender: UIButton) {
        viewModel.path.removeAll()
        pathView.allPathNodes = viewModel.path
        [pathView.startView, pathView.endView, clearButton].forEach {
            $0.isHidden = true
        }
    }

    func setPins() {
        if let startNodeForCurrentFloor = pathView.nodes.first, let pathStartNode = pathView.allPathNodes.first,
            startNodeForCurrentFloor == pathStartNode {
            pathView.startView.center = pathView.getCoordinates(for: pathStartNode)
            pathView.startView.isHidden = false
        } else {
            pathView.startView.isHidden = true
        }
        if let lastNodeForCurrentFloor = pathView.nodes.last, let pathEndNode = pathView.allPathNodes.last,
            lastNodeForCurrentFloor == pathEndNode {
            pathView.endView.center = pathView.getCoordinates(for: pathEndNode)
            pathView.endView.isHidden = false
        } else {
            pathView.endView.isHidden = true
        }
    }

    func setupScrollView() {
        scrollView.minimumZoomScale = 0.65
        scrollView.zoomScale = scrollView.minimumZoomScale
        scrollView.contentSize = planImageView.frame.size
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return planImageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = planImageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        let verticalPadding = imageViewSize.height < scrollViewSize.height ?
            (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ?
            (scrollViewSize.width - imageViewSize.width) / 2 : 0
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding,
                                               bottom: verticalPadding, right: horizontalPadding)
    }
}
