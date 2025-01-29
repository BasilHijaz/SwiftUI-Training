//
//  ContentView.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 06/01/2025.
//

import Cocoa

protocol ContentViewDelegate: AnyObject {
    func selectedItemDidChange(_ sender: ContentView, selectedItem: Int)
    func notifyItemDeleted(_ sender: ContentView, clickedItem: Int)
}

class ContentView: NSView {

    // MARK: - Public properties

    weak var delegate: ContentViewDelegate?
    var peopleList: [Person] = [] {
        didSet {
            reloadTableViewData()
        }
    }

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: NSTableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            initTableView()
        }
    }

    // MARK: - Private functions
    private func initTableView() {
        tableView.menu = createTableViewMenu()
        createTableViewColumns()
    }

    @objc
    private func deleteMenuButtonDidClick(_ sender: NSMenuItem) {
        guard sender.representedObject is TableMenuOptions else { return }
        delegate?.notifyItemDeleted(self, clickedItem: tableView.clickedRow)
    }

    private func createTableViewMenu() -> NSMenu {
        let tableViewMenu = NSMenu()
        for option in TableMenuOptions.allCases {
            let menuItem = NSMenuItem(title: option.title,
                                      action: #selector(deleteMenuButtonDidClick(_:)),
                                      keyEquivalent: option.keyEquivalent)
            menuItem.representedObject = option
            tableViewMenu.addItem(menuItem)
        }
        return tableViewMenu
    }

    private func createTableViewColumns() {
        removeTableViewColumns()
        for columnCase in TableViewColumns.allCases {
            tableView.addTableColumn(createTableColumn(rawValue: columnCase.rawValue,
                                                       title: columnCase.title))
        }
        tableView.sizeToFit()
    }

    private func removeTableViewColumns() {
        for column in tableView.tableColumns {
            tableView.removeTableColumn(column)
        }
    }

    private func createTableColumn(rawValue: String, title: String) -> NSTableColumn {
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: rawValue))
        column.title = title
        return column
    }

    private func reloadTableViewData() {
        tableView.reloadData()
    }

    private func createTextTableCellView(cellIdentifier: NSUserInterfaceItemIdentifier,
                                         cellText: String) -> TextTableCellView? {
        guard let view = tableView.makeView(withIdentifier: cellIdentifier,
                                            owner: nil) as? TextTableCellView else {
            return nil
        }
        view.labelText = cellText
        return view
    }

    private func createImageTableCellView(cellIdentifier: NSUserInterfaceItemIdentifier,
                                          cellImageDescription: String) -> ImageTableCellView? {
        guard let view = tableView.makeView(withIdentifier: cellIdentifier,
                                            owner: nil) as? ImageTableCellView else {
            return nil
        }
        view.imageValue = NSImage(systemSymbolName: cellImageDescription,
                                  accessibilityDescription: cellImageDescription) ?? NSImage()
        return view
    }
}

extension ContentView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return peopleList.count
    }
}

extension ContentView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let person = peopleList[row]
        guard let columnIdentifierRawValue = tableColumn?.identifier.rawValue,
              let column = TableViewColumns(rawValue: columnIdentifierRawValue) else {
          return nil
        }
        switch column {
        case .name:
            return createTextTableCellView(cellIdentifier: TextTableCellView.cellIdentifier,
                                           cellText: person.name)
        case .identifier:
            return createTextTableCellView(cellIdentifier: TextTableCellView.cellIdentifier,
                                           cellText: person.id)
        case.descriptionImage:
            return createImageTableCellView(cellIdentifier: ImageTableCellView.cellIdentifier,
                                            cellImageDescription: person.descriptionImage.rawValue)
        }
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        let selectedRow = tableView.selectedRow
        delegate?.selectedItemDidChange(self, selectedItem: selectedRow)
    }
}
