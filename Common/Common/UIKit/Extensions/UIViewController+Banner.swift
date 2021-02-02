//
//  UIViewController+Banner.swift
//  Common
//
//  Created by Mario Mouris on 5/25/20.
//  Copyright © 2020 Crescendoes. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Shows a banner on the top
    @discardableResult
    public func showBanner(title: String?,
                           message: String,
                           duration: TimeInterval? = 1.0,
                           image: UIImage? = nil,
                           backgroundColor: UIColor = Color.primary.value,
                           textColor: UIColor = Color.secondary.value,
                           didTapBanner: (() ->())? = nil) -> Banner {
        let banner = Banner(title: title, subtitle: message, image: image,
                            backgroundColor: backgroundColor, didTapBlock: didTapBanner)
        banner.textColor = textColor
        banner.show(duration: duration)
        return banner
    }
}
