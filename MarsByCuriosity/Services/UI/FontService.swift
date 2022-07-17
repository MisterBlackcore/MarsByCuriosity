//
//  FontService.swift
//  MarsByCuriosity
//
//  Created by Anton Shkuray on 14.07.22.
//

import UIKit

enum FontService {
    //MARK: - Fonts
    case dosisSemiBold
    case terminalDosisExtraLight
    case terminalDosisBook
    
    //MARK: - Flow functions
    func getFont(size: CGFloat) -> UIFont? {
        switch self {
        case .dosisSemiBold:
            return UIFont(name: "Dosis-SemiBold", size: size)
        case .terminalDosisExtraLight:
            return UIFont(name: "TerminalDosis-ExtraLight", size: size)
        case .terminalDosisBook:
            return UIFont(name: "TerminalDosis-Book", size: size)
        }
    }
}
