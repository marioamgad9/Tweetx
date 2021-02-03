//
//  FollowersCoordinator.swift
//  Core
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common
import Followers

typealias FollowersVcFactory = () -> FollowersNavigationController

/**
 The coordinator that handles the followers navigation.
 It's responsable of keeping track which vc is shown, and handles all the navigation.
 */
public class FollowersCoordinator: NSObject, Coordinator {

    // MARK: - Properties
    public var isStarted = false
    
    /// The view controller where all the other views are built upon
    private let rootVc: NiblessViewController
    
    /// The root vc for this coordinator
    private var followersVc: FollowersNavigationController!
    
    // Factories
    private let followersVcFactory: FollowersVcFactory
    
    // MARK: - Initializer
    init(rootVc: NiblessViewController,
         followersVcFactory: @escaping FollowersVcFactory) {
        self.rootVc = rootVc
        self.followersVcFactory = followersVcFactory
    }
    
    // MARK: - Methods
    /// Starts the app coordinator flow, with attaching the onboarding view controller to the root
    public func start(completionHandler: CoordinatorStartCompletionHandler? = nil) {
        followersVc = followersVcFactory()
        rootVc.addFullScreen(childViewController: followersVc)
        navigate(to: .followersList)
        isStarted = true
    }
    
    /// Finishes the flow started if it can finish
    func finish(completionHandler: CoordinatorStartCompletionHandler? = nil) {
        rootVc.remove(childViewController: followersVc)
        isStarted = false
    }
    
    /// Navigates to the followers list view
    func goToFollowersListView() {
        
    }
}

// MARK: - Followers navigator
extension FollowersCoordinator: FollowersNavigator {
    public func navigate(to followersView: FollowersView) {
        switch followersView {
        case .followersList:
            goToFollowersListView()
        }
    }
}
