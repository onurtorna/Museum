//
//  MuseumItemsListServing.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Networking

protocol MuseumItemsListServing: AnyObject {
    /// Returns museum items as list or a network error in failure case
    func getMuseumItems() async -> Result<GetMuseumItemsResponse, NetworkError>
}
