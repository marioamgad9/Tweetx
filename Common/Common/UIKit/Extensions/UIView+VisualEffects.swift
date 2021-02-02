import UIKit

extension UIView {
    /// Adds a blur visual effect
    public func addBlurEffect(style: UIBlurEffect.Style = .dark) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    /// Adds shade effect above view
    public func addShadeEffect(color: UIColor = .black, opacity: CGFloat = 0.7) {
        let shadeView = UIView()
        shadeView.backgroundColor = color
        shadeView.alpha = opacity
        shadeView.frame = bounds
        shadeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(shadeView)
    }
    
    /// Drops a shadow under view
    public func dropShadow(opacity: Float = 0.5,
                          offset: CGSize = CGSize(width: 0, height: 2),
                          radius: CGFloat = 4,
                          color: CGColor = Color.black.value.cgColor) {
        layer.shadowColor = color
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
