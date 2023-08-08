//
//  ResponseParsing.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

/// Protocol to encapsulate parsing layer of the network calls
protocol ResponseParsing {
    static func parseResponse<T: Decodable>(
        data: Data,
        responseType: T.Type
    ) -> Result<T, NetworkError>
}
