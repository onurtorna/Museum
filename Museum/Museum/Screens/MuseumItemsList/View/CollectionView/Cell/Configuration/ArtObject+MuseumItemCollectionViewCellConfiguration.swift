//
//  ArtObject+MuseumItemCollectionViewCellConfiguration.swift
//  Museum
//
//  Created by Onur Torna on 10.08.2023.
//

import Foundation

extension ArtObject: MuseumItemCollectionViewCellConfiguration {
    var imageURL: URL {
        headerImage.url
    }

    var artistName: String {
        principalOrFirstMaker
    }
}
