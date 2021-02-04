//
//  TXKitError.swift
//  TXKit
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation

public enum TXKitError: Error {
    
    // MARK: - Internal errors
    case keychainError
    case noInternet
    case noUserIDFound
    
    // MARK: - API errors
    case badAPIRequest
    case conflict
    case notFound
    
    // MARK: - Auth errors
    case unauthorized
    
    // MARK: - Unknown error
    case unknown
    case internalError
}
