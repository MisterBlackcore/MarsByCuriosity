import UIKit

final class CameraRollViewController: BasicViewController {
    //MARK: - Elements
    private lazy var headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.configureHeaderLabel(text: photosDataModel?.camera?.cameraName)
        headerView.configureDescriptionLabel(text: photosDataModel?.earthDate)
        headerView.backButtonAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        return headerView
    }()
    
    private lazy var cameraRollCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = ColorService.clear.getColor()
        collectionView.register(CameraRollCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        return collectionView
    }()
    
    private lazy var loadingWarningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontService.dosisSemiBold.getFont(size: 18)
        label.textColor = ColorService.defaultBlack.getColor()
        label.textAlignment = .center
        label.text = "Loading, please wait"
        return label
    }()
    
    //MARK: - Properties
    private let cellIdentifier = "CameraRollCollectionViewCell"
    private let collectionViewBorderSize: CGFloat = 12
    private var photos = [Photo]()
    var photosDataModel: GetPhotosDataModel?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPhotos()
    }
    
    //MARK: - Flow functions
    private func setupUI() {
        setupSuperView()
        setupMainContent()
    }
    
    private func setupSuperView() {
        self.view.backgroundColor = ColorService.brown.getColor()
    }
    
    private func setupMainContent() {
        self.view.addSubview(headerView)
        
        headerView.heightAnchor.constraint(equalToConstant: SizeConstantsService.headerHeight.rawValue).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        self.view.addSubview(loadingWarningLabel)
        
        loadingWarningLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -collectionViewBorderSize).isActive = true
        loadingWarningLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: collectionViewBorderSize).isActive = true
        loadingWarningLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingWarningLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        self.view.addSubview(cameraRollCollectionView)
        
        cameraRollCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -collectionViewBorderSize).isActive = true
        cameraRollCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: collectionViewBorderSize).isActive = true
        cameraRollCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        cameraRollCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func loadPhotos() {
        guard let dataModel = photosDataModel else {
            return
        }
        networkService.getPhotos(target: .photos(dataModel: dataModel)) { [weak self] photosObject in
            guard let photosObject = photosObject else {
                return
            }
            self?.photos = photosObject.photos
            self?.configureViewsAfterLoading()
        }
    }
    
    private func configureViewsAfterLoading() {
        loadingWarningLabel.isHidden = !photos.isEmpty
        loadingWarningLabel.text = photos.isEmpty ? "No photos" : nil
        cameraRollCollectionView.reloadData()
    }
}

//MARK: - CameraRollViewController + UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CameraRollViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CameraRollCollectionViewCell else {
            return UICollectionViewCell()
        }
        let photo = photos[indexPath.item]
        cell.configureCell(with: photo.img_src)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = PhotoViewerViewController()
        let photo = photos[indexPath.item]
        viewController.photo = photo
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
