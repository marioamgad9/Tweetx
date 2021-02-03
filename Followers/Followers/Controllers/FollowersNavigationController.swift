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
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        isNavigationBarHidden = false
    }
}
