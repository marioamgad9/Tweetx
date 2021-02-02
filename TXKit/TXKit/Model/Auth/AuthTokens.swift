//
//  AuthTokens.swift
//  TXKit
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation

public typealias RefreshToken = String
public typealias AccessToken = String

/// Holds the refresh and access tokens
public struct AuthTokens: Codable {
    
    // MARK: - Properties
    public let refresh: RefreshToken
    public let access: AccessToken
    
    // MARK: - Initializer
    internal init(refresh: RefreshToken, access: AccessToken) {
        self.refresh = refresh
        self.access = access
    }
}
