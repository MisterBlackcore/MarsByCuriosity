import UIKit

enum TextfieldOption {
    case text
    case dropDown
    case date
}

final class TextfieldView: UIView {
    //MARK: - Elements
    private lazy var textfieldNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontService.terminalDosisBook.getFont(size: 14)
        label.textColor = ColorService.defaultBlack.getColor()
        return label
    }()
    
    private lazy var textfield: UITextField = {
        let textfield = UITextField()
        textfield.delegate = self
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = FontService.terminalDosisBook.getFont(size: 18)
        textfield.textColor = ColorService.defaultBlack.getColor()
        return textfield
    }()
    
    private lazy var textfieldBackgrounView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: textfieldHeightConstant).isActive = true
        view.alpha = 0.5
        view.backgroundColor = ColorService.defaultWhite.getColor()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var textfieldContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: textfieldHeightConstant).isActive = true
        return view
    }()
    
    private lazy var textfieldIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: textfieldHeightConstant).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: textfieldHeightConstant).isActive = true
        return imageView
    }()
    
    private lazy var textfieldActionButton: UIButton = {
        let textfieldActionButton = UIButton()
        textfieldActionButton.translatesAutoresizingMaskIntoConstraints = false
        textfieldActionButton.addTarget(self, action: #selector(extfieldActionButtonIsPressed(_:)), for: .touchUpInside)
        textfieldActionButton.titleLabel?.text = nil
        return textfieldActionButton
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    
    //MARK: - Properties
    private let textfieldHeightConstant: CGFloat = 60
    private let imageSize: CGFloat = 24
    private var textfieldValue: String?
    var textfieldAction: (()->())?
    
    //MARK: - View configuration
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addTextfieldBackgroundView()
        addTextfieldContainerView()
        addTextfieldViews()
        addTextfieldActionButton()
        addTextfieldNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addTextfieldBackgroundView() {
        self.addSubview(textfieldBackgrounView)
        
        textfieldBackgrounView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textfieldBackgrounView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textfieldBackgrounView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func addTextfieldContainerView() {
        self.addSubview(textfieldContainerView)
        
        textfieldContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textfieldContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textfieldContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func addTextfieldNameLabel() {
        self.addSubview(textfieldNameLabel)
        
        textfieldNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textfieldNameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textfieldNameLabel.bottomAnchor.constraint(equalTo: textfieldContainerView.topAnchor, constant: 7).isActive = true
    }
    
    private func addTextfieldViews() {
        let stackView = UIStackView(arrangedSubviews: [textfield, textfieldIconImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        textfieldContainerView.addSubview(stackView)
        
        stackView.leadingAnchor.constraint(equalTo: textfieldContainerView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: textfieldContainerView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: textfieldContainerView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: textfieldContainerView.bottomAnchor).isActive = true
    }
    
    private func addTextfieldActionButton() {
        textfieldContainerView.addSubview(textfieldActionButton)
        
        textfieldActionButton.trailingAnchor.constraint(equalTo: textfieldContainerView.trailingAnchor).isActive = true
        textfieldActionButton.leadingAnchor.constraint(equalTo: textfieldContainerView.leadingAnchor).isActive = true
        textfieldActionButton.bottomAnchor.constraint(equalTo: textfieldContainerView.bottomAnchor).isActive = true
        textfieldActionButton.topAnchor.constraint(equalTo: textfieldContainerView.topAnchor).isActive = true
    }
    
    //MARK: - Actions
    @objc private func extfieldActionButtonIsPressed(_ sender: UIButton) {
        textfieldAction?()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "dd MMM, yyyy"
        let selectedDate = dateFormatter.string(from: sender.date)
        textfieldValue = selectedDate
        fillInTextfield(with: textfieldValue)
    }
    
    //MARK: - Flow functions
    func configureTextfieldOption(with option: TextfieldOption = .text) {
        let hideViews = option == .text
        textfieldIconImageView.isHidden = hideViews
        textfieldActionButton.isHidden = hideViews
        var image: UIImage?
        switch option {
        case .dropDown:
            image = ImageAssetsService.dropdownArrowIcon.getImage()
        case .date:
            image = ImageAssetsService.calendarIcon.getImage()
            textfield.inputView = datePicker
        default:
            break
        }
        let edgeInset = (textfieldHeightConstant - imageSize) / 2
        textfieldIconImageView.image = image?.withAlignmentRectInsets(UIEdgeInsets(top: -edgeInset,
                                                                                   left: -edgeInset,
                                                                                   bottom: -edgeInset,
                                                                                   right: -edgeInset))
    }
    
    func configureTextfieldName(name: String) {
        textfieldNameLabel.text = name
    }
    
    func fillInTextfield(with text: String?) {
        textfield.text = text
    }
    
    func showKeyboard() {
        textfield.becomeFirstResponder()
    }
    
    func getTextfieldValue() -> String? {
        textfieldValue
    }
}

//MARK: - TextfieldView + UITextFieldDelegate
extension TextfieldView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textfieldValue = textfield.text
    }
}


