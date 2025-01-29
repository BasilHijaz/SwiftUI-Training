//
//  AppDescriptionPopoverViewController.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 26/01/2025.
//

import Cocoa

class AppDescriptionPopoverViewController: NSViewController {

    // MARK: - Public functions

    static func showPopover(positioningView: NSView) -> NSPopover? {
        let storyboard = NSStoryboard(name: LocalizationKey.personTableAppName.text, bundle: nil)
        guard let appDescriptionViewController = storyboard.instantiateController(
            withIdentifier: LocalizationKey.appDescriptionPopoverViewControllerIdentifierText.text)
                as? AppDescriptionPopoverViewController else {
            return nil
        }
        let popover = NSPopover()
        popover.behavior = .semitransient
        popover.contentViewController = appDescriptionViewController
        popover.show(relativeTo: .zero, of: positioningView, preferredEdge: .maxX)
        return popover
    }
}
