//
//  MuseumItemCollectionViewCellConfiguration.swift
//  Museum
//
//  Created by Onur Torna on 11.08.2023.
//

import Foundation

protocol MuseumItemCollectionViewCellConfiguration {
    var imageURL: URL { get }
    var title: String { get }
    var artistName: String { get }
}
