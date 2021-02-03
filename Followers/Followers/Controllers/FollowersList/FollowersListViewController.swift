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
    }
    
    // MARK: - Methods
    public override func loadView() {
        rootView = FollowersListRootView()
        view = rootView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - Remove this
        rootView.showLoaderView()
        
        // Subscribe to view model events
        
        
        // Bind input events to view model
    }
}
