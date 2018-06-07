import UIKit
import AVFoundation
import Presentr

public final class ImageViewerController: UIViewController {
    
    @IBOutlet weak var favourButtonOutlet: UIButton!
  
    var isFavorite = false {
        didSet{
            if self.isFavorite {
                favourButtonOutlet.setImage(UIImage(named: "like_fill_small"), for: .normal)
            }else{
                favourButtonOutlet.setImage(UIImage(named: "like_out_small"), for: .normal)
            }
        }
    }
    
    @IBOutlet fileprivate var scrollView: UIScrollView!
    @IBOutlet fileprivate var imageView: UIImageView!
    @IBOutlet fileprivate var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var transitionHandler: ImageViewerTransitioningHandler?
    fileprivate let configuration: ImageViewerConfiguration?
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: presentr configuration
    let presenter: Presentr = {
        let customPresenter = Presentr(presentationType: .fullScreen)
        
//        let width = ModalSize.full
//        let height = ModalSize.full
//        //        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: 0))
//        let customType = PresentationType.custom(width: ModalSize.default, height: height, center: ModalCenterPosition.center)
//        customPresenter.presentationType = customType
        
        customPresenter.transitionType = .coverVertical
        customPresenter.dismissTransitionType = .coverVerticalFromTop
        customPresenter.roundCorners = false
        customPresenter.dismissOnSwipe = true
        customPresenter.dismissOnTap = false
        customPresenter.dismissOnSwipeDirection = .bottom
        customPresenter.backgroundColor = .clear
        customPresenter.backgroundOpacity = 0
        return customPresenter
    }()
    
    var image_dbItem:Image!
    
    var viewModel = ImageViewModel()
    
    public init(configuration: ImageViewerConfiguration?) {
        self.configuration = configuration
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        modalPresentationCapturesStatusBarAppearance = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = configuration?.imageView?.image ?? configuration?.image
        
        initFavourButton()
        
        setupScrollView()
        setupGestureRecognizers()
        setupTransitions()
        setupActivityIndicator()
    }
    
    func initFavourButton(){
        self.isFavorite = viewModel.isFavoriteImage(image_dbItem)
        
    }
    
    @IBAction func onTapFavourButton(_ sender: Any) {
        self.isFavorite = !self.isFavorite
        if self.isFavorite {
            viewModel.databaseService.changeFavoriteImage(image_dbItem, true)
        }else{
            viewModel.databaseService.changeFavoriteImage(image_dbItem, false)
        }

    }
    
    @IBAction func onTapInfoButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let controller = appDelegate.mainSwinjectStoryboard.instantiateViewController(withIdentifier: "ImageDescriptionTableViewController")
            as! ImageDescriptionTableViewController
        present(controller, animated: true)
//        customPresentViewController(presenter,
//                                    viewController: controller,
//                                    animated: true,
//                                    completion: nil
//        )
    }
}

extension ImageViewerController: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        guard let image = imageView.image else { return }
        let imageViewSize = Utilities.aspectFitRect(forSize: image.size, insideRect: imageView.frame)
        let verticalInsets = -(scrollView.contentSize.height - max(imageViewSize.height, scrollView.bounds.height)) / 2
        let horizontalInsets = -(scrollView.contentSize.width - max(imageViewSize.width, scrollView.bounds.width)) / 2
        scrollView.contentInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
    }
}

extension ImageViewerController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return scrollView.zoomScale == scrollView.minimumZoomScale
    }
}

private extension ImageViewerController {
    func setupScrollView() {
        scrollView.decelerationRate = UIScrollViewDecelerationRateFast
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
    }
    
    func setupGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.numberOfTapsRequired = 2
        tapGestureRecognizer.addTarget(self, action: #selector(imageViewDoubleTapped))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer()
        panGestureRecognizer.addTarget(self, action: #selector(imageViewPanned(_:)))
        panGestureRecognizer.delegate = self
        imageView.addGestureRecognizer(panGestureRecognizer)
    }
    
    func setupTransitions() {
        guard let imageView = configuration?.imageView else { return }
        transitionHandler = ImageViewerTransitioningHandler(fromImageView: imageView, toImageView: self.imageView)
        transitioningDelegate = transitionHandler
    }
    
    func setupActivityIndicator() {
        guard let block = configuration?.imageBlock else { return }
        activityIndicator.startAnimating()
        block { [weak self] image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.imageView.image = image
            }
        }
    }
    
    @IBAction func closeButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc func imageViewDoubleTapped() {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
    @objc func imageViewPanned(_ recognizer: UIPanGestureRecognizer) {
        guard transitionHandler != nil else { return }
            
        let translation = recognizer.translation(in: imageView)
        let velocity = recognizer.velocity(in: imageView)
        
        switch recognizer.state {
        case .began:
            transitionHandler?.dismissInteractively = true
            dismiss(animated: true)
        case .changed:
            let percentage = abs(translation.y) / imageView.bounds.height
            transitionHandler?.dismissalInteractor.update(percentage: percentage)
            transitionHandler?.dismissalInteractor.update(transform: CGAffineTransform(translationX: translation.x, y: translation.y))
        case .ended, .cancelled:
            transitionHandler?.dismissInteractively = false
            let percentage = abs(translation.y + velocity.y) / imageView.bounds.height
            if percentage > 0.25 {
                transitionHandler?.dismissalInteractor.finish()
            } else {
                transitionHandler?.dismissalInteractor.cancel()
            }
        default: break
        }
    }
}

