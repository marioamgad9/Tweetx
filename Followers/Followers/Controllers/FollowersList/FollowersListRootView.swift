//
//  FollowersListRootView.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common

protocol FollowersListRootViewResponder {
    func refreshFollowersList()
    func tableViewDidReachEnd()
}

/// The root view for FollowersListViewController
class FollowersListRootView: NiblessView, Loadable {
    
    // MARK: - Views
    var loaderView = LoaderView(style: .transparent, animated: true)
    let followersTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Properties
    private let responder: FollowersListRootViewResponder
    
    // MARK: - Initializer
    init(followersTvConfigurator: TvDataSourceConfigurator,
         responder: FollowersListRootViewResponder) {
        self.responder = responder
        super.init(frame: .zero)
        
        configureTableViews()
        followersTvConfigurator(followersTableView)
    }
    
    // MARK: - Methods
    override func configureViewHierarchy() {
        // Add followers table view
        add(followersTableView, then: {
            $0.fillSuperview(padding: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0))
        })
        
        // Bring loader to front
        bringSubviewToFront(loaderView)
    }
    
    override func viewHierarchyDidConfigure() {
        // Set background color
        backgroundColor = Color.offWhite.value
    }
    
    private func configureTableViews() {
        followersTableView.registerCellFromClass(FollowerTableViewCell.self)
        followersTableView.delegate = self
        followersTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlActivated), for: .valueChanged)
    }
    
    
    @objc private func refreshControlActivated() {
        responder.refreshFollowersList()
        refreshControl.endRefreshing()
    }
}

// MARK: - Table view delegate
extension FollowersListRootView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Notify responder that table did reach end
        if scrollView.didReachEnd(offset: 200) {
            responder.tableViewDidReachEnd()
        }
    }
}
