//
//  OnboardingDependencyContainer.swift
//  Core
//
//  Created by Mario Mouris on 03/02/2021.
//

import Main
import Onboarding

/// The dependency container that holds the dependency graph for the onboarding flow
public class OnboardingDependencyContainer {
    
    // MARK: - Properties from parent container
    let sharedMainViewModel: MainViewModel
    
    // MARK: - Long lived dependencies
    /// The shared coordinator for the onboarding flow
    weak var sharedOnboardingCoordinator: OnboardingCoordinator!
    
    // MARK: - Initializer
    init(appDependencyContainer: TXAppDependencyContainer) {
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
    }
    
    // MARK: - Methods
    func makeOnboardingViewController() -> OnboardingViewController {
        return OnboardingViewController()
    }
    
    // Welcome
    func makeWelcomeViewController() -> WelcomeViewController {
        return WelcomeViewController(viewModel: makeWelcomeViewModel())
    }
    
    func makeWelcomeViewModel() -> WelcomeViewModel {
        return WelcomeViewModel(onboardingNavigator: sharedOnboardingCoordinator,
                                signedInResponder: sharedMainViewModel)
    }
}
