//
//  String+Ex.swift
//  NewsToday
//
//  Created by Денис Гиндулин on 31.10.2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
