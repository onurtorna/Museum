//
//  MuseumItemsListViewController.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import UIKit

final class MuseumItemsListViewController: UIViewController {

    // MARK: - Private variables

    private lazy var collectionView: UICollectionView = makeCollectionView()

    // MARK: - Initialisers

    init() {
        super.init(nibName: nil, bundle: nil)
        setUp()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        return collectionView
    }
}
