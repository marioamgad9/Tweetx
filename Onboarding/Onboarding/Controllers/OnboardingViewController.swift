//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common

/// The view controller that handles the not signed in state
public class OnboardingViewController: TXNavigationController {
    
    // MARK: - Properties
    public override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Methods
    func hideOrShowNavigationBarIfNeeded(for view: OnboardingView, animated: Bool) {
        setNavigationBarHidden(view.hidesNavigationBar(), animated: animated)
    }
}

// MARK: - View state responder
extension OnboardingViewController: OnboardingStateResponder {
    public func viewStateWillChange(onboardingView: OnboardingView) {
        hideOrShowNavigationBarIfNeeded(for: onboardingView, animated: true)
    }
    
    public func viewStateDidChange(onboardingView: OnboardingView) { }
}
