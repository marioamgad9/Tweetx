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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "btn.signout".localized, style: .plain,
                                                            target: self, action: #selector(signOutButtonTapped))
    }
    
    // MARK: - Methods
    public override func loadView() {
        rootView = FollowersListRootView(followersTvConfigurator: configureFollowersTableView(tableView:),
                                         responder: self)
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.input.fetchFollowers.onNext(())
        
        // Subscribe to view model events
        subscribeToIsLoading()
        subscribeToErrorMessages()
        
        // Bind input events to view model
    }
    
    @objc private func signOutButtonTapped() {
        viewModel.input.signOut.onNext(())
    }
    
    private func configureFollowersTableView(tableView: UITableView) {
        viewModel.output.followers.drive(tableView.rx.items(cellIdentifier: FollowerTableViewCell.reuseIdentifier,
                                                        cellType: FollowerTableViewCell.self)) { (_, user, cell) in
            cell.configure(with: user)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(FollowerCellViewModel.self).subscribe(onNext: {
            self.viewModel.input.followerSelected.onNext($0)
        }).disposed(by: disposeBag)
    }
    
    private func subscribeToIsLoading() {
        Driver.combineLatest(viewModel.output.isLoading,
                             viewModel.output.followers)
            .filter { $1.count == 0 || !$0 }
            .drive(onNext: { (loading, _) in
                loading ? self.rootView.showLoaderView() : self.rootView.hideLoaderView()
            }).disposed(by: disposeBag)
    }
    
    private func subscribeToErrorMessages() {
        viewModel.output.errorMessage
            .drive(onNext: { self.present(errorMessage: $0)})
            .disposed(by: disposeBag)
    }
}

// MARK: - Root view responder
extension FollowersListViewController: FollowersListRootViewResponder {
    func refreshFollowersList() {
        viewModel.input.refreshFollowers.onNext(())
    }
    
    func tableViewDidReachEnd() {
        viewModel.input.fetchFollowers.onNext(())
    }
}
