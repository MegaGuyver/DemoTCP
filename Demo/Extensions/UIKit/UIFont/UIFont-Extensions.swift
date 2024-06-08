//
//  UIFont-Extensions.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import Foundation
import UIKit

extension UIFont {

    public enum AmsiProType: String {
        case regular = "-Regular"
        case bold = "-Bold"
    }

    static func AmsiPro(_ type: AmsiProType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "AmsiPro\(type.rawValue)", size: size)!
    }


}
