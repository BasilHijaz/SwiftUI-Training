//
//  Person.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 06/01/2025.
//

import Cocoa

class Person: Codable {

    // MARK: - Public properties

    var name: String
    var id: String
    var descriptionImage: DescriptionImageOptions
    var description: String {
        return "\(name) - \(id)"
    }

    // MARK: - Life Cycle

    init(name: String, id: String, descriptionImage: DescriptionImageOptions) {
        self.name = name
        self.id = id
        self.descriptionImage = descriptionImage
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
}
