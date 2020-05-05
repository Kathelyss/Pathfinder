import UIKit

protocol PathModule: Presentable {

}

final class PathViewController: BaseConfigurableController<PathViewModel>, PathModule {

    private let separatorView = BaseSeparatorView()
    private let emptyView = EmptyView()

    private var scrollView = UIScrollView()
    private var mapView = UIImageView()
    private var searchButton = UIButton()
    private var clearButton = UIButton()

    var pathView: PathView!
    var isPathViewAdded = false
    var lastTappedButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        scrollViewDidZoom(scrollView)

        if !isPathViewAdded {
            pathView = PathView(frame: mapView.bounds)
            pathView.backgroundColor = .clear
            mapView.addSubview(pathView)
            isPathViewAdded = true

            pathView.allPathNodes = viewModel.path
        }
    }
    
    override func addViews() {
        super.addViews()

        view.addSubview(separatorView)
        view.addSubview(mapView)
        view.addSubview(emptyView)
    }

    override func configureLayout() {
        super.configureLayout()

        separatorView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(actualLayoutGuide)
            $0.height.equalTo(Constants.separatorHeight)
        }

        emptyView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        mapView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide).inset(Constants.defaultInset)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.tabbarHeight + Constants.defaultInset)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        emptyView.configure(with: .noPath)

        mapView.contentMode = .scaleAspectFit
        mapView.image = .gridlessPlanImage
        setupScrollView()
        clearButton.isHidden = true
        emptyView.isHidden = !mapView.isHidden
    }
    
    override func localize() {
        super.localize()

        navigationItem.title = "Маршрут"
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
        } catch PathfinderError.noSourceNode {
            showErrorAlert(message: "Пункт отправления не найден.\nПроверьте номер помещения!")
        } catch PathfinderError.noDestinationNode {
            showErrorAlert(message: "Пункт назначения не найден.\nПроверьте номер помещения!")
        } catch {
            showErrorAlert(message: "Что-то пошло не так")
        }
    }

    func tapClearRouteButton(_ sender: UIButton) {
        viewModel.path.removeAll()
        pathView.allPathNodes = viewModel.path
        pathView.startView.isHidden = true
        pathView.endView.isHidden = true
        clearButton.isHidden = true
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Oшибка", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(cancel)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(alert, animated: true, completion: nil)
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
        scrollView.contentSize = mapView.frame.size
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = mapView.frame.size
        let scrollViewSize = scrollView.bounds.size
        let verticalPadding = imageViewSize.height < scrollViewSize.height ?
            (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ?
            (scrollViewSize.width - imageViewSize.width) / 2 : 0
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding,
                                               bottom: verticalPadding, right: horizontalPadding)
    }
}
