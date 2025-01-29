//
//  SessionManager.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 22/01/2025.
//

import Foundation

class SessionManager {

    // MARK: - Private properties

    private let userDefaults: UserDefaults

    // MARK: - Life Cycle

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    // MARK: - Public functions

    func savePeopleList(_ peopleList: [Person]) {
        userDefaults.set(encodePeopleListToJSON(peopleList: peopleList),
                         forKey: UserDefaultsKeys.peopleList.key)
    }

    func getPeopleList() -> [Person]? {
        return decodePeopleListFromJSON(data: userDefaults.data(
            forKey: UserDefaultsKeys.peopleList.key))
    }

    // MARK: - Private functions

    private func encodePeopleListToJSON(peopleList: [Person]) -> Data? {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(peopleList)
            return data
        } catch {
            return nil
        }
    }

    private func decodePeopleListFromJSON(data: Data?) -> [Person]? {
        if let data {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([Person].self, from: data)
            } catch {
                return nil
            }
        }
        return nil
    }
}
