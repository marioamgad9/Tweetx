import UIKit

extension UIView {
    /// Adds a subview to the parent and then performs a closure (Usually the constraints being set)
    @discardableResult
    public func add<T: UIView>(_ subview: T, then closure: ((T) -> Void) = {_ in }) -> T {
        addSubview(subview)
        closure(subview)
        return subview
    }
    
    /// Adds a subview to the parent and constraints it to the parent edges with the specified spacing
    @discardableResult
    public func addAndConstraintToEdges<T: UIView>(_ subview: T, withSpacing spacing: CGFloat = 8) -> T {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
            subview.topAnchor.constraint(equalTo: topAnchor, constant: spacing),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spacing)
        ])
        return subview
    }
}
