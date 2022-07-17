import UIKit

enum ImageAssetsService {
    //MARK: - Backgrounds
    case cameraDateViewControllerBackground
    
    //MARK: - Button Icons
    case backButtonIcon
    case calendarIcon
    case dropdownArrowIcon
    case shareIcon
    
    //MARK: - Flow functions
    func getImage() -> UIImage? {
        switch self {
        // Backgrounds
        case .cameraDateViewControllerBackground:
            return UIImage(named: "cameraDateViewControllerBackground")
            
        // Button Icons
        case .backButtonIcon:
            return UIImage(named: "backButtonIcon")
        case .calendarIcon:
            return UIImage(named: "calendarIcon")
        case .dropdownArrowIcon:
            return UIImage(named: "dropdownArrowIcon")
        case .shareIcon:
            return UIImage(named: "shareIcon")
        }
    }
}
