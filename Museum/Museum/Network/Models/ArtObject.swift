//
//  ArtObject.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Foundation

struct ArtObject: Decodable {
    let id: String
    let title: String
    let longTitle: String
    let headerImage: HeaderImage
}
