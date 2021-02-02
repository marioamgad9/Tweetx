//
//  UIApplication+TopMostVC.swift
//  Common
//
//  Created by Mario Mouris on 11/10/20.
//  Copyright © 2020 Crescendoes. All rights reserved.
//

import UIKit

extension UIApplication {
    public static var topMostViewController: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController?.visibleViewController
    }
}

extension UIViewController {
    public var visibleViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.visibleViewController
        } else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.visibleViewController
        } else if let presentedViewController = presentedViewController {
            return presentedViewController.visibleViewController
        } else {
            return self
        }
    }
}
