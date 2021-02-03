//
//  TweetCellViewModel.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import TXKit

/// The view model of the TwitterTableViewCell
class TweetCellViewModel {
    
    // MARK: - Properties
    let tweet: Tweet
    let name: String
    let twitterHandle: String
    let content: String?
    let time: String
    let profilePictureURL: URL?
    
    // MARK: - Initializer
    init(tweet: Tweet) {
        self.tweet = tweet
        self.name = tweet.user.name
        self.twitterHandle = tweet.user.twitterHandle
        self.content = tweet.content
        self.time = "3m"
        
        if let profilePicture = tweet.user.profilePicture {
            self.profilePictureURL = URL(string: profilePicture)
        } else {
            self.profilePictureURL = nil
        }
    }
}
