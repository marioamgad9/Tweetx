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
        let refreshFollowers = PublishSubject<()>()
        let followerSelected = PublishSubject<FollowerCellViewModel>()
        let signOut = PublishSubject<()>()
    }
    
    public struct Output {
        let followers: Driver<[FollowerCellViewModel]>
        let isLoading: Driver<Bool>
        let errorMessage: Driver<ErrorMessage>
    }
    
    // MARK: - Subjects
    private let followersSubject = BehaviorSubject<[TwitterUser]>(value: [])
    private let followersNextCursorSubject = BehaviorSubject<String?>(value: nil)
    private let isLoadingSubject = BehaviorSubject<Bool>(value: false)
    private let errorMessageSubject = PublishSubject<ErrorMessage>()
    
    // MARK: - Properties
    private let followersRemoteAPI: FollowersRemoteAPI
    private let followersNavigator: FollowersNavigator
    private let userSessionRepository: UserSessionRepository
    private let notSignedInResponder: NotSignedInResponder
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(userSessionRepository: UserSessionRepository, notSignedInResponder: NotSignedInResponder,
                followersRemoteAPI: FollowersRemoteAPI, followersNavigator: FollowersNavigator) {
        self.userSessionRepository = userSessionRepository
        self.notSignedInResponder = notSignedInResponder
        self.followersRemoteAPI = followersRemoteAPI
        self.followersNavigator = followersNavigator
        
        
        // Configure input & output
        input = Input()
        output = Output(followers: followersSubject.map { $0.map { FollowerCellViewModel(follower: $0) } }.asDriver(onErrorJustReturn: []),
                        isLoading: isLoadingSubject.asDriver(onErrorJustReturn: false),
                        errorMessage: errorMessageSubject.asDriver { _ in fatalError() })
        
        // Subscribe to input events
        subscribeForFetchFollowers()
        subscribeForRefreshFollowers()
        subscribeForFollowerSelected()
        subscribeForSignOut()
    }
    
    // MARK: - Internal logic
    private func loadFollowers(nextCursor: String?) {
        isLoadingSubject.onNext(true)
        followersRemoteAPI.getFollowers(cursor: nextCursor).done {
            self.followersSubject.onNext(getFollowersValue() + $0.0)
            self.followersNextCursorSubject.onNext($0.1)
        }
        .catch(handleError)
        .finally {
            self.isLoadingSubject.onNext(false)
        }
        
        func getFollowersValue() -> [TwitterUser] {
            if let value = try? followersSubject.value() { return value }
            else { return [] }
        }
    }
    
    private func refreshFollowers() {
        followersSubject.onNext([])
        followersNextCursorSubject.onNext(nil)
        loadFollowers(nextCursor: nil)
    }
    
    private func signOut() {
        userSessionRepository.signOut().done {
            self.notSignedInResponder.notSignedIn()
        }.catch(handleError)
    }
    
    // MARK: - Input events subscription
    private func subscribeForFetchFollowers() {
        input.fetchFollowers
            .withLatestFrom(Observable.combineLatest(followersNextCursorSubject,
                                                     isLoadingSubject,
                                                     followersSubject))
            .filter { (_, isLoading, _) in !isLoading }
            .filter { (nextCursor, _, followers) in  followers.count == 0 || nextCursor != nil}
            .subscribe(onNext: { (nextCursor, _, _) in
            self.loadFollowers(nextCursor: nextCursor)
        }).disposed(by: disposeBag)
    }
    
    private func subscribeForRefreshFollowers() {
        input.refreshFollowers.subscribe(onNext: {
            self.refreshFollowers()
        }).disposed(by: disposeBag)
    }
    
    private func subscribeForFollowerSelected() {
        input.followerSelected.subscribe(onNext: {
            self.followersNavigator.navigate(to: .followerDetails(follower: $0.follower))
        }).disposed(by: disposeBag)
    }
    
    private func subscribeForSignOut() {
        input.signOut.subscribe(onNext: {
            self.signOut()
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Error handling
    private func handleError(_ error: Error) {
        errorMessageSubject.onNext(ErrorMessage(title: "error_title.unexpected_error".localized,
                                                message: "error_message.unexpected_error".localized,
                                                callToActionLabel: "error_cta.try_again".localized,
                                                callToActionResponse: { self.refreshFollowers() }))
    }
}
