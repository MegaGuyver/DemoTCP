//
//  ColorManager.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import Foundation
import UIKit

enum ColorManager {
    
    case theme
    
    case custom(hexString: String, alpha: Double)
    
    func withAlpha(_ alpha: Double) -> UIColor {
        return self.value.withAlphaComponent(CGFloat(alpha))
    }
}


extension ColorManager {
    
    var value: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {
        case .theme:
            instanceColor = UIColor(hexString: "#FFDE61")

        case .custom(let hexValue, let opacity):
            instanceColor = UIColor(hexString: hexValue).withAlphaComponent(CGFloat(opacity))
        }
        return instanceColor
    }
}
