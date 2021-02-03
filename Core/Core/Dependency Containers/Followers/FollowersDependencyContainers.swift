//
//  FollowersDependencyContainers.swift
//  Core
//
//  Created by Mario Mouris on 03/02/2021.
//

import Main
import Followers

/// The dependency container that holds the dependency graph for the followers flow
public class FollowersDependencyContainer {
    
    // MARK: - Properties from parent container
    let sharedMainViewModel: MainViewModel
    
    // MARK: - Long lived dependencies
    /// The shared coordinator for the followers flow
    weak var sharedFollowersCoordinator: FollowersCoordinator!
    
    // MARK: - Initializer
    init(appDependencyContainer: TXAppDependencyContainer) {
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
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
        return FollowersListViewModel(followersNavigator: sharedFollowersCoordinator)
    }
}
