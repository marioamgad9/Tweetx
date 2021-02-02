//
//  LaunchCoordinator.swift
//  Core
//
//  Created by Mario Mouris on 03/02/2021.
//

import Common
import Launch

typealias LaunchVcFactory = () -> LaunchViewController

public class LaunchCoordinator: Coordinator {
    
    // MARK: - Properties
    /// The view controller where all the other views are built upon
    private let rootVc: NiblessViewController
    
    /// The launch vc, which is the only vc for this coordinator
    private var launchVc: LaunchViewController!
    
    // Factories
    private let launchVcFactory: LaunchVcFactory
    
    // MARK: - Methods
    init(rootVc: NiblessViewController, launchVcFactory: @escaping LaunchVcFactory) {
        self.rootVc = rootVc
        self.launchVcFactory = launchVcFactory
    }
    
    /// Starts the flow by adding the launch view controller to the root vc full screened
    func start(completionHandler: CoordinatorStartCompletionHandler? = nil) {
        launchVc = launchVcFactory()
        rootVc.addFullScreen(childViewController: launchVc)
    }
    
    /// Finishes the flow by removing the launch vc from the root vc
    func finish(completionHandler: CoordinatorStartCompletionHandler? = nil) {
        rootVc.remove(childViewController: launchVc)
    }
}
