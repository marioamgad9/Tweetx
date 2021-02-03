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
    private let backgroundImageView: UIImageView = {
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
    
    private let profilePictureImageView: UIImageView = {
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
        // Add background image view & overlay
        add(backgroundImageView, then: {
            $0.anchor(.leading(leadingAnchor),
                      .top(topAnchor),
                      .trailing(trailingAnchor))
            $0.constrainHeight(150)
        })
        
        add(backgroundColorOverlay, then: {
            $0.anchor(.leading(backgroundImageView.leadingAnchor),
                      .top(backgroundImageView.topAnchor),
                      .trailing(backgroundImageView.trailingAnchor),
                      .bottom(backgroundImageView.bottomAnchor))
        })
        
        // Add profile picture image view
        add(profilePictureImageView, then: {
            $0.anchor(.leading(leadingAnchor, constant: 16))
            $0.centerYTo(backgroundImageView.bottomAnchor)
            $0.constrainHeight(90)
            $0.constrainWidth(90)
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
        })
    }
    
    override func viewHierarchyDidConfigure() {
        backgroundColor = Color.offWhite.value
    }
}

