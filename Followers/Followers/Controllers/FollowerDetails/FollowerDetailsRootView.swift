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
    let header = FollowerDetailsHeader()
    let tweetsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.insetsContentViewsToSafeArea = false
        tableView.contentInsetAdjustmentBehavior = .never
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
            $0.fillSuperview()
        })
        
        // Bring loader to front
        bringSubviewToFront(loaderView)
    }
    
    override func viewHierarchyDidConfigure() {
        // Set background color
        backgroundColor = Color.offWhite.value
    }
    
    private func configureTableViews() {
        tweetsTableView.delegate = self
    }
}

// MARK: - Table view delegate
extension FollowerDetailsRootView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
