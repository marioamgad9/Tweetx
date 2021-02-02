//
//  LaunchRootView.swift
//  Launch
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common

/// The root view for LaunchViewController
public class LaunchRootView: NiblessView {
    
    // MARK: - Views
    private let backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.primary.value
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.color = Color.white.value
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // MARK: - Methods
    public override func configureViewHierarchy() {
        // Add background
        add(backgroundColorView, then: {
            $0.fillSuperview()
        })
        
        // Add logo
        add(logoImageView, then: {
            $0.centerXToSuperview()
            $0.centerYToSuperview(constant: -32)
            $0.constrainWidth(300)
            $0.constrainHeight(79)
            $0.anchor(.leading(self.leadingAnchor, constant: 32, priority: .defaultHigh),
                      .trailing(self.trailingAnchor, constant: -32, priority: .defaultHigh))
        })
        
        // Add activity indicator
        add(activityIndicator, then: {
            $0.centerXToSuperview()
            $0.anchor(.top(self.logoImageView.bottomAnchor, constant: 16))
        })
    }
}

// MARK: - Animations
extension LaunchRootView {
    public func animateExit(completionHandler: ((Bool) -> Void)? = nil) {
        activityIndicator.alpha = 0
        UIView.animate(withDuration: 2, delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                        self.backgroundColorView.alpha = 0
                        self.logoImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        self.logoImageView.alpha = 0
                        self.alpha = 0
        }, completion: completionHandler)
    }
}

