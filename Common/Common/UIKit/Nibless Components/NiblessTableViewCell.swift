import UIKit

/// A table cell class that's written purely in code without storyboards.
open class NiblessTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static public var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Methods
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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

