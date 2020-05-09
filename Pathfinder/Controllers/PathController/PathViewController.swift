import UIKit

protocol PathModule: Presentable {

}

final class PathViewController: BaseConfigurableController<PathViewModel>, PathModule, UIScrollViewDelegate {

    private let emptyView = EmptyView()
    private var planImageView = UIImageView()
    private var upperInfoView = UpperInfoView()

    private var scrollView = UIScrollView()

    var pathView: PathView!
    var isPathViewAdded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        scrollViewDidZoom(scrollView)
        drawItemPositions()
    }
    
    override func addViews() {
        super.addViews()

        scrollView.addSubview(planImageView)
        view.addSubview(scrollView)
        view.addSubview(emptyView)
        view.addSubview(upperInfoView)
    }

    override func bindViews() {
        super.bindViews()

        upperInfoView.onButtonTap = { [weak viewModel] in
            viewModel?.createRoute()
        }
    }

    override func configureLayout() {
        super.configureLayout()

        emptyView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide).inset(Constants.defaultInset)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.tabbarHeight + Constants.defaultInset)
        }

        planImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.lessThanOrEqualToSuperview()
        }

        upperInfoView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide).inset(Constants.smallInset)
            $0.leading.trailing.equalToSuperview().inset(Constants.defaultInset)
            $0.height.lessThanOrEqualTo(80)
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        hidesBottomBarWhenPushed = true
        view.backgroundColor = .white
        setupScrollView()
//        planImageView.contentMode = .scaleAspectFit
        planImageView.image = .smallPlanImage
        emptyView.isHidden = !planImageView.isHidden
        upperInfoView.isHidden = viewModel.navigationTitle != "Маршрут"
    }

    override func localize() {
        super.localize()

        emptyView.configure(with: .noPath)
        upperInfoView.configure(with: .mockInfo)
        navigationItem.title = viewModel.navigationTitle
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return planImageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //        let imageViewSize = planImageView.frame.size
        //        let scrollViewSize = scrollView.bounds.size
        //        let verticalPadding = imageViewSize.height < scrollViewSize.height
        //            ? (scrollViewSize.height - imageViewSize.height) / 2
        //            : 0
        //        let horizontalPadding = imageViewSize.width < scrollViewSize.width
        //            ? (scrollViewSize.width - imageViewSize.width) / 2
        //            : 0
        //        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding,
        //                                               bottom: verticalPadding, right: horizontalPadding)
    }
}

private extension PathViewController {

    func drawItemPositions() {
        if !isPathViewAdded {
            isPathViewAdded = true
            pathView = PathView(frame: planImageView.bounds)
            pathView.backgroundColor = .clear
            planImageView.addSubview(pathView)

            pathView.nodes = viewModel.positions
        }
    }

    func presentSuccessfullResultAlert() {
        // MOCK: add handler: clearRoute + /updateStorageInfo
        let alert = UIAlertController.successfullResultActionSheet()

        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.maxY, width: 0, height: 0)
            popoverController.permittedArrowDirections = [.down]
        }
        present(alert, animated: true)
    }

    // MARK: - Scroll View Setup

    func setupScrollView() {
        //        scrollView.minimumZoomScale = 0.2
        scrollView.zoomScale = scrollView.minimumZoomScale
        scrollView.contentSize = CGSize(width: view.bounds.width * 2, height: view.bounds.height * 2)//planImageView.frame.size
    }

}
