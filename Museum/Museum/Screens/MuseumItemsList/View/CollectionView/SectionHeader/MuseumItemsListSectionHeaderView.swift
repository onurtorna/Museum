//
//  MuseumItemsListSectionHeaderView.swift
//  Museum
//
//  Created by Onur Torna on 10.08.2023.
//

import UIKit

final class MuseumItemsListSectionHeaderView: UICollectionReusableView {

    // MARK: - Private variables

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.title3
        label.textAlignment = .center
        label.text = "Art Objects"
        return label
    }()

    // MARK: - Initialisers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }


    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers

extension MuseumItemsListSectionHeaderView {
    private func setUp() {
        fit(childView: headerLabel)
    }
}
