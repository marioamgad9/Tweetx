//
//  WelcomeViewController.swift
//  Onboarding
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common
import RxSwift

public class WelcomeViewController: NiblessViewController {
    
    // MARK: - Root view
    private var rootView: WelcomeRootView!
    
    // MARK: - Properties
    private let viewModel: WelcomeViewModel
    public override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    public init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Methods
    public override func loadView() {
        rootView = WelcomeRootView()
        view = rootView
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        rootView.animateEntrance()
    }
}

