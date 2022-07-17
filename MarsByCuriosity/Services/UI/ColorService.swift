import UIKit

enum ColorService {
    //MARK: - Colors
    case red
    case brown
    case defaultBlack
    case defaultWhite
    case clear
    
    //MARK: - Flow functions
    func getColor() -> UIColor? {
        switch self {
        case .red:
            return UIColor(named: "Red")
        case .brown:
            return UIColor(named: "Brown")
        case .defaultBlack:
            return UIColor.black
        case .defaultWhite:
            return UIColor.white
        case .clear:
            return UIColor.clear
        }
    }
}
