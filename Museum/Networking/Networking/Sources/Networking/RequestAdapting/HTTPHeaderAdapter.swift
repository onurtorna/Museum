//
//  HTTPHeaderAdapter.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

/// An adapter to apply given headers for every request before it is executed
public final class HTTPHeaderAdapter: RequestAdapting {

    // MARK: Private

    private var headerProvidingClosure: () -> ([String: String])

    // MARK: Lifecycle

    public init(headerProvidingClosure: @escaping () -> ([String: String])) {
        self.headerProvidingClosure = headerProvidingClosure
    }

    // MARK: Public

    public func adapt(request: URLRequest) -> URLRequest {
        var mutableRequest = request
        let headers = headerProvidingClosure()
        headers.forEach {
            mutableRequest.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        return mutableRequest
    }
}
