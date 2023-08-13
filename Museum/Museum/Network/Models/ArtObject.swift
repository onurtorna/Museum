//
//  ArtObject.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Foundation

struct ArtObject: Decodable {
    let objectNumber: String
    let title: String
    let longTitle: String
    let principalOrFirstMaker: String
    let headerImage: ImageEntity
    let webImage: ImageEntity
}

// MARK: - Hashable

extension ArtObject: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(objectNumber)
    }

    static func == (lhs: ArtObject, rhs: ArtObject) -> Bool {
        lhs.objectNumber == rhs.objectNumber
    }
}
