//
//  ViewModel.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 06/01/2025.
//

import Cocoa

private struct Configs {
    static let addPersonDelayPeriod: TimeInterval = 2.0
}

class MainViewModel {

    // MARK: - Public properties

    private(set) var initialPeopleList: [Person]
    private(set) var filteredPeopleList: [Person]

    // MARK: - Life Cycle

    init(initialPeopleList: [Person]) {
        self.initialPeopleList = initialPeopleList
        filteredPeopleList = initialPeopleList
    }

    // MARK: - Public functions

    func filterPeopleList(tokens: [String]) {
        guard !tokens.isEmpty else {
            filteredPeopleList = initialPeopleList
            return
        }
        filteredPeopleList = initialPeopleList.filter { person in
            tokens.allSatisfy { token in
                person.name.contains(token) || person.id.contains(token)
            }
        }
    }

    func deletePerson(clickedItem: Int) {
        guard clickedItem >= 0 && clickedItem < filteredPeopleList.count else { return }
        let person = filteredPeopleList[clickedItem]
        initialPeopleList.removeAll { personToDelete in
            personToDelete == person
        }
    }

    func addPerson(with name: String, image: String,
                   completion: @escaping (Person) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + Configs.addPersonDelayPeriod) { [weak self] in
            guard let self else { return }
            let descriptionImage = getDescriptionImageOption(identifier: image)
            let person = Person(name: name, id: UUID().uuidString,
                                descriptionImage: descriptionImage ?? DescriptionImageOptions.star)
            completion(person)
        }
    }

    func appendPersonToList(person: Person) {
        initialPeopleList.append(person)
    }

    func checkIfPersonNameIsUnique(name: String) -> Bool {
        return initialPeopleList.allSatisfy { $0.name != name }
    }

    // MARK: - Private functions

    private func getDescriptionImageOption(identifier: String) -> DescriptionImageOptions? {
        guard let descriptionImage = DescriptionImageOptions(rawValue: identifier) else {
            return nil
        }
        return descriptionImage
    }
}
