//
//  AppDelegate.swift
//  Tweetx
//
//  Created by Mario Mouris on 02/02/2021.
//

import UIKit
import Common
import Core

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    private let dependencyContainer = TXAppDependencyContainer()
    private var coordinator: TXAppCoordinator?
    var window: UIWindow?
    
    // MARK: - Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setup coordinator
        coordinator = dependencyContainer.sharedAppCoordinator
        
        // Setup window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = coordinator?.rootVc
        
        // Start coordinator
        coordinator?.start()
        
        return true
    }
}

