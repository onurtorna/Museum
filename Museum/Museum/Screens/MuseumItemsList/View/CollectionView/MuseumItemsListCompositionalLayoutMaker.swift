//
//  MuseumItemsListCompositionalLayoutMaker.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Foundation
import UIKit

struct MuseumItemsListCompositionalLayoutMaker {
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        .init { _, layoutEnvironment -> NSCollectionLayoutSection? in
            let section = makeLayoutSection(
                type: .artObjects,
                layoutEnvironment: layoutEnvironment
            )
            let header = makeHeader()
            section?.boundarySupplementaryItems = [header]
            return section
        }
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

    private func makeHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(Constant.headerHeight)
        )
        return .init(
            layoutSize: itemSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
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
        group.interItemSpacing = .fixed(Spacing.small)

        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(
            top: Spacing.xLarge,
            leading: Spacing.xLarge,
            bottom: Spacing.xLarge,
            trailing: Spacing.xLarge
        )
        section.interGroupSpacing = Spacing.large
        section.boundarySupplementaryItems = [makeHeader()]
        return section
    }
}

// MARK: - Constants

extension MuseumItemsListCompositionalLayoutMaker {
    private enum Constant {
        static let headerHeight: CGFloat = 32.0
    }
}
