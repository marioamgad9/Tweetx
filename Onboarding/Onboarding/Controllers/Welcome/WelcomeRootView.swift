//
//  WelcomeRootView.swift
//  Onboarding
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common
import Launch

/// The root view for WelcomeViewController
class WelcomeRootView: NiblessView {
    
    // MARK: - Views
    private let launchView = LaunchRootView()
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "welcome-background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        // Set pre entrance state
        setStateToPreEntrance()
    }
    
    // MARK: - Methods
    override func configureViewHierarchy() {
        // Add background image & shade view
        add(backgroundImageView, then: {
            $0.fillSuperview()
        })
        
        // Add launch view
        add(launchView, then: {
            $0.fillSuperview()
        })
    }
}

// MARK: - Animations
extension WelcomeRootView {
    private func setStateToPreEntrance() {
        backgroundImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    func animateEntrance() {
        // Animate exit of launch view
        launchView.animateExit() { _ in
            self.launchView.removeFromSuperview()
        }
        
        // Animate view scale
        UIView.animate(withDuration: 2, delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                        self.backgroundImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
}

