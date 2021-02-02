//
//  TXAppCoordinator.swift
//  Core
//
//  Created by Mario Mouris on 03/02/2021.
//

import Common
import Main

typealias MainVcFactory = () -> MainViewController

/**
 Handles coordination between the main app states (LaunchView, OnboardingView, etc...)
 It handles child coordinators for each subsystem if needed.
 */
public class TXAppCoordinator: Coordinator {
    
    // MARK: - Properties
    /// The view controller where all the other views are built upon
    public private(set) lazy var rootVc: MainViewController = mainVcFactory()
    
    // Child coordinators
    
    // MARK: - Factories
    private let mainVcFactory: MainVcFactory
    
    // MARK: - Initializer
    init(mainVcFactory: @escaping MainVcFactory) {
        self.mainVcFactory = mainVcFactory
    }
    
    // MARK: - Methods
    /// Starts the app coordinator flow, with attaching the main view controller to the root
    public func start(completionHandler: CoordinatorStartCompletionHandler? = nil) {
        navigate(to: .launching)
    }
    
    /// Finishes the flow started if it can finish
    func finish(completionHandler: CoordinatorStartCompletionHandler? = nil) {}

    /// Navigates to the launch view
    func goToLaunchView() {
    }
    
    /// Navigates to the welcome view
    func goToOnboardingView() {
    }
    
    /// Navigates to the signedin view
    func goToSignedInView() {
    }
}

// MARK: - Main navigator
extension TXAppCoordinator: MainNavigator {
    public func navigate(to mainView: MainView) {
        switch mainView {
        case .launching:
            goToLaunchView()
        case .onboarding:
            goToOnboardingView()
        case .signedIn:
            goToSignedInView()
        }
    }
}
