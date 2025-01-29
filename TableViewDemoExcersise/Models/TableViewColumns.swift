//
//  TableViewColumns.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 07/01/2025.
//

import Cocoa

enum TableViewColumns: String, CaseIterable {
    case name
    case identifier
    case descriptionImage
}

extension TableViewColumns {
    var title: String {
        switch self {
        case .name:
            return LocalizationKey.tableColumnNameTitle.text
        case .identifier:
            return LocalizationKey.tableColumnIdentifierTitle.text
        case .descriptionImage:
            return LocalizationKey.tableColumnDescriptionImageTitle.text
        }
    }
}

extension TableViewColumns {
    var columnIdentifier: NSUserInterfaceItemIdentifier {
        return NSUserInterfaceItemIdentifier(self.rawValue)
    }
}
