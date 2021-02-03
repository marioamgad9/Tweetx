//
//  FollowersNavigator.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation

/// Defines how the navigation should work
public protocol FollowersNavigator {
    /// Navigates to the appropriate view
    func navigate(to followersView: FollowersView)
}
