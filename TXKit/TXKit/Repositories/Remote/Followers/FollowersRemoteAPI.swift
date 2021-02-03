//
//  FollowersRemoteAPI.swift
//  TXKit
//
//  Created by Mario Mouris on 03/02/2021.
//

import PromiseKit

/// Handles getting the followers and their info
public protocol FollowersRemoteAPI {
    func getFollowers() -> Promise<[TwitterUser]>
}
