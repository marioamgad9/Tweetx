//
//  Follower.swift
//  TXKit
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation

/// Represents an instance of a user in Twitter
public struct TwitterUser: Codable {
    
    // MARK: - Properties
    public let id: Int
    public let name: String
    public let twitterHandle: String
    public let bio: String?
    public let profilePicture: String?
    public let backgroundImage: String?
    
    // MARK: - Methods
    public static func dummyValue() -> TwitterUser {
        return TwitterUser(id: 0, name: "", twitterHandle: "", bio: "", profilePicture: "", backgroundImage: "")
    }
}
