//
//  DescriptionImageOptions.swift
//  TableViewDemoExcersise
//
//  Created by Basil Hijaz on 21/01/2025.
//

import Foundation

enum DescriptionImageOptions: String, CaseIterable, Codable {
    case star
    case pc
}

extension DescriptionImageOptions {
    var title: String {
        switch self {
        case .star:
            return LocalizationKey.descriptionImageStarOption.text
        case .pc:
            return LocalizationKey.descriptionImagePcOption.text
        }
    }
}

extension DescriptionImageOptions: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}
