//
//  NetworkURLRequestMaking.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

public protocol NetworkURLRequestMaking {
    func makeURLRequest<T: URLRequestable>(with requestable: T) throws -> URLRequest
}
