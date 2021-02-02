import UIKit

open class NiblessTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Methods
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureViewHierarchy()
        viewHierarchyDidConfigure()
    }
    
    @available(*, unavailable,
    message: "Loading this view from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    /// This is where all the view hierarchy setup should happen, it is called automatically in didMoveToWindow
    open func configureViewHierarchy() {}
    
    /// This is called after the view hierarchy is configured.
    open func viewHierarchyDidConfigure() {}
}


