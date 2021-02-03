//
//  FollowersListRootView.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common

/// The root view for FollowersListViewController
class FollowersListRootView: NiblessView, Loadable {
    
    // MARK: - Views
    var loaderView = LoaderView(style: .transparent, animated: true)
    
    // MARK: - Initializer
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }
    
    // MARK: - Methods
    override func configureViewHierarchy() {
        // Bring loader to front
        bringSubviewToFront(loaderView)
    }
    
    override func viewHierarchyDidConfigure() {
        // Set background color
        backgroundColor = .blue
    }
}
