//
//  ArtObject+MuseumItemCollectionViewCellConfiguration.swift
//  Museum
//
//  Created by Onur Torna on 10.08.2023.
//

import Foundation

extension ArtObject: MuseumItemCollectionViewCellConfiguration {
    var imageURL: URL {
        webImage.url
    }

    var artistName: String {
        principalOrFirstMaker
    }
}
