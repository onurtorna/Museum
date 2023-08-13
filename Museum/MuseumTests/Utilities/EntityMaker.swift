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

    static func makeArtObjectDetail(
        objectNumber: String = "",
        title: String = "",
        longTitle: String = "",
        description: String = "",
        principalOrFirstMaker: String = "",
        webImage: ImageEntity = makeImageEntity()
    ) -> ArtObjectDetail {
        ArtObjectDetail(
            objectNumber: objectNumber,
            title: title,
            longTitle: longTitle,
            description: description,
            principalOrFirstMaker: principalOrFirstMaker,
            webImage: webImage
        )
    }

    static func makeImageEntity(
        url: URL = .init(string: "www.rijksmuseum.nl")!,
        width: Int = 100,
        height: Int = 100
    ) -> ImageEntity {
        ImageEntity(url: url, width: width, height: height)
    }

    static func makeArtObjectList(itemCount: Int) -> [ArtObject] {
        Array(repeating: EntityMaker.makeArtObject(), count: itemCount)
    }
}
