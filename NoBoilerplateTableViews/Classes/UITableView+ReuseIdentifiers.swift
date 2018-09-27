import UIKit

public protocol ReuseIdentifiable: class { }

extension ReuseIdentifiable where Self: UIView {
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable { }

extension UITableViewHeaderFooterView: ReuseIdentifiable { }
