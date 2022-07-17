import UIKit

final class HeaderView: UIView {
    //MARK: - Elements
    private lazy var backButton: BackButton = {
        let backButton = BackButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonIsPressed(_:)), for: .touchUpInside)
        return backButton
    }()
    
    lazy var rightAuxiliaryZoneView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontService.dosisSemiBold.getFont(size: 18)
        label.textColor = ColorService.defaultBlack.getColor()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontService.terminalDosisExtraLight.getFont(size: 13)
        label.textColor = ColorService.defaultBlack.getColor()
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Properties
    private let buttonZoneWidthConstant: CGFloat = 50
    var backButtonAction: (()->())?
    
    //MARK: - View configuration
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addBackButton()
        addRightAuxiliaryZoneView()
        addHeaderLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addBackButton() {
        self.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: buttonZoneWidthConstant).isActive = true
    }
    
    private func addRightAuxiliaryZoneView() {
        self.addSubview(rightAuxiliaryZoneView)
        rightAuxiliaryZoneView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rightAuxiliaryZoneView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rightAuxiliaryZoneView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        rightAuxiliaryZoneView.widthAnchor.constraint(equalToConstant: buttonZoneWidthConstant).isActive = true
    }
    
    private func addHeaderLabels() {
        let labelsStackView = UIStackView(arrangedSubviews: [headerLabel, descriptionLabel])
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .fillEqually
        
        self.addSubview(labelsStackView)
        labelsStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        labelsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        labelsStackView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor).isActive = true
        labelsStackView.trailingAnchor.constraint(equalTo: rightAuxiliaryZoneView.leadingAnchor).isActive = true
    }
    
    //MARK: - Actions
    @objc private func backButtonIsPressed(_ sender: UIButton) {
        backButtonAction?()
    }
    
    //MARK: - Flow functions
    func hideBackButton() {
        backButton.isHidden = true
    }
    
    func hideHeaderLabel() {
        headerLabel.isHidden = true
    }
    
    func hideDescriptionLabel() {
        descriptionLabel.isHidden = true
    }
    
    func configureBackButtonIconColor(with color: UIColor?) {
        backButton.configureBackButtonColor(with: color)
    }
    
    func configureHeaderLabel(font: UIFont? = FontService.dosisSemiBold.getFont(size: 18), textColor: UIColor? = ColorService.defaultBlack.getColor(), text: String?) {
        headerLabel.font = font
        headerLabel.textColor = textColor
        headerLabel.isHidden = text == nil
        headerLabel.text = text
    }
    
    func configureDescriptionLabel(font: UIFont? = FontService.terminalDosisExtraLight.getFont(size: 13), textColor: UIColor? = ColorService.defaultBlack.getColor(), text: String?) {
        descriptionLabel.font = font
        descriptionLabel.textColor = textColor
        descriptionLabel.isHidden = text == nil
        descriptionLabel.text = text
    }
}
