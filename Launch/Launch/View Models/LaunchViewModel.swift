//
//  LaunchViewModel.swift
//  Launch
//
//  Created by Mario Mouris on 03/02/2021.
//

import TXKit
import RxSwift
import RxCocoa

public class LaunchViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public var input: LaunchViewModel.Input
    public var output: LaunchViewModel.Output
    
    public struct Input {
        let fetchUserSession = PublishSubject<()>()
    }
    
    public struct Output {
        let errorMessage: Driver<ErrorMessage>
    }
    
    // MARK: - Properties
//    private let userSessionRepository: UserSessionRepository
    private let notSignedInResponder: NotSignedInResponder
    private let signedInResponder: SignedInResponder
    private let disposeBag = DisposeBag()
    
    // MARK: - Subjects
    private let errorMessageSubject = PublishSubject<ErrorMessage>()
    
    // MARK: - Initializer
    public init(notSignedInResponder: NotSignedInResponder,
                signedInResponder: SignedInResponder) {
//        self.userSessionRepository = userSessionRepository
        self.notSignedInResponder = notSignedInResponder
        self.signedInResponder = signedInResponder
        
        // Configure input & output
        input = Input()
        output = Output(errorMessage: errorMessageSubject.asDriver { _ in fatalError() })
        
        // Subscribe for input events
        subscribeForFetchUserSession()
    }
    
    // MARK: - Internal logic
    private func loadUserSession() {
        // TODO: - Implement auth check logic
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.notSignedInResponder.notSignedIn()
        }
    }
    
    // MARK: - Input events subscription
    private func subscribeForFetchUserSession() {
        input.fetchUserSession.subscribe(onNext: {
            self.loadUserSession()
        }).disposed(by: disposeBag)
    }
}
