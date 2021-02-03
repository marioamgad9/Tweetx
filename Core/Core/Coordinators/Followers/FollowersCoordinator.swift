//
//  FollowersCoordinator.swift
//  Core
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common
import Followers
import TXKit

typealias FollowersVcFactory = () -> FollowersNavigationController
typealias FollowersListVcFactory = () -> FollowersListViewController
typealias FollowerDetailsVcFactory = (TwitterUser) -> FollowerDetailsViewController

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
    private let followersListVcFactory: FollowersListVcFactory
    private let followerDetailsVcFactory: FollowerDetailsVcFactory
    
    // MARK: - Initializer
    init(rootVc: NiblessViewController,
         followersVcFactory: @escaping FollowersVcFactory,
         followersListVcFactory: @escaping FollowersListVcFactory,
         followerDetailsVcFactory: @escaping FollowerDetailsVcFactory) {
        self.rootVc = rootVc
        self.followersVcFactory = followersVcFactory
        self.followersListVcFactory = followersListVcFactory
        self.followerDetailsVcFactory = followerDetailsVcFactory
    }
    
    // MARK: - Methods
    /// Starts the app coordinator flow, with attaching the onboarding view controller to the root
    public func start(completionHandler: CoordinatorStartCompletionHandler? = nil) {
        followersVc = followersVcFactory()
        followersVc.delegate = self
        rootVc.addFullScreen(childViewController: followersVc)
        navigate(to: .followersList)
        isStarted = true
        completionHandler?()
    }
    
    /// Finishes the flow started if it can finish
    func finish(completionHandler: CoordinatorStartCompletionHandler? = nil) {
        rootVc.remove(childViewController: followersVc)
        isStarted = false
    }
    
    /// Navigates to the followers list view
    func goToFollowersListView() {
        let followersListVc = followersListVcFactory()
        followersVc.pushViewController(followersListVc, animated: false)
    }
    
    /// Navigates to follwoer details
    func goToFollowerDetailsView(follower: TwitterUser) {
        let followerDetailsVc = followerDetailsVcFactory(follower)
        followersVc.pushViewController(followerDetailsVc, animated: true)
    }
}

// MARK: - Followers navigator
extension FollowersCoordinator: FollowersNavigator {
    public func navigate(to followersView: FollowersView) {
        switch followersView {
        case .followersList:
            goToFollowersListView()
        case .followerDetails(let follower):
            goToFollowerDetailsView(follower: follower)
        }
    }
}

// MARK: - Navigation delegate
extension FollowersCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        guard let viewToBeShown = followersView(associatedWith: viewController) else { return }
        followersVc.viewStateWillChange(followersView: viewToBeShown)
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        guard let shownView = followersView(associatedWith: viewController) else { return }
        followersVc.viewStateDidChange(followersView: shownView)
    }
    
    /// Gets the FollowersView out of the shown view controller
    func followersView(associatedWith viewController: UIViewController) -> FollowersView? {
        switch viewController {
        case is FollowersListViewController:
            return .followersList
        case is FollowerDetailsViewController:
            return .followerDetails(follower: TwitterUser.dummyValue())
        default:
            assertionFailure("Encountered unexpected child view controller type in FollowersCoordinator")
            return nil
        }
    }
}
