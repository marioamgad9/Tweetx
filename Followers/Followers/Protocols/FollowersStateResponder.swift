//
//  FollowersStateResponder.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation

/// Handles state change notifications
public protocol FollowersStateResponder {
    func viewStateWillChange(followersView: FollowersView)
    func viewStateDidChange(followersView: FollowersView)
}
