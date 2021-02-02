import UIKit

public protocol Loadable {
    var loaderView: LoaderView { get set }
    func showLoaderView()
    func hideLoaderView()
}

extension Loadable where Self: UIView {
    public func showLoaderView() {
        guard !loaderView.isDescendant(of: self) else { return }
        
        add(loaderView, then: {
            $0.fillSuperview()
        })
    }
    
    public func hideLoaderView() {
        guard loaderView.isDescendant(of: self) else { return }
        
        loaderView.removeFromSuperview()
    }
}
