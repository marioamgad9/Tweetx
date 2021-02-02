//
//  MainViewController.swift
//  Main
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common

/// The parent view controller that handles state across the entire app
public class MainViewController: NiblessViewController {
    
    // MARK: - Properties
    private let viewModel: MainViewModel
    public override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: - Initializer
    public init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}
