//
//  FollowersNavigationController.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common

/// The parent navigation controller for the followers flow
public class FollowersNavigationController: TXNavigationController {

    // MARK: - Methods
    func hideOrShowNavigationBarIfNeeded(for view: FollowersView, animated: Bool) {
        setNavigationBarHidden(view.hidesNavigationBar(), animated: animated)
    }
}

// MARK: - View state responder
extension FollowersNavigationController: FollowersStateResponder {
    public func viewStateWillChange(followersView: FollowersView) {
        hideOrShowNavigationBarIfNeeded(for: followersView, animated: true)
    }
    
    public func viewStateDidChange(followersView: FollowersView) { }
}

