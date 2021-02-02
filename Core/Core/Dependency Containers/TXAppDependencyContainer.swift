//
//  TXAppDependencyContainer.swift
//  Core
//
//  Created by Mario Mouris on 02/02/2021.
//

import Foundation
import Main
import Launch

/**
 The root dependency container that contains the whole dependency graph for the app.
 It also handles creating child dependency containers.
 */
public class TXAppDependencyContainer {
    
    // MARK: - Long-lived dependencies
    /// The shared root app coordinator
    public private(set) lazy var sharedAppCoordinator: TXAppCoordinator = {
        return makeAppCoordinator()
    }()
    
    /// The shared view model that monitors whether the current state is launching, onboarding or signedIn
    lazy var sharedMainViewModel: MainViewModel = {
        return makeMainViewModel()
    }()
    
    // MARK: - Initializer
    public init() {
        
    }
    
    // MARK: - Main
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: sharedMainViewModel)
    }
    
    func makeMainViewModel() -> MainViewModel {
        return MainViewModel(mainNavigator: sharedAppCoordinator)
    }
    
    func makeAppCoordinator() -> TXAppCoordinator {
        return TXAppCoordinator(mainVcFactory: makeMainViewController, launchCoordinatorFactory: makeLaunchCoordinator)
    }
    
    // MARK: - Launch
    func makeLaunchViewController() -> LaunchViewController {
        return LaunchViewController(viewModel: makeLaunchViewModel())
    }
    
    func makeLaunchViewModel() -> LaunchViewModel {
        return LaunchViewModel(notSignedInResponder: sharedMainViewModel,
                               signedInResponder: sharedMainViewModel)
    }
    
    func makeLaunchCoordinator() -> LaunchCoordinator {
        return LaunchCoordinator(rootVc: sharedAppCoordinator.rootVc, launchVcFactory: makeLaunchViewController)
    }
}
