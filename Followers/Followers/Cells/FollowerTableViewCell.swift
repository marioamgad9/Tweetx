//
//  FollowerTableViewCell.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common
import SDWebImage

/// Handles showing a single follower user
class FollowerTableViewCell: NiblessTableViewCell {
    
    // MARK: - Views
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.white.value
        view.layer.cornerRadius = Dimens.cornerRadius
        view.clipsToBounds = true
        return view
    }()
    
    private let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bold(size: .big, scalable: true)
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
    
    private let exploreTweetsLabel: UILabel = {
        let label = UILabel()
        label.text = "label.exlore_tweets".localized
        label.font = UIFont.bold(size: .small, scalable: true)
        label.textColor = Color.primary.value
        label.textAlignment = .center
        return label
    }()
    
    private let footerViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Color.secondary.value.withAlphaComponent(0.7)
        return view
    }()
    
    // MARK: - Methods
    func configure(with viewModel: FollowerCellViewModel) {
        
    }
    
    override func configureViewHierarchy() {
        // Add profile picture image view
        cardView.add(profilePictureImageView, then: {
            $0.anchor(.leading(cardView.leadingAnchor, constant: 16),
                      .top(cardView.topAnchor, constant: 16))
            $0.constrainWidth(50)
            $0.constrainHeight(50)
        })
        
        // Configure user info stackview
        let userInfoStackView = UIStackView(arrangedSubviews: [nameLabel, handleLabel])
        userInfoStackView.spacing = 2
        userInfoStackView.axis = .vertical
        userInfoStackView.alignment = .leading
        userInfoStackView.distribution = .fill
        
        userInfoStackView.add(nameLabel)
        userInfoStackView.add(handleLabel)
        
        cardView.add(userInfoStackView, then: {
            $0.anchor(.leading(profilePictureImageView.trailingAnchor, constant: 12),
                      .trailing(cardView.trailingAnchor, constant: -16))
            $0.centerYTo(profilePictureImageView.centerYAnchor)
        })
        
        // Add bio label
        cardView.add(bioLabel, then: {
            $0.anchor(.leading(cardView.leadingAnchor, constant: 16),
                      .top(userInfoStackView.bottomAnchor, constant: 8),
                      .trailing(cardView.trailingAnchor, constant: -16))
        })
        
        // Add expore tweets label
        footerViewContainer.add(exploreTweetsLabel, then: {
            $0.fillSuperview(padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
        })
        
        // Add footer container
        cardView.add(footerViewContainer, then: {
            $0.anchor(.leading(cardView.leadingAnchor),
                      .top(bioLabel.bottomAnchor, constant: 16),
                      .trailing(cardView.trailingAnchor),
                      .bottom(cardView.bottomAnchor, constant: -16))
        })
        
        // Add cardview
        add(cardView, then:{
            $0.anchor(.leading(leadingAnchor),
                      .top(topAnchor),
                      .trailing(trailingAnchor),
                      .bottom(bottomAnchor, constant: -10))
        })
    }
    
    override func viewHierarchyDidConfigure() {
        // Set background color
        backgroundColor = .clear
        
        // Set selection style
        selectionStyle = .none
        
        // Clip to bounds
        clipsToBounds = true
    }
}
