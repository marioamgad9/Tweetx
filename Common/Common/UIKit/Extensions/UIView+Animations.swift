import UIKit

extension UIView {
    /// Animates a view with an endless blinking
    public func animateEndlessBlinking(blinkDuration: Double = 0.5) {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1
        scaleAnimation.toValue = 0.9
        scaleAnimation.isRemovedOnCompletion = false
        scaleAnimation.duration = blinkDuration
        scaleAnimation.repeatCount = Float.infinity
        scaleAnimation.autoreverses = true
        self.layer.add(scaleAnimation, forKey: nil)
    }
}
