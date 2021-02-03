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
    let navigationBar = FollowerDetailsNavigationBar()
    let header = FollowerDetailsHeader()
    let tweetsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
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
        
        // Add navigation bar
        add(navigationBar, then: {
            $0.anchor(.leading(leadingAnchor),
                      .top(topAnchor),
                      .trailing(trailingAnchor))
            $0.setNavigationBarHidden(true, animated: false)
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
        tweetsTableView.registerCellFromClass(TweetTableViewCell.self)
    }
    
    override func safeAreaInsetsDidChange() {
        tweetsTableView.contentInset = UIEdgeInsets(top: -safeAreaInsets.top,
                                                    left: 0,
                                                    bottom: 0,
                                                    right: 0)
    }
}

// MARK: - Table view delegate
extension FollowerDetailsRootView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard header.profilePictureImageView.frame != .zero else {
            return
        }
        
        let profilePictureIsPartiallyVisible = scrollView.bounds.intersects(header.profilePictureImageView.frame)
        navigationBar.setNavigationBarHidden(profilePictureIsPartiallyVisible, animated: true)
    }
}
