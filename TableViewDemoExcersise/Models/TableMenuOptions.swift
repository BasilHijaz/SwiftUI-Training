//
//  TableMenuOptions.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 07/01/2025.
//

import Foundation

enum TableMenuOptions: CaseIterable {
    case delete
}

extension TableMenuOptions {
    var title: String {
        switch self {
        case .delete:
            return LocalizationKey.tableMenuDeleteOption.text
        }
    }

    var keyEquivalent: String {
        switch self {
        case .delete:
            return "d"
        }
    }
}
