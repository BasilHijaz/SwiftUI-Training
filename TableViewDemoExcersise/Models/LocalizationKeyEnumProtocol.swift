//
//  LocalizationKeyEnumProtocol.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 21/01/2025.
//

import Foundation

protocol LocalizationKeyEnumProtocol: RawRepresentable<String> {
}

extension LocalizationKeyEnumProtocol {
    var text: String {
        return rawValue.localized
    }
}
