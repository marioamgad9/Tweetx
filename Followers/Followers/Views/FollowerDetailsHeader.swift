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
    
    // MARK: - Methods
    func configure(with viewModel: FollowerDetailsHeaderViewModel) {
        backgroundImageView.sd_setImage(with: viewModel.backgroundImageURL,
                                            placeholderImage: UIImage(named: "background-placeholdepr"))
    }
    
    override func configureViewHierarchy() {
        // Add background image view
        add(backgroundImageView, then: {
            $0.fillSuperview()
            $0.constrainHeight(150)
        })
    }
}

