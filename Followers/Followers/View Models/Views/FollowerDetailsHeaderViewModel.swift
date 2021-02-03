//
//  FollowerDetailsHeaderViewModel.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import TXKit

/// The view model of the FollowerDetailsHeaderViewCell
class FollowerDetailsHeaderViewModel {
    
    // MARK: - Properties
    let name: String
    let twitterHandle: String
    let bio: String?
    let profilePictureURL: URL?
    let backgroundImageURL: URL?
    
    // MARK: - Initializer
    init(follower: TwitterUser) {
        self.name = follower.name
        self.twitterHandle = follower.twitterHandle
        self.bio = follower.bio
        
        if let profilePicture = follower.profilePicture {
            self.profilePictureURL = URL(string: profilePicture)
        } else {
            self.profilePictureURL = nil
        }
        
        if let backgroundImage = follower.backgroundImage {
            self.backgroundImageURL = URL(string: backgroundImage)
        } else {
            self.backgroundImageURL = nil
        }
    }
}
