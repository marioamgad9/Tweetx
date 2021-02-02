//
//  OnboardingNavigator.swift
//  Onboarding
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation

/// Defines how the navigation should work
public protocol OnboardingNavigator {
    /// Navigates to the appropriate view
    func navigate(to onboardingView: OnboardingView)
}
