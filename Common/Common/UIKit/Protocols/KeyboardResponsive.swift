//
//  KeyboardResponder.swift
//  OurStoryUIKit
//
//  Created by Mario Mouris on 6/1/19.
//  Copyright © 2019 Mario Mouris. All rights reserved.
//

import UIKit

/// Makes the keyboard push the scrollview when shown and pulls it when hidden
public protocol KeyboardResponsive: class {
    func keyboardWillShow(keyboardHeight: CGFloat)
    func keyboardWillHide()
}

extension KeyboardResponsive where Self: UIViewController {
    public func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(with:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(with:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    public func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}

