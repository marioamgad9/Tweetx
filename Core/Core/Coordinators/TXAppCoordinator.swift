//
//  TXAppCoordinator.swift
//  Core
//
//  Created by Mario Mouris on 03/02/2021.
//

import Common
import Main

typealias MainVcFactory = () -> MainViewController
typealias LaunchCoordinatorFactory = () -> LaunchCoordinator

/**
 Handles coordination between the main app states (LaunchView, OnboardingView, etc...)
 It handles child coordinators for each subsystem if needed.
 */
public class TXAppCoordinator: Coordinator {
    
    // MARK: - Properties
    /// The view controller where all the other views are built upon
    public private(set) lazy var rootVc: MainViewController = mainVcFactory()
    
    // Child coordinators
    public private(set) var launchCoordinator: LaunchCoordinator!
    
    // MARK: - Factories
    private let mainVcFactory: MainVcFactory
    private let launchCoordinatorFactory: LaunchCoordinatorFactory
    
    // MARK: - Initializer
    init(mainVcFactory: @escaping MainVcFactory,
         launchCoordinatorFactory: @escaping LaunchCoordinatorFactory) {
        self.mainVcFactory = mainVcFactory
        self.launchCoordinatorFactory = launchCoordinatorFactory
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
        launchCoordinator = launchCoordinatorFactory()
        launchCoordinator.start()
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
