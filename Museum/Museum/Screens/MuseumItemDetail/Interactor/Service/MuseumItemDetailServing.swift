//
//  MuseumItemDetailServing.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import Networking

protocol MuseumItemDetailServing: AnyObject {
    func getMuseumItemDetial(objectID: String) async -> Result<GetMuseumItemDetailResponse, NetworkError>
}
