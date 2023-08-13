//
//  MuseumItemDetailViewable.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import Foundation

protocol MuseumItemDetailViewable: AnyObject {
    func setItemImageURL(_ url: URL)
    func setItem(title: String, description: String)
    func setImageViewHeightToWeightRatio(_ multiplier: CGFloat)
}
