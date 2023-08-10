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
}
