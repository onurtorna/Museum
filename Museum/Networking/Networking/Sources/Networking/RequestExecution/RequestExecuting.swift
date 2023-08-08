//
//  RequestExecuting.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

protocol RequestExecuting {
    /// URL Session of the request to be executed
    var session: URLSession { get }

    /// Executes regular request with given URLRequest and returns success model or an error
    func execute(_ request: URLRequest) async -> Result<RequestSuccessModel, Error>
}

