//
//  FooterView.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 06/01/2025.
//

import Cocoa

class FooterView: NSView {

    // MARK: - Public properties

    var selectedPerson: Person?

    // MARK: - IBOutlets

    @IBOutlet private weak var selectedItemLabel: NSTextField!
    @IBOutlet private weak var selectedItemDescriptionLabel: NSTextField! {
        didSet {
            initSelectedItemDescriptionLabel()
        }
    }

    // MARK: - Public functions

    func updateSelectedItemLabel(with text: String) {
        selectedItemLabel.stringValue = text
        selectedItemLabel.toolTip = text
    }

    // MARK: - Private functions

    private func initSelectedItemDescriptionLabel() {
        selectedItemDescriptionLabel.stringValue = LocalizationKey.selectedItemDescriptionLabelText.text
    }
}
