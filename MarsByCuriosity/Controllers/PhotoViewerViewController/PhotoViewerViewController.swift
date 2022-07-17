import UIKit

final class PhotoViewerViewController: BasicViewController {
    //MARK: - Elements
    private lazy var headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.configureBackButtonIconColor(with: ColorService.defaultWhite.getColor())
        headerView.configureHeaderLabel(font: FontService.terminalDosisExtraLight.getFont(size: 13),
                                        textColor: ColorService.defaultWhite.getColor(),
                                        text: "Photo ID")
        var photoId: String?
        if let id = photo?.id {
            photoId = "\(id)"
        }
        headerView.configureDescriptionLabel(font: FontService.dosisSemiBold.getFont(size: 18),
                                             textColor: ColorService.defaultWhite.getColor(),
                                             text: photoId)
        headerView.backButtonAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        return headerView
    }()
    
    private lazy var chosenPhotoImageView: CachingImageView = {
        let imageView = CachingImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var sharePhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sharePhotoButtonIsPressed(_:)), for: .touchUpInside)
        button.setImage(ImageAssetsService.shareIcon.getImage()?.withTintColor(ColorService.defaultWhite.getColor() ?? UIColor.white), for: .normal)
        return button
    }()
    
    //MARK: - Properties
    private let photoImageViewBorderSize: CGFloat = 16
    var photo: Photo?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadImage()
    }
    
    //MARK: - Actions
    @objc private func sharePhotoButtonIsPressed(_ sender: UIButton) {
        let imageToShare = chosenPhotoImageView.image
        guard let imageToShare = imageToShare else {
            return
        }
        let images = [imageToShare]
        let activityViewController = UIActivityViewController(activityItems: images, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - Flow functions
    private func setupUI() {
        setupSuperView()
        setupMainContent()
    }
    
    private func setupSuperView() {
        self.view.backgroundColor = ColorService.defaultBlack.getColor()
    }
    
    private func loadImage() {
        guard let stringUrl = photo?.img_src, let url = URL(string: stringUrl) else {
            return
        }
        chosenPhotoImageView.loadImage(from: url)
    }
    
    private func setupMainContent() {
        self.view.addSubview(headerView)
        
        headerView.heightAnchor.constraint(equalToConstant: SizeConstantsService.headerHeight.rawValue).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        let shareButtonContainerView = headerView.rightAuxiliaryZoneView
        shareButtonContainerView.addSubview(sharePhotoButton)
        
        sharePhotoButton.trailingAnchor.constraint(equalTo: shareButtonContainerView.trailingAnchor).isActive = true
        sharePhotoButton.leadingAnchor.constraint(equalTo: shareButtonContainerView.leadingAnchor).isActive = true
        sharePhotoButton.topAnchor.constraint(equalTo: shareButtonContainerView.topAnchor).isActive = true
        sharePhotoButton.bottomAnchor.constraint(equalTo: shareButtonContainerView.bottomAnchor).isActive = true
        
        self.view.addSubview(chosenPhotoImageView)
        
        chosenPhotoImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -photoImageViewBorderSize).isActive = true
        chosenPhotoImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: photoImageViewBorderSize).isActive = true
        chosenPhotoImageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: photoImageViewBorderSize).isActive = true
        chosenPhotoImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -photoImageViewBorderSize).isActive = true
    }
}
