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
    
    public struct Input {
        let signInButtonTapped = PublishSubject<()>()
    }
    
    public struct Output {}
    
    // MARK: - Properties
    private var onboardingNavigator: OnboardingNavigator
    private let signedInResponder: SignedInResponder
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(onboardingNavigator: OnboardingNavigator,
                signedInResponder: SignedInResponder) {
        self.onboardingNavigator = onboardingNavigator
        self.signedInResponder = signedInResponder
        
        // Configure input & output
        input = Input()
        output = Output()
        
        // Subscribe to input events
        subscribeForSignInButtonTapped()
    }
    
    // MARK: - Input events subscription
    private func subscribeForSignInButtonTapped() {
        input.signInButtonTapped.subscribe(onNext: {
            // TODO: - Implement actual sign in logic first
            self.signedInResponder.signedIn(with: AuthTokens.dummyValue())
        }).disposed(by: disposeBag)
    }
}
