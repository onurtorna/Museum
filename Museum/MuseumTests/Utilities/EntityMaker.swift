//
//  EntityMaker.swift
//  MuseumTests
//
//  Created by Onur Torna on 13.08.2023.
//

import Foundation
@testable import Museum

enum EntityMaker {
    static func makeArtObject(
        objectNumber: String = "",
        title: String = "",
        longTitle: String = "",
        principalOrFirstMaker: String = "",
        headerImage: ImageEntity = makeImageEntity(),
        webImage: ImageEntity = makeImageEntity()
    ) -> ArtObject {
        ArtObject(
            objectNumber: objectNumber,
            title: title,
            longTitle: longTitle,
            principalOrFirstMaker: principalOrFirstMaker,
            headerImage: headerImage,
            webImage: webImage
        )
    }

    static func makeImageEntity(
        url: URL = .init(string: "www.rijksmuseum.nl")!
    ) -> ImageEntity {
        ImageEntity(url: url, width: 100, height: 100)
    }

    static func makeArtObjectList(itemCount: Int) -> [ArtObject] {
        Array(repeating: EntityMaker.makeArtObject(), count: itemCount)
    }
}
