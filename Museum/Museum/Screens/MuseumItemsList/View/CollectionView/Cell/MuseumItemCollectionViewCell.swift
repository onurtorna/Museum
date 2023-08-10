//
//  MuseumItemCollectionViewCell.swift
//  Museum
//
//  Created by Onur Torna on 10.08.2023.
//

import UIKit

final class MuseumItemCollectionViewCell: UICollectionViewCell {

    // MARK: - Private variables

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = makeLabel()
        label.font = Font.body3
        return label
    }()

    private lazy var artistNameLabel: UILabel = {
        let label = makeLabel()
        label.font = Font.regularBody4
        return label
    }()

    private lazy var labelContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.xSmall
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins.bottom = Spacing.xSmall
        return stackView
    }()

    // MARK: - Initialiser

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal functions

    func configure(with configuration: MuseumItemCollectionViewCellConfiguration) {
        titleLabel.text = configuration.title
        artistNameLabel.text = configuration.artistName
    }
}

// MARK: - Helpers

extension MuseumItemCollectionViewCell {
    private func setUp() {
        setUpSubviews()
        applyStyling()
    }

    private func setUpSubviews() {
        contentView.fit(childView: imageView)
        contentView.fit(childView: labelContainerStackView)
        labelContainerStackView.addArrangedSubview(UIView()) // Spacer
        labelContainerStackView.addArrangedSubview(titleLabel)
        labelContainerStackView.addArrangedSubview(artistNameLabel)
    }

    private func applyStyling() {
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12.0
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }
}
