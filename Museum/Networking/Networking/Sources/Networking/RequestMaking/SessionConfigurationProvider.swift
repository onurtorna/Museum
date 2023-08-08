//
//  SessionConfigurationProvider.swift
//  
//
//  Created by Onur Torna on 08.08.2023.
//

import Foundation

enum SessionConfigurationProvider {
    static let sessionConfiguration: URLSessionConfiguration = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.waitsForConnectivity = true
        sessionConfiguration.timeoutIntervalForResource = 5 // Waiting time for reconnection if internet is not available
        sessionConfiguration.shouldUseExtendedBackgroundIdleMode = true
        sessionConfiguration.timeoutIntervalForRequest = 60
        return sessionConfiguration
    }()
}
