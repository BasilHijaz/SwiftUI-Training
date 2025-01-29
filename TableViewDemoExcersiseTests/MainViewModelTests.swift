//
//  MainViewModelTests.swift
//  TableViewDemoExcersiseTests
//
//  Created by Basil Hijaz on 26/01/2025.
//

import XCTest
@testable import TableViewDemoExcersise

// TODO: (Future Work): Input (data) import from file.
final class MainViewModelTests: XCTestCase {

    // MARK: - Private properties

    private var viewModel: MainViewModel!
    private var mockPeopleList: [Person]!

    // MARK: - Life Cycle

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockPeopleList = getMockPeopleList()
        viewModel = .init(initialPeopleList: mockPeopleList)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        viewModel = nil
    }

    // MARK: - Public functions

    func testAddSinglePerson() {
        XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count)

        let expectation = XCTestExpectation(description: #function)

        viewModel.addPerson(with: "Basil", image: "star") { [weak self] person in
            guard let self else { return }
            viewModel.appendPersonToList(person: person)
            XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count + 1)
            XCTAssertEqual(viewModel.initialPeopleList.last, person)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func testAddPersonWithExistingName() {
        XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count)

        let expectation = XCTestExpectation(description: #function)

        viewModel.addPerson(with: "John", image: "pc") { [weak self] person in
            guard let self else { return }
            viewModel.appendPersonToList(person: person)
            XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count + 1)
            XCTAssertEqual(viewModel.initialPeopleList.last, person)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func testAddMultiplePeople() {
        XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count)

        let peopleToAdd: [(name: String, image: String)] = [("Alice", "star"), ("Kareem", "pc"),
                                                            ("Ayham", "pc"), ("Mohammad", "star")]

        // Cope with thread safety.
        for (name, image) in peopleToAdd {
            let expectation = XCTestExpectation(description: #function)
            viewModel.addPerson(with: name, image: image) { [weak self] person in
                guard let self else { return }
                viewModel.appendPersonToList(person: person)
                viewModel.filterPeopleList(tokens: [person.id])
                XCTAssertEqual(viewModel.filteredPeopleList.count, 1)
                XCTAssertEqual(viewModel.filteredPeopleList.first, person)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 3.0)
        }

        XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count + peopleToAdd.count)
    }

    func testAddPersonWithNonExistingImage() {
        XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count)

        let expectation = XCTestExpectation(description: #function)

        viewModel.addPerson(with: "Basil", image: "non_existing_image") { [weak self] person in
            guard let self else { return }
            viewModel.appendPersonToList(person: person)
            XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count + 1)
            XCTAssertEqual(viewModel.initialPeopleList.last, person)
            XCTAssertEqual(viewModel.initialPeopleList.last?.descriptionImage, DescriptionImageOptions.star)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func testDeleteFirstPerson() {
        XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count)

        let personToDelete: Person! = viewModel.initialPeopleList.first

        viewModel.deletePerson(clickedItem: 0)

        viewModel.filterPeopleList(tokens: [personToDelete.id])
        XCTAssertEqual(viewModel.filteredPeopleList.count, 0)
    }

    func testDeleteLastPerson() {
        XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count)

        let personToDelete: Person! = viewModel.initialPeopleList.last

        viewModel.deletePerson(clickedItem: viewModel.initialPeopleList.count - 1)

        viewModel.filterPeopleList(tokens: [personToDelete.id])
        XCTAssertEqual(viewModel.filteredPeopleList.count, 0)
    }

    func testDeleteNonExistingPerson() {
        XCTAssertNoThrow(viewModel.deletePerson(clickedItem: viewModel.initialPeopleList.count + 10))
    }

    func testFilterPeopleListWithEmptyTokensList() {
        XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count)

        viewModel.filterPeopleList(tokens: [])

        XCTAssertEqual(viewModel.filteredPeopleList, viewModel.initialPeopleList)
    }

    func testFilterPeopleListUsingId() {
        XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count)

        let firstPerson = viewModel.initialPeopleList.first!

        viewModel.filterPeopleList(tokens: [firstPerson.id])

        XCTAssertEqual(viewModel.filteredPeopleList.count, 1)
        XCTAssertEqual(viewModel.filteredPeopleList.first, firstPerson)
    }

    func testFilterPeopleListOnEmptyStringAsToken() {
        XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count)

        viewModel.filterPeopleList(tokens: [""])

        XCTAssertEqual(viewModel.filteredPeopleList, [])
    }

    func testFilterPeopleListUsingName() {
        XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count)

        let lastPerson = viewModel.initialPeopleList.last!

        viewModel.filterPeopleList(tokens: [lastPerson.name])

        XCTAssertEqual(viewModel.filteredPeopleList.count, 1)
        XCTAssertEqual(viewModel.filteredPeopleList.first, lastPerson)
    }

    func testCheckIfNameIsUniqueExactMatch() {
        XCTAssertEqual(viewModel.initialPeopleList.count, mockPeopleList.count)

        for person in viewModel.initialPeopleList {
            XCTAssertFalse(viewModel.checkIfPersonNameIsUnique(name: person.name))
        }
    }

    // MARK: - Private functions

    private func getMockPeopleList() -> [Person] {
        return [Person(name: "John", id: UUID().uuidString, descriptionImage: DescriptionImageOptions.pc),
                Person(name: "Jane", id: UUID().uuidString, descriptionImage: DescriptionImageOptions.star),
                Person(name: "Jack", id: UUID().uuidString, descriptionImage: DescriptionImageOptions.star),
                Person(name: "Ali", id: UUID().uuidString, descriptionImage: DescriptionImageOptions.pc)]
    }
}
