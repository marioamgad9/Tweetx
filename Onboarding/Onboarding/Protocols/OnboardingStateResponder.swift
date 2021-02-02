//
//  OnboardingStateResponder.swift
//  Onboarding
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation

/// Handles state change notifications
public protocol OnboardingStateResponder {
    func viewStateWillChange(onboardingView: OnboardingView)
    func viewStateDidChange(onboardingView: OnboardingView)
}

