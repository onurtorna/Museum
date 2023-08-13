//
//  MuseumBaseURLHaving.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import Networking

protocol MuseumBaseURLHaving: BaseURLHaving { }

// MARK: - Default implementation

extension MuseumBaseURLHaving {
    var baseURL: String {
        "https://www.rijksmuseum.nl/api/nl/"
    }
}
