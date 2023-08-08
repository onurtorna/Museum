//
//  RequestAdapterMock.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation
@testable import Networking

final class RequestAdapterMock: RequestAdapting {
    var invokedAdapt = false

    func adapt(request: URLRequest) -> URLRequest {
        invokedAdapt = true
        return request
    }
}
