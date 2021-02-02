import UIKit

extension UIViewController {
    
    // MARK: - Methods
    public func addFullScreen(childViewController child: UIViewController) {
        guard child.parent == nil else {
            return
        }
        
        addChild(child)
        view.add(child.view, then: {
            $0.fillSuperview()
        })
        
        child.didMove(toParent: self)
    }
    
    public func remove(childViewController child: UIViewController?) {
        guard let child = child else {
            return
        }
        
        guard child.parent != nil else {
            return
        }
        
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    public func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

