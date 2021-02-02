//
//  WelcomeViewModel.swift
//  Onboarding
//
//  Created by Mario Mouris on 03/02/2021.
//

import TXKit
import RxSwift
import RxCocoa

public class WelcomeViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public var input: WelcomeViewModel.Input
    public var output: WelcomeViewModel.Output
    
    public struct Input {}
    
    public struct Output {}
    
    // MARK: - Properties
    private var onboardingNavigator: OnboardingNavigator
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(onboardingNavigator: OnboardingNavigator) {
        self.onboardingNavigator = onboardingNavigator
        
        // Configure input & output
        input = Input()
        output = Output()
        
        // Subscribe to input events
    }
    
    // MARK: - Input events subscription
}
