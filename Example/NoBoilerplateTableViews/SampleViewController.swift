import UIKit
import RxSwift
import RxCocoa
import NoBoilerplateTableViews

class SampleViewController: UIViewController, UITableViewConstraintsConfigurable {
    
    // MARK: - UITableViewWithRxConfigurable properties
    
    let items: BehaviorRelay<[SampleCellViewModel]> = BehaviorRelay(value: [])
    lazy var tableView: UITableView = UITableView()
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewToFillFrame(in: view)
        configureTableViewWithRx()

        // feed UITableView with data
        items.accept([ SampleCellViewModel(backgroundColor: .blue) ])
    }
}

extension SampleViewController: UITableViewWithRxConfigurable {
    
    typealias Item = SampleCellViewModel
    typealias Cell = SampleCell
    
    func configureCell(_ cell: SampleCell, withItem item: SampleCellViewModel) {
        cell.bind(to: item)
    }
    
    func itemSelected(_ item: SampleCellViewModel, at indexPath: IndexPath) {
        print("Item at \(indexPath.row) was selected.")
    }
}
