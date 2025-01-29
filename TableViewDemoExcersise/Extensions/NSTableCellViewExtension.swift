//
//  NSTableCellViewExtension.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 07/01/2025.
//

import Cocoa

extension NSTableCellView {

    // MARK: - Public properties

    static var cellIdentifier: NSUserInterfaceItemIdentifier {
        let name = String(describing: Self.self)
        return NSUserInterfaceItemIdentifier(name)
    }
}
