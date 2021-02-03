//
//  FollowerDetailsViewController.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common
import RxSwift
import RxCocoa

/// Handles showing details of a follower account and his/her tweets
public class FollowerDetailsViewController: NiblessViewController {
    
    // MARK: - Root view
    private var rootView: FollowerDetailsRootView!
    
    // MARK: - Properties
    private let viewModel: FollowerDetailsViewModel
    public override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(viewModel: FollowerDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Methods
    public override func loadView() {
        rootView = FollowerDetailsRootView(tweetsTvConfigurator: configureTweetsTableView(tableView:))
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.input.fetchFollowerTweets.onNext(())
        
        // Subscribe to view model events
        subscribeToFollower()
        subscribeToIsLoading()
        subscribeToErrorMessages()
        
        // Bind input events to view model
    }
    
    private func configureTweetsTableView(tableView: UITableView) {
//        viewModel.output.tweets.drive(tableView.rx.items(cellIdentifier: TweetTableViewCell.reuseIdentifier,
//                                                        cellType: TweetTableViewCell.self)) { (_, tweet, cell) in
//            cell.configure(with: user)
//        }.disposed(by: disposeBag)
    }
    
    private func subscribeToFollower() {
        viewModel.output.follower.drive(onNext: {
            self.title = $0.name
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