//
//  NetworkConstants.swift
//  TXKit
//
//  Created by Mario Mouris on 04/02/2021.
//

import Foundation

/// Holds all the constants related to networking
public struct NetworkConstants {
    
    /// Twitter constants (
    public struct TwitterConstants {
        static let consumerKey = TwitterKeysProvider.consumerKey
        static let consumerSecretKey = TwitterKeysProvider.consumerSecretKey
        public static let callbackURL = URL(string: "tweetxsignin://")!
    }
}
