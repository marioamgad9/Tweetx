//
//  FollowerDetailsRootView.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common

/// The root view for FollowerDetailsViewController
class FollowerDetailsRootView: NiblessView, Loadable {
    
    // MARK: - Views
    var loaderView = LoaderView(style: .transparent, animated: true)
    let tweetsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Initializer
    init(tweetsTvConfigurator: TvDataSourceConfigurator) {
        super.init(frame: .zero)
        
        configureTableViews()
        tweetsTvConfigurator(tweetsTableView)
    }
    
    // MARK: - Methods
    override func configureViewHierarchy() {
        // Add tweets table view
        add(tweetsTableView, then: {
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
        
    }
}
