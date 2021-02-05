//
//  Follower.swift
//  TXKit
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation
import Swifter

/// Represents an instance of a user in Twitter
public struct TwitterUser {
    
    // MARK: - Properties
    public let id: String
    public let name: String
    public let twitterHandle: String
    public let bio: String?
    public let profilePicture: String?
    public let backgroundImage: String?
    
    // MARK: - Methods
    init(from json: JSON) {
        self.id = json["id_str"].string ?? ""
        self.name = json["name"].string ?? ""
        self.twitterHandle = json["screen_name"].string ?? ""
        self.bio = json["description"].string
        self.profilePicture = json["profile_image_url_https"].string
        self.backgroundImage = json["profile_background_image_url_https"].string
    }
    
    init(id: String, name: String, twitterHandle: String, bio: String?, profilePicture: String?, backgroundImage: String?) {
        self.id = id
        self.name = name
        self.twitterHandle = twitterHandle
        self.bio = bio
        self.profilePicture = profilePicture
        self.backgroundImage = backgroundImage
    }
    
    public static func dummyValue() -> TwitterUser {
        return TwitterUser(id: "0", name: "", twitterHandle: "", bio: "", profilePicture: "", backgroundImage: "")
    }
}
