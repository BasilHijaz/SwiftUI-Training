//
//  AddPersonView.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 19/01/2025.
//

import Cocoa

protocol AddPersonViewDelegate: AnyObject {
    func addPerson(_ sender: AddPersonView, with name: String, image: String)
    func backButtonDidClick(_ sender: AddPersonView)
}

class AddPersonView: NSView {

    // MARK: - Public properties

    weak var delegate: AddPersonViewDelegate?

    // MARK: - IBOutlets

    @IBOutlet private weak var personNameTextField: NSTextField! {
        didSet {
            personNameTextField.delegate = self

            initPersonNameTextField()
        }
    }
    @IBOutlet private weak var descriptionImageComboBox: NSComboBox! {
        didSet {
            initDescriptionImageComboBox()
        }
    }
    @IBOutlet private weak var addPersonButton: NSButton! {
        didSet {
            initAddPersonButton()
        }
    }
    @IBOutlet private weak var backButton: NSButton! {
        didSet {
            initBackButton()
        }
    }
    @IBOutlet private weak var progressIndicator: NSProgressIndicator! {
        didSet {
            initProgressIndicator()
        }
    }

    // MARK: - IBActions

    @IBAction private func addPersonButtonDidClick(_ sender: NSButton) {
        let name = personNameTextField.stringValue
        let image = descriptionImageComboBox.stringValue.lowercased()
        progressIndicator.isHidden = false
        delegate?.addPerson(self, with: name, image: image)
    }

    @IBAction private func backButtonDidClick(_ sender: NSButton) {
        delegate?.backButtonDidClick(self)
    }

    // MARK: - Public Functions

    func changeProgressIndicatorVisibilityToHidden(_ isHidden: Bool) {
        progressIndicator.isHidden = isHidden
    }

    // MARK: - Private functions

    private func initPersonNameTextField() {
        personNameTextField.placeholderString = LocalizationKey.addPersonNameTextFieldPlaceholder.text
    }

    private func initDescriptionImageComboBox() {
        descriptionImageComboBox.removeAllItems()
        for item in DescriptionImageOptions.allCases {
            descriptionImageComboBox.addItem(withObjectValue: item.title)
        }
        descriptionImageComboBox.selectItem(at: 0)
    }

    private func initAddPersonButton() {
        addPersonButton.isEnabled = false
        addPersonButton.title = LocalizationKey.addPersonButtonTitleText.text
    }

    private func initBackButton() {
        backButton.title = LocalizationKey.addPersonViewBackButtonTitleText.text
    }

    private func initProgressIndicator() {
        progressIndicator.isHidden = true
        progressIndicator.startAnimation(self)
        progressIndicator.toolTip = LocalizationKey.addPersonLoadingStateIsInProgress.text
    }
}

extension AddPersonView: NSTokenFieldDelegate {
    func controlTextDidChange(_ notification: Notification) {
        addPersonButton.isEnabled = !personNameTextField.stringValue.isEmpty
    }
}
