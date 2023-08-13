//
//  GetMuseumItemDetailResponse.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import Foundation

struct GetMuseumItemDetailResponse: Decodable {
    let count: Int
    let artObject: ArtObject
}
