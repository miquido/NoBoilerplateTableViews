import Foundation
import RxSwift
import RxCocoa

// MARK - Configuring UITableView with Rx

public protocol UITableViewWithRxConfigurable: UITableViewDelegate, UITableViewCellSelectable, UITableViewCellConfigurable {
    
    var items: BehaviorRelay<[Item]> { get }
    var tableView: UITableView { get }
    var disposeBag: DisposeBag { get }
    
    func configureTableViewWithRx()
}

extension UITableViewWithRxConfigurable {
    
    /// Convenience method for configuring delegates, binding to data source and assigning cell tap callbacks.
    public func configureTableViewWithRx() {
        configureDelegates()
        bindItemsRelayToTableView()
        configureSelectingCells()
    }
    
    private func configureDelegates() {
        tableView.dataSource = nil
        tableView.delegate = nil
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func bindItemsRelayToTableView() {
        tableView.register(Cell.self)
        
        items.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: Cell.reuseIdentifier, cellType: Cell.self)) { [weak self] (row, item, cell) in
                self?.configureCell(cell, withItem: item)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureSelectingCells() {
        let modelSelectedControlEvent = tableView.rx.modelSelected(Item.self)
        let indexPathSelectedControlEvent = tableView.rx.itemSelected
        
        Observable.zip(modelSelectedControlEvent, indexPathSelectedControlEvent)
            .subscribe(onNext: { [weak self] (model, indexPath) in
                self?.itemSelected(model, at: indexPath)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Selecting cell callbacks

public protocol UITableViewCellSelectable: UITableViewGenerics {
    
    func itemSelected(_ item: Item, at indexPath: IndexPath)
}

extension UITableViewCellSelectable {
    
    func itemSelected(_ item: Item, at indexPath: IndexPath) {
        // Default no-op implementation
    }
}

// MARK: - Configuring cell

public protocol UITableViewCellConfigurable: UITableViewGenerics {
    
    func configureCell(_ cell: Cell, withItem item: Item)
}

// MARK: - Generics

public protocol UITableViewGenerics {
    
    associatedtype Item
    associatedtype Cell: UITableViewCell
}
