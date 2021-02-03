//
//  OnboardingCoordinator.swift
//  Core
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common
import Onboarding

typealias OnboardingVcFactory = () -> OnboardingViewController
typealias WelcomeVcFactory = () -> WelcomeViewController

/**
 The coordinator that handles the onboarding navigation.
 It's responsable of keeping track which vc is shown, and handles all the navigation.
 */
public class OnboardingCoordinator: NSObject, Coordinator {

    // MARK: - Properties
    public var isStarted = false
    
    /// The view controller where all the other views are built upon
    private let rootVc: NiblessViewController
    
    /// The root vc for this coordinator
    private var onboardingVc: OnboardingViewController!
    
    // Factories
    private let onboardingVcFactory: OnboardingVcFactory
    private let welcomeVcFactory: WelcomeVcFactory
    
    // MARK: - Initializer
    init(rootVc: NiblessViewController,
         onboardingVcFactory: @escaping OnboardingVcFactory,
         welcomeVcFactory: @escaping WelcomeVcFactory) {
        self.rootVc = rootVc
        self.onboardingVcFactory = onboardingVcFactory
        self.welcomeVcFactory = welcomeVcFactory
    }
    
    // MARK: - Methods
    /// Starts the app coordinator flow, with attaching the onboarding view controller to the root
    public func start(completionHandler: CoordinatorStartCompletionHandler? = nil) {
        onboardingVc = onboardingVcFactory()
        onboardingVc.delegate = self
        rootVc.addFullScreen(childViewController: onboardingVc)
        navigate(to: .welcome)
        isStarted = true
    }
    
    /// Finishes the flow started if it can finish
    func finish(completionHandler: CoordinatorStartCompletionHandler? = nil) {
        rootVc.remove(childViewController: onboardingVc)
        isStarted = false
    }
    
    /// Navigates to the welcome view
    func goToWelcomeView() {
        let welcomeVc = welcomeVcFactory()
        onboardingVc.pushViewController(welcomeVc, animated: false)
    }
}

// MARK: - Onboarding navigator
extension OnboardingCoordinator: OnboardingNavigator {
    public func navigate(to onboardingView: OnboardingView) {
        switch onboardingView {
        case .welcome:
            goToWelcomeView()
        }
    }
}

// MARK: - Navigation delegate
extension OnboardingCoordinator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        guard let viewToBeShown = onboardingView(associatedWith: viewController) else { return }
        onboardingVc.viewStateWillChange(onboardingView: viewToBeShown)
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        guard let shownView = onboardingView(associatedWith: viewController) else { return }
        onboardingVc.viewStateDidChange(onboardingView: shownView)
    }
    
    /// Gets the OnboardingView out of the shown view controller
    func onboardingView(associatedWith viewController: UIViewController) -> OnboardingView? {
        switch viewController {
        case is WelcomeViewController:
            return .welcome
        default:
            assertionFailure("Encountered unexpected child view controller type in OnboardingCoordinator")
            return nil
        }
    }
}
