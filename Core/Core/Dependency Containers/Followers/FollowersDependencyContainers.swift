//
//  FollowersDependencyContainers.swift
//  Core
//
//  Created by Mario Mouris on 03/02/2021.
//

import Main
import Followers
import TXKit

/// The dependency container that holds the dependency graph for the followers flow
public class FollowersDependencyContainer {
    
    // MARK: - Properties from parent container
    let sharedMainViewModel: MainViewModel
    
    // MARK: - Long lived dependencies
    /// The shared coordinator for the followers flow
    weak var sharedFollowersCoordinator: FollowersCoordinator!
    let sharedFollowersRemoteAPI: FollowersRemoteAPI
    
    // MARK: - Initializer
    init(appDependencyContainer: TXAppDependencyContainer) {
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
        self.sharedFollowersRemoteAPI = TXFollowerRemoteAPI()
    }
    
    // MARK: - Methods
    func makeFollowersViewController() -> FollowersNavigationController {
        return FollowersNavigationController()
    }
    
    // Followers list
    func makeFollowersListViewController() -> FollowersListViewController {
        return FollowersListViewController(viewModel: makeFollowersListViewModel())
    }
    
    func makeFollowersListViewModel() -> FollowersListViewModel {
        return FollowersListViewModel(followersRemoteAPI: sharedFollowersRemoteAPI,
                                      followersNavigator: sharedFollowersCoordinator)
    }
}
