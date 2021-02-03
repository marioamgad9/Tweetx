//
//  TweetTableViewCell.swift
//  Followers
//
//  Created by Mario Mouris on 03/02/2021.
//

import UIKit
import Common
import SDWebImage

/// Handles showing a single tweet for a user
class TweetTableViewCell: NiblessTableViewCell {
    
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
        imageView.layer.cornerRadius = Dimens.cornerRadius
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
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(size: .normal, scalable: true)
        label.textColor = Color.darkestGrey.value
        label.numberOfLines = 0
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.regular(size: .normal, scalable: true)
        label.textColor = Color.darkestGrey.value
        return label
    }()
    
    // MARK: - Methods
    func configure(with viewModel: TweetCellViewModel) {
        profilePictureImageView.sd_setImage(with: viewModel.profilePictureURL,
                                            placeholderImage: UIImage(named: "profile-placeholder"))
        nameLabel.text = viewModel.name
        handleLabel.text = viewModel.twitterHandle
        contentLabel.text = viewModel.content
        timeLabel.text = viewModel.time
    }
    
    override func configureViewHierarchy() {
        // Add profile picture image view
        cardView.add(profilePictureImageView, then: {
            $0.anchor(.leading(cardView.leadingAnchor, constant: 16),
                      .top(cardView.topAnchor, constant: 16))
            $0.constrainWidth(50)
            $0.constrainHeight(50)
        })
        
        // Add time label
        cardView.add(timeLabel, then: {
            $0.anchor(.trailing(cardView.trailingAnchor, constant: -16))
            $0.centerYTo(profilePictureImageView.centerYAnchor)
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
                      .trailing(timeLabel.leadingAnchor, constant: -16))
            $0.centerYTo(profilePictureImageView.centerYAnchor)
        })
        
        // Add content label
        cardView.add(contentLabel, then: {
            $0.anchor(.leading(cardView.leadingAnchor, constant: 16),
                      .top(userInfoStackView.bottomAnchor, constant: 16),
                      .trailing(cardView.trailingAnchor, constant: -16),
                      .bottom(cardView.bottomAnchor, constant: -16))
        })
        
        // Add cardview
        add(cardView, then:{
            $0.anchor(.leading(leadingAnchor, constant: 16),
                      .top(topAnchor),
                      .trailing(trailingAnchor, constant: -16),
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
