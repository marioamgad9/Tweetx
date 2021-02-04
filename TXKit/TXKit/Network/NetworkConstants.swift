//
//  NetworkConstants.swift
//  TXKit
//
//  Created by Mario Mouris on 04/02/2021.
//

import Foundation

/// Holds all the constants related to networking
struct NetworkConstants {
    
    /// Twitter constants (
    struct TwitterConstants {
        static let consumerKey = TwitterKeysProvider.consumerKey
        static let consumerSecretKey = TwitterKeysProvider.consumerSecretKey
        static let callbackURL = URL(string: "tweetxsignin://")!
    }
}
