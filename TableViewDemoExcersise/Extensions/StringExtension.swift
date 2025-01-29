//
//  StringExtension.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 21/01/2025.
//

import Foundation

extension String {

    // MARK: - Public properties

    var localized: String {
        return NSLocalizedString(self, bundle: Bundle.main, comment: "")
    }
}
