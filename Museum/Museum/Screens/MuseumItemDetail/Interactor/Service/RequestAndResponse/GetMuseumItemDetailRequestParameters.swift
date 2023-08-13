//
//  GetMuseumItemDetailRequestParameters.swift
//  Museum
//
//  Created by Onur Torna on 13.08.2023.
//

import Foundation

struct GetMuseumItemDetailRequestParameters: Encodable {
    let key: String = Secret.apiKey
}
