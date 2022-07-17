import UIKit
import DropDown

final class CameraDateSelectionViewController: BasicViewController {
    //MARK: - Elements
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = ImageAssetsService.cameraDateViewControllerBackground.getImage()
        return imageView
    }()
    
    private lazy var headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.hideBackButton()
        headerView.configureHeaderLabel(text: "Select Camera and Date")
        headerView.hideDescriptionLabel()
        return headerView
    }()
    
    private lazy var roverCameraTextfield: TextfieldView = {
        let roverCameraTextfield = TextfieldView()
        roverCameraTextfield.configureTextfieldOption(with: .dropDown)
        roverCameraTextfield.configureTextfieldName(name: "Rover Camera")
        roverCameraTextfield.heightAnchor.constraint(equalToConstant: textfieldHeightConstant).isActive = true
        roverCameraTextfield.textfieldAction = { [weak self] in
            self?.dropDownMenu.show()
        }
        return roverCameraTextfield
    }()
    
    private lazy var dropDownMenu: DropDown = {
        let menu = DropDown()
        menu.dataSource = dropDownMenuDataSource.getDropDownMenuItems()
        menu.anchorView = roverCameraTextfield
        menu.bottomOffset = CGPoint(x: 0, y: menu.anchorView?.plainView.bounds.height ?? 0)
        menu.width = self.view.frame.size.width - (borderConstant * 2)
        menu.cornerRadius = 10
        menu.selectionAction = { [weak self] index, text in
            self?.roverCameraTextfield.fillInTextfield(with: text)
        }
        return menu
    }()
    
    private lazy var dateTextfield: TextfieldView = {
        let dateTextfield = TextfieldView()
        dateTextfield.configureTextfieldOption(with: .date)
        dateTextfield.configureTextfieldName(name: "Date")
        dateTextfield.heightAnchor.constraint(equalToConstant: textfieldHeightConstant).isActive = true
        dateTextfield.textfieldAction = { [weak self] in
            self?.dateTextfield.showKeyboard()
        }
        return dateTextfield
    }()
    
    private lazy var exploreButton: UIButton = {
        let exploreButton = UIButton()
        exploreButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        exploreButton.addTarget(self, action: #selector(exploreButtonIsPressed(_:)), for: .touchUpInside)
        exploreButton.layer.cornerRadius = 10
        exploreButton.backgroundColor = ColorService.red.getColor()
        exploreButton.setTitle("Explore", for: .normal)
        exploreButton.titleLabel?.font = FontService.dosisSemiBold.getFont(size: 18)
        return exploreButton
    }()
    
    //MARK: - Properties
    private let borderConstant: CGFloat = 24
    private let textfieldHeightConstant: CGFloat = 85
    private let dropDownMenuDataSource = CameraDropDownMenuDataSource()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Actions
    @objc private func exploreButtonIsPressed(_ sender: UIButton) {
        var dataModel = GetPhotosDataModel()
        dataModel.camera = dropDownMenuDataSource.getCameraItem(at: dropDownMenu.indexForSelectedRow)
        dataModel.earthDate = dateTextfield.getTextfieldValue()
        let cameraRollViewController = CameraRollViewController()
        cameraRollViewController.photosDataModel = dataModel
        self.navigationController?.pushViewController(cameraRollViewController, animated: true)
    }
    
    //MARK: - Flow functions
    private func setupUI() {
        setupBackgroundImageViewConstraints()
        setupMainContent()
    }
    
    private func setupBackgroundImageViewConstraints() {
        self.view.addSubview(backgroundImageView)
        
        backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    }
    
    private func setupMainContent() {
        self.view.addSubview(headerView)
        
        headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: SizeConstantsService.headerHeight.rawValue).isActive = true
        
        let textfieldsStackView = getConfiguredTextfieldsStackView()
        
        let contentStackView = UIStackView(arrangedSubviews: [textfieldsStackView, exploreButton])
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.axis = .vertical
        contentStackView.spacing = 20
        
        contentStackView.addSubview(textfieldsStackView)
        self.view.addSubview(contentStackView)
        
        contentStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        contentStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: borderConstant).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -borderConstant).isActive = true
    }
    
    private func getConfiguredTextfieldsStackView() -> UIStackView {
        let textfieldsStackView = UIStackView(arrangedSubviews: [roverCameraTextfield, dateTextfield])
        textfieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        textfieldsStackView.axis = .vertical
        textfieldsStackView.distribution = .fillEqually
        textfieldsStackView.spacing = 16
        return textfieldsStackView
    }
}

