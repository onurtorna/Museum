//
//  MuseumItemsListCompositionalLayoutMaker.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Foundation
import UIKit

final class MuseumItemsListCompositionalLayoutMaker {
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout
            { [weak self] _, layoutEnvironment -> NSCollectionLayoutSection? in
                guard let self else { return nil }
                let section = self.makeLayoutSection(
                    type: .artObjects,
                    layoutEnvironment: layoutEnvironment
                )
                return section
            }
        return layout
    }
}

// MARK: - Make Layout Section

extension MuseumItemsListCompositionalLayoutMaker {
    private func makeLayoutSection(
        type: MuseumItemsListSection,
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection? {
        switch type {
        case .artObjects:
            return makArtObjectsSectionLayout()
        }
    }
}

// MARK: - Make Section Layout

extension MuseumItemsListCompositionalLayoutMaker {
    private func makArtObjectsSectionLayout() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        let artObject = NSCollectionLayoutItem(layoutSize: itemSize)
        artObject.contentInsets = NSDirectionalEdgeInsets(
            top: .zero,
            leading: 6,
            bottom: 6,
            trailing: 6
        )
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.8)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: artObject,
            count: 2
        )
        // Section
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}

