//
//  MainViewModel.swift
//  Main
//
//  Created by Mario Mouris on 02/02/2021.
//

import Foundation
import TXKit


/// The view model for MainViewController
public class MainViewModel: SignedInResponder, NotSignedInResponder {
    
    // MARK: - Properties
    /// Handles all navigation for this view
    private let mainNavigator: MainNavigator
    
    // MARK: - Initializer
    public init(mainNavigator: MainNavigator) {
        self.mainNavigator = mainNavigator
    }
    
    public func signedIn(with tokens: AuthTokens) {
        mainNavigator.navigate(to: .followers)
    }
    
    public func notSignedIn() {
        mainNavigator.navigate(to: .onboarding)
    }
}
