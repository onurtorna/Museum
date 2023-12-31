//
//  GetMuseumItemsResponse.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Foundation

struct GetMuseumItemsResponse: Decodable {
    let count: Int
    let artObjects: [ArtObject]
}
