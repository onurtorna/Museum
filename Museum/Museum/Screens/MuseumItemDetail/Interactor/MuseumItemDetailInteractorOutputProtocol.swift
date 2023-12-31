//
//  MuseumItemDetailInteractorOutputProtocol.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import Foundation

protocol MuseumItemDetailInteractorOutputProtocol: AnyObject {
    @MainActor
    func gotMuseumItemDetail(_ item: ArtObjectDetail)

    @MainActor
    func getMuseumItemDetailFailed(errorMessage: String)
}
