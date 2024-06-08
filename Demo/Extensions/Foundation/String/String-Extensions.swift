//
//  String-Extensions.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import Foundation
import UIKit

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date
    }
}
