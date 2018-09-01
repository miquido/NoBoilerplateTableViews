import UIKit

extension UITableView {
    
    /// Automatically dequeues cell for UITableViewCell subtype.
    /// - parameter indexPath: IndexPath from which to dequeue.
    /// - returns: Cell of given type; Empty cell instance if dequeueing has failed.
    public func cell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            return T()
        }
        
        return cell
    }
    
    /// Automatically dequeues header/footer for UITableViewHeaderFooterView subtype.
    /// - returns: Header/footer of given type; Empty header/footer instance if dequeueing has failed.
    public func headerFooterView<T: UITableViewHeaderFooterView>(_: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            return T()
        }
        
        return view
    }
}
