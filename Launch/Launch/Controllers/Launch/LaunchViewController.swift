//
//  LaunchViewController.swift
//  Launch
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common
import TXKit
import PromiseKit

public class LaunchViewController: NiblessViewController {
    
    // MARK: - Root view
    private var rootView: LaunchRootView!
    
    // MARK: - Properties
    private let viewModel: LaunchViewModel
    public override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Initializer
    public init(viewModel: LaunchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Methods
    public override func loadView() {
        rootView = LaunchRootView()
        view = rootView
    }

    public override func viewDidLoad() {
        viewModel.input.fetchUserSession.onNext(())
    }
}

