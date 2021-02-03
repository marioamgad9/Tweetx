//
//  FollowerDetailsNavigationBar.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common
import SDWebImage

class FollowerDetailsNavigationBar: NiblessView {
    
    // MARK: - Views
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        return imageView
    }()
    
    private let backgroundColorOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = Color.black.value
        view.alpha = 0.6
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bold(size: .big, scalable: true)
        label.textColor = Color.white.value
        label.numberOfLines = 0
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic-back"), for: .normal)
        button.tintColor = Color.white.value
        button.backgroundColor = Color.darkestGrey.withAlpha(0.5)
        button.layer.cornerRadius = 20
        button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 11, bottom: 12, right: 13)
        return button
    }()
    
    // MARK: - Methods
    func configure(with viewModel: FollowerDetailsHeaderViewModel) {
        backgroundImageView.sd_setImage(with: viewModel.backgroundImageURL,
                                        placeholderImage: UIImage(named: "background-placeholdepr")) { (image, _, _, _) in
            self.backgroundImageView.image = image?.sd_blurredImage(withRadius: 5)
        }
        
        nameLabel.text = viewModel.name
    }
    
    override func configureViewHierarchy() {
        // Add back button
        add(backButton, then: {
            $0.anchor(.leading(safeAreaLayoutGuide.leadingAnchor, constant: 16),
                      .top(safeAreaLayoutGuide.topAnchor, constant: 8),
                      .bottom(bottomAnchor, constant: 16))
            $0.constrainHeight(40)
            $0.constrainWidth($0.heightAnchor)
        })
        
        // Add name label
        add(nameLabel, then: {
            $0.anchor(.leadingGreaterThanOrEqualTo(backButton.trailingAnchor, constant: 16),
                      .trailingLessThanOrEqualTo(trailingAnchor, constant: -16))
            $0.centerYTo(backButton.centerYAnchor)
            $0.centerXTo(centerXAnchor)
        })
        
        // Add background image view & overlay
        add(backgroundImageView, then: {
            $0.anchor(.leading(leadingAnchor),
                      .top(topAnchor),
                      .trailing(trailingAnchor),
                      .bottom(backButton.bottomAnchor, constant: 8))
        })
        
        add(backgroundColorOverlay, then: {
            $0.anchor(.leading(backgroundImageView.leadingAnchor),
                      .top(backgroundImageView.topAnchor),
                      .trailing(backgroundImageView.trailingAnchor),
                      .bottom(backgroundImageView.bottomAnchor))
        })
        
        sendSubviewToBack(backgroundColorOverlay)
        sendSubviewToBack(backgroundImageView)
    }
    
    override func viewHierarchyDidConfigure() {
        backgroundColor = Color.offWhite.value
    }
    
    public func setNavigationBarHidden(_ isHidden: Bool, animated: Bool) {
        guard animated else {
            alpha = isHidden ? 0 : 1
            transform = isHidden ? CGAffineTransform(translationX: 0, y: -100) :
                CGAffineTransform(translationX: 0, y: 0)
            return
        }

        UIView.animate(withDuration: 0.3) {
            self.alpha = isHidden ? 0 : 1
            self.transform = isHidden ? CGAffineTransform(translationX: 0, y: -100) :
                CGAffineTransform(translationX: 0, y: 0)
        }
    }
}
