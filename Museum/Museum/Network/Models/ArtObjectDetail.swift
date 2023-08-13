//
//  ArtObjectDetail.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import Foundation

struct ArtObjectDetail: Decodable {
    let objectNumber: String
    let title: String
    let longTitle: String
    let description: String
    let principalOrFirstMaker: String
    let webImage: ImageEntity
}
