//
//  MuseumItemDetailViewMock.swift
//  MuseumTests
//
//  Created by Onur Torna on 13.08.2023.
//

import Foundation
@testable import Museum

final class MuseumItemDetailViewMock: MuseumItemDetailViewable {

    private(set) var setItemImageURLParameter: URL?
    func setItemImageURL(_ url: URL) {
        setItemImageURLParameter = url
    }

    private(set) var setItemParameters: (title: String, description: String)?
    func setItem(title: String, description: String) {
        setItemParameters = (title: title, description: description)
    }

    var setImageViewHeightToWeightRatioParameter: CGFloat?
    func setImageViewHeightToWeightRatio(_ multiplier: CGFloat) {
        setImageViewHeightToWeightRatioParameter = multiplier
    }
}
