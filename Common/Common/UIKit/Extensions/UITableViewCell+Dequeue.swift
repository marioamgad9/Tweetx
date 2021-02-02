import UIKit

extension UITableView {
    // MARK: - Cells registration & dequeuing
    /// Registers a cell from a class
    public func registerCellFromClass(_ type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(type, forCellReuseIdentifier: className)
    }
    
    /// Dequeues a cell
    public func dequeueReusableCell<T>(_ type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableCell(withIdentifier: className) as? T
    }
    
    // MARK: - HeaderFooter registration & dequeuing
    /// Registers a header from a class
    public func registerHeaderFooterViewFromClass(_ type: UITableViewHeaderFooterView.Type) {
        let className = String(describing: type)
        register(type, forHeaderFooterViewReuseIdentifier: className)
    }
    
    /// Dequeues a header footer from a class
    public func dequeueReusableHeaderFooterView<T>(_ type: T.Type) -> T? {
        let className = String(describing: type)
        return dequeueReusableHeaderFooterView(withIdentifier: className) as? T
    }
}
