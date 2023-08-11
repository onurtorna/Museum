//
//  MuseumItemsListPresentation.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

// MARK: - MuseumItemsListPresentation

protocol MuseumItemsListPresentation: AnyObject, MuseumItemsListCollectionViewDataSourceDelegate {
    func load()
}
