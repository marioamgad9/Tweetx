//
//  FollowersListRootView.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common

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
    
    // MARK: - Initializer
    init(followersTvConfigurator: TvDataSourceConfigurator) {
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
    }
}
