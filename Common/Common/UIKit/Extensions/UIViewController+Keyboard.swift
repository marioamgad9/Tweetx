import UIKit

// MARK: - Keyboard extensions
extension UIViewController {
    /// Hides soft keyboard on tap anywhere
    @discardableResult
    public func hideKeyboardOnTap() -> UITapGestureRecognizer {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        return tap
    }
    
    /// Dismisses keyboard instantly
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// Changes the bottom constraint constant if it conforms to KeyboardFlexible
    @objc public func keyboardWillShow(with notification: Notification) {
        let key = "UIKeyboardFrameEndUserInfoKey"
        guard let keyboardFrame = notification.userInfo?[key] as? NSValue else {return}
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        if let viewController = self as? KeyboardResponsive {
            viewController.keyboardWillShow(keyboardHeight: keyboardHeight)
        }
    }
    
    /// Changes the bottom constraint constant if it conforms to KeyboardFlexible
    @objc public func keyboardWillHide(with notification: Notification) {
        if let viewController = self as? KeyboardResponsive {
            viewController.keyboardWillHide()
        }
    }
}
