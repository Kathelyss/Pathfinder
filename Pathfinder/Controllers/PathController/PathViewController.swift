import UIKit
import RxCocoa
import RxSwift

protocol PathModule: Presentable {

}

final class PathViewController: BaseConfigurableController<PathViewModel>, PathModule, UIScrollViewDelegate {

    private let emptyView = EmptyView()
    private var upperInfoView = UpperInfoView()
    private var planImageView = UIImageView()
    private var nextPositionButton = StyledButton()
    private var planView: PlanView!
    private var isMapViewAdded = false

    private let disposeBag = DisposeBag()

    private var scrollView = UIScrollView()


    override func viewDidLoad() {
        super.viewDidLoad()

        initialLoadView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        scrollViewDidZoom(scrollView)
        drawMap()
    }
    
    override func addViews() {
        super.addViews()

        scrollView.addSubview(planImageView)
        view.addSubview(scrollView)
        view.addSubview(emptyView)
        view.addSubview(upperInfoView)
        view.addSubview(nextPositionButton)
    }

    override func bindViews() {
        super.bindViews()

        upperInfoView.onButtonTap = { [weak viewModel] in
            viewModel?.createRoute()
        }

        upperInfoView.onClearRoute = { [weak self] in
            self?.clearRoute()
        }

        viewModel.itemsRecievedDriver
            .drive(onNext: { [weak self] in
                self?.drawItems()
            })
            .disposed(by: disposeBag)

        viewModel.pathFoundDriver
            .drive(onNext: { [weak self] in
                self?.drawPath()
            })
            .disposed(by: disposeBag)

        nextPositionButton.addTarget(self, action: #selector(handleNewPassedPosition), for: .touchUpInside)
    }

    override func configureLayout() {
        super.configureLayout()

        emptyView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        upperInfoView.snp.makeConstraints {
            $0.top.equalTo(actualLayoutGuide).inset(Constants.smallInset)
            $0.leading.trailing.equalToSuperview().inset(Constants.smallInset)
            $0.height.lessThanOrEqualTo(80)
        }

        planImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.lessThanOrEqualToSuperview().inset(Constants.defaultInset)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(upperInfoView.snp.bottom).offset(Constants.defaultInset)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.bottomOffset)
        }

        nextPositionButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.bottomOffset)
            $0.size.equalTo(CGSize(width: 80, height: 35))
        }
    }

    override func configureAppearance() {
        super.configureAppearance()

        hidesBottomBarWhenPushed = true
        view.backgroundColor = .white
        setupScrollView()
        emptyView.isHidden = !planImageView.isHidden
        upperInfoView.isHidden = viewModel.navigationTitle != "Маршрут"
        nextPositionButton.isHidden = true
    }

    override func localize() {
        super.localize()

        navigationItem.title = viewModel.navigationTitle
        emptyView.configure(with: .noPath)
        upperInfoView.configure(with: .mockInfo)
        nextPositionButton.setTitle("Далее", for: .normal)
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

    @objc
    func clearRoute() {
        viewModel.path = []
        planView.path = []
        nextPositionButton.isHidden = true
    }

    @objc
    func handleNewPassedPosition() {
        // MOCK: add new node passing drawing
    }

    func drawMap() {
        if !isMapViewAdded {
            isMapViewAdded = true
            planView = PlanView(frame: planImageView.bounds)
            planView.backgroundColor = .clear
            planImageView.addSubview(planView)

//            mapView.shelfs = viewModel.positions
            planView.items = viewModel.items
        }
    }

    func drawItems() {
        planView.items = viewModel.items
    }

    func drawPath() {
        planView.path = viewModel.path
        nextPositionButton.isHidden = false
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

extension Constants {
    static let bottomOffset: CGFloat = Constants.tabbarHeight + Constants.smallInset
}
