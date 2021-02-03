//
//  FollowersListViewController.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common
import RxSwift
import RxCocoa

/// Handles showing the list of user followers
public class FollowersListViewController: NiblessViewController {
    
    // MARK: - Root view
    private var rootView: FollowersListRootView!
    
    // MARK: - Properties
    private let viewModel: FollowersListViewModel
    public override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(viewModel: FollowersListViewModel) {
        self.viewModel = viewModel
        super.init()
        
        title = "title.followers_list".localized
    }
    
    // MARK: - Methods
    public override func loadView() {
        rootView = FollowersListRootView()
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.input.fetchFollowers.onNext(())
        
        // Subscribe to view model events
        subscribeToFollowers()
        subscribeToIsLoading()
        subscribeToErrorMessages()
        
        // Bind input events to view model
    }
    
    private func subscribeToFollowers() {
        viewModel.output.followers.drive(onNext: {
            print("REMOVETHISLOG - Followers received: \($0)")
        }).disposed(by: disposeBag)
    }
    
    private func subscribeToIsLoading() {
        viewModel.output.isLoading.drive(onNext: {
            $0 ? self.rootView.showLoaderView() : self.rootView.hideLoaderView()
        }).disposed(by: disposeBag)
    }
    
    private func subscribeToErrorMessages() {
        // TODO: - Implement error message presenting
    }
}
