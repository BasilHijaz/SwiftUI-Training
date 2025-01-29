//
//  UserDefaultsKeys.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 22/01/2025.
//

import Foundation

enum UserDefaultsKeys: String {
    case peopleList
}

extension UserDefaultsKeys {
    var key: String {
        self.rawValue
    }
}
