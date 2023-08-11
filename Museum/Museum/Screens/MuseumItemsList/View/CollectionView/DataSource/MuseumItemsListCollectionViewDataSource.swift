//
//  MuseumItemsListCollectionViewDataSource.swift
//  Museum
//
//  Created by Onur Torna on 10.08.2023.
//

import UIKit

final class MuseumItemsListCollectionViewDataSource {

    // MARK: - Type Aliases

    private typealias DataSource = UICollectionViewDiffableDataSource<
        MuseumItemsListSection,
        ArtObject
    >

    private typealias Snapshot = NSDiffableDataSourceSnapshot<
        MuseumItemsListSection,
        ArtObject
    >

    private typealias MuseumItemCellRegistration = UICollectionView.CellRegistration<
        MuseumItemCollectionViewCell,
        MuseumItemCollectionViewCellConfiguration
    >

    private typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<
        MuseumItemsListSectionHeaderView
    >

    // MARK: - Private properties

    private var dataSource: DataSource?
    private var dataSourceCollectionView: UICollectionView?
    weak var delegate: MuseumItemsListCollectionViewDataSourceDelegate?
}

// MARK: - MuseumItemsListCollectionViewDataSourcing

extension MuseumItemsListCollectionViewDataSource: MuseumItemsListCollectionViewDataSourcing {
    func configureDataSource(for collectionView: UICollectionView) {
        dataSourceCollectionView = collectionView
        setUpDataSource()
    }

    func applySnapshot(items: [ArtObject]) {
        var snapshot = dataSource?.snapshot() ?? makeDefaultSnapshot()
        snapshot.appendItems(items, toSection: .artObjects)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    func setDelegate(_ delegate: MuseumItemsListCollectionViewDataSourceDelegate?) {
        self.delegate = delegate
    }
}

// MARK: - Set Up Data Source

extension MuseumItemsListCollectionViewDataSource {
    private func setUpDataSource() {
        guard let dataSourceCollectionView else {
            return
        }
        let optionCellRegistration = makeMuseumItemCellRegistration()

        dataSource = DataSource(collectionView: dataSourceCollectionView) {
            collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: optionCellRegistration,
                for: indexPath,
                item: item
            )
        }
        dataSource?.apply(makeDefaultSnapshot(), animatingDifferences: false)
        setUpSupplementaryViewProvider()
    }

    private func setUpSupplementaryViewProvider() {
        guard let dataSource else { return }
        let headerRegistration = makeHeaderRegistration()
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            return collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: indexPath
            )
        }
    }

    private func makeDefaultSnapshot() -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.artObjects])
        return snapshot
    }

    // MARK: - Cell Registration

    private func makeMuseumItemCellRegistration() -> MuseumItemCellRegistration {
        .init(handler: { [weak self] cell, indexPath, item in
            let interactor = MuseumItemCollectionViewCellInteractor()
            interactor.output = cell
            cell.interactor = interactor
            cell.configure(with: item)

            self?.checkForPaginationRequest(itemIndex: indexPath.row)
        })
    }

    private func makeHeaderRegistration() -> HeaderRegistration {
        .init(
            elementKind: UICollectionView.elementKindSectionHeader,
            handler: { _, _, _ in
                // Left blank intentionally, no customisation needed for this header
            })
    }
}

// MARK: - Pagination

extension MuseumItemsListCollectionViewDataSource {
    private func checkForPaginationRequest(itemIndex: Int) {
        guard dataSource?.snapshot().numberOfItems(inSection: .artObjects) == itemIndex + 3 else {
            return
        }
        delegate?.paginationRequested()
    }
}
