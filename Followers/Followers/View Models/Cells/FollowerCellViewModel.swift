//
//  FollowerCellViewModel.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import TXKit

/// The view model of the FollowerTableViewCell
class FollowerCellViewModel {
    
    // MARK: - Properties
    let follower: TwitterUser
    let name: String
    let twitterHandle: String
    let bio: String?
    let profilePictureURL: URL?
    
    // MARK: - Initializer
    init(follower: TwitterUser) {
        self.follower = follower
        self.name = follower.name
        self.twitterHandle = follower.twitterHandle
        self.bio = follower.bio
        
        if let profilePicture = follower.profilePicture {
            self.profilePictureURL = URL(string: profilePicture)
        } else {
            self.profilePictureURL = nil
        }
    }
}

