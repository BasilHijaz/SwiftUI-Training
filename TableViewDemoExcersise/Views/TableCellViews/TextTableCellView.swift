//
//  NameTableCellView.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 07/01/2025.
//

import Cocoa

class TextTableCellView: NSTableCellView {

    // MARK: - Public properties

    var labelText: String? {
        didSet {
            populateData()
        }
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var nameLabel: NSTextField!

    // MARK: - Private functions

    private func populateData() {
        nameLabel.stringValue = labelText ?? "-"
    }
}
