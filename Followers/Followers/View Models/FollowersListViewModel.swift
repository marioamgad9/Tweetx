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
    
    public struct Input {}
    
    public struct Output {}
    
    // MARK: - Properties
    private var followersNavigator: FollowersNavigator
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(followersNavigator: FollowersNavigator) {
        self.followersNavigator = followersNavigator
        
        // Configure input & output
        input = Input()
        output = Output()
        
        // Subscribe to input events
    }
    
    // MARK: - Input events subscription
}

