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
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Color.white.value
        return imageView
    }()
    
    private let illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "illustration-welcome")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let sloganLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.white.value
        label.font = UIFont.medium(size: .normal)
        label.text = "label.slogan".localized
        label.textAlignment = .center
        label.numberOfLines = 0
        label.addCharacterSpacing(kernValue: 2)
        return label
    }()
    
    let signInButton: PrimaryButton = {
        let button = PrimaryButton(color: Color.white.value, textColor: Color.primary.value)
        button.setTitle("btn.sign_in".localized, for: .normal)
        return button
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
        
        // Add logo
        add(logoImageView, then: {
            $0.anchor(.top(safeAreaLayoutGuide.topAnchor, constant: 32))
            $0.constrainWidthLessThanOrEqual(220)
            $0.constrainHeight($0.widthAnchor, multiplier: 79/300)
            $0.centerXTo(safeAreaLayoutGuide.centerXAnchor)
        })
        
        // Add sign in button
        add(signInButton, then: {
            $0.anchor(.bottom(safeAreaLayoutGuide.bottomAnchor, constant: -32),
                      .leading(safeAreaLayoutGuide.leadingAnchor, constant: 32),
                      .trailing(safeAreaLayoutGuide.trailingAnchor, constant: -32),
                      .heightConstant(50))
        })
        
        // Configure welcome stackview
        let welcomeStackView = UIStackView(arrangedSubviews: [illustrationImageView, sloganLabel])
        welcomeStackView.axis = .vertical
        welcomeStackView.distribution = .fill
        welcomeStackView.alignment = .center
        
        welcomeStackView.add(illustrationImageView, then: {
            $0.centerXToSuperview()
            $0.constrainWidth($0.heightAnchor)
            $0.constrainHeightLessThanOrEqual(200)
            $0.isHidden = traitCollection.verticalSizeClass == .compact
            $0.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        })
        welcomeStackView.add(sloganLabel, then: {
            $0.anchor(.leading(welcomeStackView.leadingAnchor),
                      .trailing(welcomeStackView.trailingAnchor))
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        })
        
        add(welcomeStackView, then: {
            $0.anchor(.leading(safeAreaLayoutGuide.leadingAnchor, constant: 32),
                      .topGreaterThanOrEqualTo(logoImageView.bottomAnchor, constant: 16),
                      .trailing(safeAreaLayoutGuide.trailingAnchor, constant: -32),
                      .bottomLessThanOrEqualTo(signInButton.topAnchor, constant: -32))
            $0.centerYToSuperview(constant: -32)
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
