//
//  HeaderView.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 06/01/2025.
//

import Cocoa

protocol HeaderViewDelegate: AnyObject {
    func tokensDidChange(_ sender: HeaderView, tokens: [String])
    func addPersonButtonDidClick(_ sender: HeaderView)
    func descriptionButtonDidClick(_ sender: HeaderView)
}

class HeaderView: NSView {

    // MARK: - Public properties

    weak var delegate: HeaderViewDelegate?
    private(set) var tokens: [String] = []

    // MARK: - IBOutlets

    @IBOutlet private weak var tokenField: NSTokenField! {
        didSet {
            tokenField.delegate = self

            initTokenField()
        }
    }
    @IBOutlet private weak var addPersonButton: NSButton!
    @IBOutlet private weak var descriptionButton: NSButton!

    // MARK: - IBActions

    @IBAction private func addPersonButtonDidClick(_ sender: NSButton) {
        delegate?.addPersonButtonDidClick(self)
    }

    @IBAction private func descriptionButtonClicked(_ sender: NSButton) {
        delegate?.descriptionButtonDidClick(self)
    }

    // MARK: - Private functions

    private func initTokenField() {
        tokenField.placeholderString = LocalizationKey.filterPlaceholderText.text
    }
}

extension HeaderView: NSTokenFieldDelegate {
    func controlTextDidChange(_ notification: Notification) {
        tokens = tokenField.objectValue as? [String] ?? []
        delegate?.tokensDidChange(self, tokens: tokens)
    }
}
