//
//  FollowerDetailsViewModel.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import TXKit
import RxSwift
import RxCocoa

public class FollowerDetailsViewModel: ViewModelType {
    
    // MARK: - Input & Output
    public var input: FollowerDetailsViewModel.Input
    public var output: FollowerDetailsViewModel.Output
    
    public struct Input {
        let fetchFollowerTweets = PublishSubject<()>()
    }
    
    public struct Output {
        let follower: Driver<TwitterUser>
        let tweets: Driver<[Tweet]>
        let isLoading: Driver<Bool>
        let errorMessage: Driver<ErrorMessage>
    }
    
    // MARK: - Subjects
    private let tweetsSubject = BehaviorSubject<[Tweet]>(value: [])
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)
    private let errorMessageSubject = PublishSubject<ErrorMessage>()
    
    // MARK: - Properties
    private let follower: TwitterUser
    private let followersRemoteAPI: FollowersRemoteAPI
    private let followersNavigator: FollowersNavigator
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(follower: TwitterUser, followersRemoteAPI: FollowersRemoteAPI, followersNavigator: FollowersNavigator) {
        self.follower = follower
        self.followersRemoteAPI = followersRemoteAPI
        self.followersNavigator = followersNavigator
        
        // Configure input & output
        input = Input()
        output = Output(follower: BehaviorSubject(value: follower).asDriver { _ in fatalError() },
                        tweets: tweetsSubject.asDriver(onErrorJustReturn: []),
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        errorMessage: errorMessageSubject.asDriver { _ in fatalError() })
        
        // Subscribe to input events
        subscribeForFetchFollowerTweets()
    }
    
    // MARK: - Internal logic
    private func loadFollowerTweets() {
        isLoadingSubject.onNext(true)
        followersRemoteAPI.getTweetsForFollower(followerId: follower.id).done {
            self.tweetsSubject.onNext($0)
        }
        .catch(handleError)
        .finally {
            self.isLoadingSubject.onNext(false)
        }
    }
    
    // MARK: - Input events subscription
    private func subscribeForFetchFollowerTweets() {
        input.fetchFollowerTweets.subscribe(onNext: {
            self.loadFollowerTweets()
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Error handling
    private func handleError(_ error: Error) {
        errorMessageSubject.onNext(ErrorMessage(title: "error_title.unexpected_error".localized,
                                                message: "error_message.unexpected_error".localized))
    }
}
