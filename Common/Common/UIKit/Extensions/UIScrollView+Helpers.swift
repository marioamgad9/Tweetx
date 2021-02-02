import UIKit

extension UIScrollView {
    /// Checks whether the scrollview is at bottom or not
    public var isAtBottom: Bool {
        return contentOffset.y >= -contentInset.top
    }
    
    /// Scrolls to a specific view so that it's top is at the top our scrollview
    public func scrollToView(view: UIView, animated: Bool) {
        if let origin = view.superview {
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            self.scrollRectToVisible(CGRect(x:0, y: childStartPoint.y, width: 1, height: self.frame.height),
                                     animated: animated)
        }
    }
    
    /// Scrolls to the bottom of the scrollview
    public func scrollToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }

    /// Indicates whether a scrollview has reached its end or not
    public func didReachEnd(offset: CGFloat = 0) -> Bool {
        return contentOffset.y >= (contentSize.height - frame.size.height - offset)
    }
    
    public func nudgeHorizontally() {
//        let xOffset = min(100, max(contentSize.width - frame.width, 0))
        setContentOffset(CGPoint(x: 50, y: 0), animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    public func nudgeVertically() {
//        let yOffset = min(100, max(contentSize.height - frame.height, 0))
        setContentOffset(CGPoint(x: 0, y: 50), animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
}
