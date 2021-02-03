//
//  FollowerDetailsHeader.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common
import SDWebImage

class FollowerDetailsHeader: NiblessView {
    
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
        view.alpha = 0.5
        return view
    }()
    
    let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.layer.cornerRadius = 45
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = Color.offWhite.value.cgColor
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bold(size: .huge, scalable: true)
        label.textColor = Color.darkestGrey.value
        label.numberOfLines = 0
        return label
    }()
    
    private let handleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(size: .small, scalable: true)
        label.textColor = Color.lightGrey.value
        label.numberOfLines = 0
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(size: .normal, scalable: true)
        label.textColor = Color.darkestGrey.value
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
                                            placeholderImage: UIImage(named: "background-placeholdepr"))
        
        profilePictureImageView.sd_setImage(with: viewModel.profilePictureURL,
                                            placeholderImage: UIImage(named: "profile-placeholder"))
        
        nameLabel.text = viewModel.name
        handleLabel.text = viewModel.twitterHandle
        bioLabel.text = viewModel.bio
    }
    
    override func configureViewHierarchy() {
        // Add back button
        add(backButton, then: {
            $0.anchor(.leading(safeAreaLayoutGuide.leadingAnchor, constant: 16),
                      .top(safeAreaLayoutGuide.topAnchor, constant: 16))
            $0.constrainHeight(40)
            $0.constrainWidth($0.heightAnchor)
        })
        
        // Add profile picture image view
        add(profilePictureImageView, then: {
            $0.anchor(.leading(leadingAnchor, constant: 16),
                      .top(backButton.bottomAnchor, constant: 16))
            $0.constrainHeight(90)
            $0.constrainWidth($0.heightAnchor)
        })
        
        // Add name label
        add(nameLabel, then: {
            $0.anchor(.leading(leadingAnchor, constant: 16),
                      .top(profilePictureImageView.bottomAnchor, constant: 5),
                      .trailing(trailingAnchor, constant: -16))
        })
        
        // Add handle label
        add(handleLabel, then: {
            $0.anchor(.leading(leadingAnchor, constant: 16),
                      .top(nameLabel.bottomAnchor, constant: 2),
                      .trailing(trailingAnchor, constant: -16))
        })
        
        // Add bio label
        add(bioLabel, then: {
            $0.anchor(.leading(leadingAnchor, constant: 16),
                      .top(handleLabel.bottomAnchor, constant: 8),
                      .trailing(trailingAnchor, constant: -16),
                      .bottom(bottomAnchor, constant: -16))
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        })
        
        // Add background image view & overlay
        add(backgroundImageView, then: {
            $0.anchor(.leading(leadingAnchor),
                      .top(topAnchor),
                      .trailing(trailingAnchor),
                      .bottom(profilePictureImageView.centerYAnchor))
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
}

