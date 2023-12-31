//
//  MuseumItemsListCollectionViewDataSourcing.swift
//  Museum
//
//  Created by Onur Torna on 11.08.2023.
//

import UIKit

protocol MuseumItemsListCollectionViewDataSourcing {
    func configureDataSource(for collectionView: UICollectionView)
    func applySnapshot(items: [ArtObject])
    func museumItem(at index: Int) -> ArtObject?
    func setDelegate(_ delegate: MuseumItemsListCollectionViewDataSourceDelegate?)
}
