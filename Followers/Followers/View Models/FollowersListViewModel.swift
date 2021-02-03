//
//  FollowersListViewModel.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import TXKit
import RxSwift
import RxCocoa

public class FollowersListViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public var input: FollowersListViewModel.Input
    public var output: FollowersListViewModel.Output
    
    public struct Input {
        let fetchFollowers = PublishSubject<()>()
    }
    
    public struct Output {
        let followers: Driver<[TwitterUser]>
        let isLoading: Driver<Bool>
        let errorMessage: Driver<ErrorMessage>
    }
    
    // MARK: - Subjects
    private let followersSubject = BehaviorSubject<[TwitterUser]>(value: [])
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)
    private let errorMessageSubject = PublishSubject<ErrorMessage>()
    
    // MARK: - Properties
    private var followersRemoteAPI: FollowersRemoteAPI
    private var followersNavigator: FollowersNavigator
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(followersRemoteAPI: FollowersRemoteAPI, followersNavigator: FollowersNavigator) {
        self.followersRemoteAPI = followersRemoteAPI
        self.followersNavigator = followersNavigator
        
        // Configure input & output
        input = Input()
        output = Output(followers: followersSubject.asDriver(onErrorJustReturn: []),
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        errorMessage: errorMessageSubject.asDriver { _ in fatalError() })
        
        // Subscribe to input events
        subscribeForFetchFollowers()
    }
    
    // MARK: - Internal logic
    private func loadFollowers() {
        isLoadingSubject.onNext(true)
        followersRemoteAPI.getFollowers().done {
            self.followersSubject.onNext($0)
        }
        .catch(handleError)
        .finally {
            self.isLoadingSubject.onNext(false)
        }
    }
    
    // MARK: - Input events subscription
    private func subscribeForFetchFollowers() {
        input.fetchFollowers.subscribe(onNext: {
            self.loadFollowers()
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Error handling
    private func handleError(_ error: Error) {
        errorMessageSubject.onNext(ErrorMessage(title: "error_title.unexpected_error".localized,
                                                message: "error_message.unexpected_error".localized))
    }
}

