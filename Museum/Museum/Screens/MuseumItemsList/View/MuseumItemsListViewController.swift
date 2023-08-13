//
//  MuseumItemsListViewController.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import UIKit

final class MuseumItemsListViewController: UIViewController {

    // MARK: - Internal variables

    var presenter: MuseumItemsListPresentation? {
        didSet {
            presenter?.load()
            dataSource.setDelegate(presenter)
        }
    }

    // MARK: - Private variables

    private lazy var collectionView: UICollectionView = makeCollectionView()
    private let dataSource: MuseumItemsListCollectionViewDataSourcing

    // MARK: - Initialisers

    init(
        dataSource: MuseumItemsListCollectionViewDataSourcing = MuseumItemsListCollectionViewDataSource()
    ) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
        setUp()
        dataSource.configureDataSource(for: collectionView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - MuseumItemsListViewable

extension MuseumItemsListViewController: MuseumItemsListViewable {
    func applySnapshot(items: [ArtObject]) {
        dataSource.applySnapshot(items: items)
    }

    func showRefreshButton() {
        let refreshAction = UIAction { [weak self] _ in
            self?.presenter?.fetchMuseumItems(showLoading: true)
            self?.hideRefreshButton()
        }
        let refreshButton = UIBarButtonItem(systemItem: .refresh, primaryAction: refreshAction)
        refreshButton.tintColor = .black
        navigationItem.rightBarButtonItem = refreshButton
    }

    func hideRefreshButton() {
        navigationItem.rightBarButtonItem = nil
    }
}

// MARK: UICollectionViewDelegate

extension MuseumItemsListViewController: UICollectionViewDelegate {
    func collectionView(
        _: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let item = dataSource.museumItem(at: indexPath.row)
        presenter?.didTapArtObject(item)
    }
}

// MARK: - Helpers

extension MuseumItemsListViewController {
    private func setUp() {
        view.backgroundColor = .white
        view.fit(childView: collectionView)
    }

    private func makeCollectionView() -> UICollectionView {
        let compositionalLayoutMaker = MuseumItemsListCompositionalLayoutMaker()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: compositionalLayoutMaker.makeCompositionalLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        return collectionView
    }
}
