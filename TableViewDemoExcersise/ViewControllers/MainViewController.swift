//
//  MainViewController.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 06/01/2025.
//

import Cocoa

// TODO: Add to public github repo.
class MainViewController: NSViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var headerView: HeaderView! {
        didSet {
            headerView.delegate = self
        }
    }
    @IBOutlet private weak var contentView: ContentView! {
        didSet {
            contentView.delegate = self
        }
    }
    @IBOutlet private weak var footerView: FooterView!

    // MARK: - Private properties

    private var viewModel: MainViewModel?
    private var currentPeopleList: [Person] {
        viewModel?.filteredPeopleList ?? []
    }
    private var popover: NSPopover?
    private let sessionManager = SessionManager()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = .init(initialPeopleList: sessionManager.getPeopleList() ?? [])
        reloadData()
    }

    // MARK: - Private functions

    private func reloadData() {
        guard let viewModel else {
            return
        }
        viewModel.filterPeopleList(tokens: headerView.tokens)
        contentView.peopleList = viewModel.filteredPeopleList
        sessionManager.savePeopleList(viewModel.initialPeopleList)
    }

    private func showAlert(withTitle title: String, message: String) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.alertStyle = .warning
        alert.addButton(withTitle: LocalizationKey.alertConfirmationButtonText.text)
        alert.runModal()
    }

    private func closePopover() {
        popover?.close()
        self.popover = nil
    }
}

extension MainViewController: HeaderViewDelegate {
    func tokensDidChange(_ sender: HeaderView, tokens: [String]) {
        viewModel?.filterPeopleList(tokens: tokens)
        reloadData()
    }

    func addPersonButtonDidClick(_ sender: HeaderView) {
        let storyboard = NSStoryboard(name: LocalizationKey.personTableAppName.text, bundle: nil)
        guard let addPersonViewController = storyboard.instantiateController(
            withIdentifier: LocalizationKey.addPersonViewControllerIdentifierText.text)
                as? AddPersonViewController else {
            print(LocalizationKey.unableToDisplayAddPersonViewController.text)
            return
        }

        addPersonViewController.delegate = self
        presentAsSheet(addPersonViewController)
    }

    func descriptionButtonDidClick(_ sender: HeaderView) {
        if let popover, popover.isShown {
            closePopover()
            return
        }
        popover = AppDescriptionPopoverViewController
            .showPopover(positioningView: sender)
    }
}

extension MainViewController: ContentViewDelegate {
    func selectedItemDidChange(_ sender: ContentView, selectedItem: Int) {
        guard selectedItem >= 0 && selectedItem < currentPeopleList.count else {
            footerView.updateSelectedItemLabel(with: "")
            footerView.selectedPerson = nil
            return
        }
        footerView.selectedPerson = currentPeopleList[selectedItem]
        footerView.updateSelectedItemLabel(with: currentPeopleList[selectedItem].description)
    }

    func notifyItemDeleted(_ sender: ContentView, clickedItem: Int) {
        guard clickedItem >= 0 && clickedItem < currentPeopleList.count else { return }
        if let selectedPerson = footerView.selectedPerson {
            if selectedPerson == currentPeopleList[clickedItem] {
                footerView.selectedPerson = nil
                footerView.updateSelectedItemLabel(with: "")
            }
        }
        viewModel?.deletePerson(clickedItem: clickedItem)
        reloadData()
    }
}

extension MainViewController: AddPersonViewControllerDelegate {
    func addPerson(_ sender: AddPersonViewController, with name: String, image: String) {
        DispatchQueue.global().async { [weak self] in
            guard let self, let viewModel else { return }
            guard viewModel.checkIfPersonNameIsUnique(name: name) else {
                DispatchQueue.switchToMainIfNeeded {
                    sender.hideProgressIndicator()
                    self.showAlert(withTitle: LocalizationKey.nameShouldBeUniqueInAddPersonAlertTitle.text,
                                   message: LocalizationKey.nameShouldBeUniqueInAddPersonAlertDescription.text)
                }
                return
            }
            viewModel.addPerson(with: name, image: image) { person in
                DispatchQueue.switchToMainIfNeeded { [weak self] in
                    guard let self else { return }
                    viewModel.appendPersonToList(person: person)
                    dismiss(sender)
                    reloadData()
                }
            }
        }
    }
}
