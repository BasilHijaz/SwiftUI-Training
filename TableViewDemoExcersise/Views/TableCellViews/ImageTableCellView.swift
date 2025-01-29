//
//  ImageTableCellView.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 13/01/2025.
//

import Cocoa

class ImageTableCellView: NSTableCellView {

    // MARK: - Public properties

    var imageValue: NSImage? {
        didSet {
            populateData()
        }
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var iconView: NSImageView!

    // MARK: - Private functions

    private func populateData() {
        iconView.image = imageValue
    }
}
