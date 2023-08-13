//
//  MuseumItemDetailViewController.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import UIKit

final class MuseumItemDetailViewController: UIViewController {

    // MARK: - Internal variables

    var presenter: MuseumItemDetailPresentation?

    // MARK: - Private variables

    private var imageViewHeightToWidthContraint: NSLayoutConstraint?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentStackView = makeStackView()
    private lazy var labelStackView = makeStackView(
        edgeInsets: .init(
            top: 0,
            leading: Spacing.xLarge,
            bottom: Spacing.xLarge,
            trailing: Spacing.xLarge
        )
    )
    private let imageView = UIImageView()
    private lazy var titleLabel = makeLabel(font: Font.title2)
    private lazy var descriptionLabel = makeLabel(font: Font.regularBody3)

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

// MARK: - MuseumItemsListViewable

extension MuseumItemDetailViewController: MuseumItemDetailViewable {
}

// MARK: - Helpers

extension MuseumItemDetailViewController {
    private func setUp() {
        view.backgroundColor = .white
        setUpSubviews()
        setUpConstraints()
    }

    private func setUpSubviews() {
        view.fit(childView: scrollView)
        scrollView.fit(childView: contentStackView)

        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(labelStackView)

        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
    }

    private func setUpConstraints() {
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}

// MARK: - View factory

extension MuseumItemDetailViewController {
    private func makeStackView(edgeInsets: NSDirectionalEdgeInsets = .zero) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.xLarge
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = edgeInsets
        return stackView
    }

    private func makeLabel(font: UIFont) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = font
        return label
    }
}
