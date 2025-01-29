//
//  AppDescriptionPopoverView.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 26/01/2025.
//

import Cocoa

class AppDescriptionPopoverView: NSView {

    // MARK: - IBOutlets

    @IBOutlet private weak var popoverTitleTextField: NSTextField! {
        didSet {
            initPopoverTitleTextField()
        }
    }
    @IBOutlet private weak var popoverDescriptionTextField: NSTextField! {
        didSet {
            initPopoverDescriptionTextField()
        }
    }

    // MARK: - Private functions

    private func initPopoverTitleTextField() {
        popoverTitleTextField.stringValue = LocalizationKey.appDescriptionPopoverTitleText.text
    }

    private func initPopoverDescriptionTextField() {
        popoverDescriptionTextField.stringValue = LocalizationKey.appDescriptionPopoverMessageText.text
    }
}
