//
//  OnboardingView.swift
//  Onboarding
//
//  Created by Mario Mouris on 03/02/2021.
//

import Foundation

/// The various states an Onboarding view can be in.
/// It also shows which views should hide the navigation bar.
public enum OnboardingView {
    case welcome
    
    public func hidesNavigationBar() -> Bool {
        switch self {
        case .welcome:
            return true
        }
    }
}

