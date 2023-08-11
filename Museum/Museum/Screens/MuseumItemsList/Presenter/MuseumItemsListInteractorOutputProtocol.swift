//
//  MuseumItemsListInteractorOutputProtocol.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Foundation

protocol MuseumItemsListInteractorOutputProtocol: AnyObject {
    @MainActor
    func gotMuseumItems(items: [ArtObject], totalItemCount: Int)

    @MainActor
    func getMuseumItemsFailed(errorMessage: String)
}
