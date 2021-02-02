//
//  MainNavigator.swift
//  Main
//
//  Created by Mario Mouris on 02/02/2021.
//

import Foundation

/// Defines how the navigation should work
public protocol MainNavigator {
    /// Navigates to the appropriate view
    func navigate(to mainView: MainView)
}
