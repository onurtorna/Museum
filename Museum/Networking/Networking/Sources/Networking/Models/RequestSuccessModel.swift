//
//  RequestSuccessModel.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

// Encapsulates response after a successful network call
public struct RequestSuccessModel {
    let data: Data
    let response: URLResponse
}
