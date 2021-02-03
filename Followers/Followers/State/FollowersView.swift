//
//  FollowersView.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation
import TXKit

/// The various states a Followers view can be in.
public enum FollowersView {
    case followersList
    case followerDetails(follower: TwitterUser)
}
