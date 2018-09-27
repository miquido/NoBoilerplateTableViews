import UIKit

extension UITableView {
    
    /// Registers UITableViewCell subtype automatically
    public func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Reigsters UITableViewHeaderFooterView subtype automatically
    public func register<T: UITableViewHeaderFooterView>(_: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
}
