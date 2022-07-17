import UIKit

final class BackButton: UIButton {   
    //MARK: - View configuration
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureBackButtonColor(with: ColorService.defaultBlack.getColor())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Flow functions
    func configureBackButtonColor(with color: UIColor?) {
        guard let color = color else {
            return
        }
        self.setImage(ImageAssetsService.backButtonIcon.getImage()?.withTintColor(color), for: .normal)
    }
}
