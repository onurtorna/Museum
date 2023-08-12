//
//  MuseumItemsListViewable.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Foundation

protocol MuseumItemsListViewable: AnyObject {
    func applySnapshot(items: [ArtObject])
    func showRefreshButton()
}
