//
//  AddPersonViewController.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 19/01/2025.
//

import Cocoa
import Carbon.HIToolbox

protocol AddPersonViewControllerDelegate: AnyObject {
    func addPerson(_ sender: AddPersonViewController, with name: String, image: String)
}

class AddPersonViewController: NSViewController {

    // MARK: - Public properties

    weak var delegate: AddPersonViewControllerDelegate?

    // MARK: - IBOutlets

    @IBOutlet private weak var addPersonView: AddPersonView! {
        didSet {
            addPersonView.delegate = self
        }
    }

    // MARK: - Private properties

    private var escKeyMonitor: Any?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initKeyMonitor()
    }

    deinit {
        deInitKeyMonitor()
    }

    // MARK: - Public functions

    func hideProgressIndicator() {
        addPersonView.changeProgressIndicatorVisibilityToHidden(true)
    }

    // MARK: - Private functions

    private func initKeyMonitor() {
        escKeyMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.keyCode == kVK_Escape {
                self?.dismiss(self)
                return nil
            }
            return event
        }
    }

    private func deInitKeyMonitor() {
        if let monitor = escKeyMonitor {
            NSEvent.removeMonitor(monitor)
            escKeyMonitor = nil
        }
        print("Monitor DeInitialized")
    }
}

extension AddPersonViewController: AddPersonViewDelegate {
    func addPerson(_ sender: AddPersonView, with name: String, image: String) {
        delegate?.addPerson(self, with: name, image: image)
    }

    func backButtonDidClick(_ sender: AddPersonView) {
        dismiss(self)
    }
}
