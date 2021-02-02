//
//  String+Localized.swift
//  Common
//
//  Created by Mario Mouris on 02/02/2021.
//

import Foundation

extension String {
    /// Gets a localized string from Localizable.strings
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
