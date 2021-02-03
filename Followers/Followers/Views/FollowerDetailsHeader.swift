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
    
    // MARK: - Methods
    func configure(with viewModel: FollowerDetailsHeaderViewModel) {
        backgroundImageView.sd_setImage(with: viewModel.backgroundImageURL,
                                            placeholderImage: UIImage(named: "background-placeholdepr"))
    }
    
    override func configureViewHierarchy() {
        // Add background image view & overlay
        add(backgroundImageView, then: {
            $0.fillSuperview()
            $0.constrainHeight(150)
        })
        
        add(backgroundColorOverlay, then: {
            $0.anchor(.leading(backgroundImageView.leadingAnchor),
                      .top(backgroundImageView.topAnchor),
                      .trailing(backgroundImageView.trailingAnchor),
                      .bottom(backgroundImageView.bottomAnchor))
        })
    }
}

