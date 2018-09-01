import UIKit
import RxSwift
import RxCocoa

class SampleRxTableViewController: UIViewController, UITableViewConstraintsConfigurable {
    
    // MARK: - UITableViewWithRxConfigurable properties
    
    let items: BehaviorRelay<[SampleCellViewModel]> = BehaviorRelay(value: [])
    let tableView: UITableView = UITableView()
    let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Class properties
    
    var itemSelectedClosure: ((SampleCellViewModel, IndexPath) -> Void)?
    
    private let models: [SampleCellViewModel]
    
    init(with models: [SampleCellViewModel]) {
        self.models = models
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewToFillFrame(in: view)
        configureTableViewWithRx()
        items.accept(models)
    }
}

extension SampleRxTableViewController: UITableViewWithRxConfigurable, UITableViewDelegate {
    
    typealias Item = SampleCellViewModel
    typealias Cell = SampleCell
    
    func configureCell(_ cell: SampleCell, withItem item: SampleCellViewModel) {
        cell.bind(to: item)
    }
    
    func itemSelected(_ item: SampleCellViewModel, at indexPath: IndexPath) {
        itemSelectedClosure?(item, indexPath)
    }
}
