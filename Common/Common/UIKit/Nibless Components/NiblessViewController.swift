import UIKit

open class NiblessViewController: UIViewController {
    
    // MARK: - Methods
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
    )
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewHierarchy()
        viewHierarchyDidConfigure()
    }
    
    /// This is where all the view hierarchy setup should happen, it is called automatically in didMoveToWindow
    open func configureViewHierarchy() {}
    
    /// This is called after the view hierarchy is configured.
    open func viewHierarchyDidConfigure() {}
}

