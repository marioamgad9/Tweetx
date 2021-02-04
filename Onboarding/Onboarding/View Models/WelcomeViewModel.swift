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
        let signInButtonTapped = PublishSubject<UIViewController>()
    }
    
    public struct Output {
        let isLoading: Driver<Bool>
        let errorMessage: Driver<ErrorMessage>
    }
    
    // MARK: - Properties
    private let userSessionRepository: UserSessionRepository
    private let onboardingNavigator: OnboardingNavigator
    private let signedInResponder: SignedInResponder
    private let disposeBag = DisposeBag()
    
    // MARK: - Subjects
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)
    private let errorMessageSubject = PublishSubject<ErrorMessage>()
    
    // MARK: - Initializer
    public init(userSessionRepository: UserSessionRepository,
                onboardingNavigator: OnboardingNavigator,
                signedInResponder: SignedInResponder) {
        self.userSessionRepository = userSessionRepository
        self.onboardingNavigator = onboardingNavigator
        self.signedInResponder = signedInResponder
        
        // Configure input & output
        input = Input()
        output = Output(isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        errorMessage: errorMessageSubject.asDriver { _ in fatalError() })
        
        // Subscribe to input events
        subscribeForSignInButtonTapped()
    }
    
    // MARK: - Internal logic
    private func signIn(viewController: UIViewController) {
        userSessionRepository.signInWithTwitter(viewController: viewController).done { (userID) in
            self.signedInResponder.signedIn(with: userID)
        }
        .catch(handleError)
    }
    
    // MARK: - Input events subscription
    private func subscribeForSignInButtonTapped() {
        input.signInButtonTapped.subscribe(onNext: {
            self.signIn(viewController: $0)
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Error handling
    private func handleError(_ error: Error) {
        errorMessageSubject.onNext(ErrorMessage(title: "error_title.unexpected_error".localized,
                                                message: "error_message.unexpected_error".localized))
    }
}
