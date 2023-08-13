//
//  MuseumItemCollectionViewCellInteractorOutputProtocol.swift
//  Museum
//
//  Created by Onur Torna on 11.08.2023.
//

import UIKit

protocol MuseumItemCollectionViewCellInteractorOutputProtocol: AnyObject {
    @MainActor
    func didReceiveImage(image: UIImage)

    @MainActor
    func didFailImage()
}
