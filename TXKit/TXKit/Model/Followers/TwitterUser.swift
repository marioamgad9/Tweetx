//
//  Follower.swift
//  TXKit
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation

/// Represents an instance of a user in Twitter
public struct TwitterUser: Codable {
    let name: String
    let twitterHandle: String
    let bio: String?
    let profilePicture: String?
}
