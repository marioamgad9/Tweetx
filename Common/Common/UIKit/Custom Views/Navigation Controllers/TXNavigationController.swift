import UIKit

open class TXNavigationController: NiblessNavigationController, UIGestureRecognizerDelegate {
    
    // MARK: - Initializer
    public override init() {
        super.init()
        
        // Hide navigation bar
        self.isNavigationBarHidden = true
        
        self.interactivePopGestureRecognizer?.delegate = self
        
        // Setup navigation bar (For view controllers that show it)
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
        navigationBar.barTintColor = Color.primary.value
        navigationBar.tintColor = Color.white.value
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Color.white.value,
                                             NSAttributedString.Key.font: UIFont.bold(size: .big)]
        navigationBar.shadowImage = UIImage()
        
        let attributes = [NSAttributedString.Key.font:  UIFont.regular(size: .normal),
                          NSAttributedString.Key.foregroundColor: UIColor.white]
        let BarButtonItemAppearance = UIBarButtonItem.appearance(whenContainedInInstancesOf: [TXNavigationController.self])
        
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .normal)
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .highlighted)
    }
    
    // MARK: - Methods
    // Workaround to enable back gesture
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
