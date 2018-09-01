import UIKit

public protocol UITableViewConstraintsConfigurable {
    func configureTableViewToFillFrame(in container: UIView)
}

extension UITableViewConstraintsConfigurable where Self: UITableViewWithRxConfigurable {
    
    public func configureTableViewToFillFrame(in container: UIView) {
        container.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: container.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
    }
}
