![](https://travis-ci.org/miquido/NoBoilerplateTableViews.svg?branch=master)

# NoBoilerplateTableViews

## Installation

NoBoilerplateTableViews is available through Cocoapods. It depends on RxSwift and RxCocoa 4 in order to use BehaviorRelay to propagate data. To install
it, simply add the following line to your Podfile:

```ruby
pod 'NoBoilerplateTableViews', :git => "https://github.com/miquido/NoBoilerplateTableViews.git"
```

## Usage 

This library contains handy extensions for using ```UITableView```s, as well as protocols to automate implementation of simple, non-sectioned view controllers utilizing table views.

### RxTableViewControllable

Firstly, we want to create our ```UITableViewCell``` subclass:

```swift
class SampleCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Required initializations
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This init shouldn't be used")
    }
    
    func bind(to viewModel: SampleCellViewModel) {
        // ...
    }
}
```

Then we need to create items with the data to fill all the cells:

```swift
struct SampleCellViewModel {
    // Properties..
}
```

Finally, we create ```UIViewController``` that needs to display ```UITableView```. __It's very important that the properties from ```UITableViewWithRxConfigurable``` are declared in the class itself and tableView and disposeBag are stored properties__:

```swift
class ViewController: UIViewController, UITableViewConstraintsConfigurable {

    // MARK: - UITableViewWithRxConfigurable properties

    var items: BehaviorRelay<[SampleCellViewModel]> = BehaviorRelay(value: [])
    var disposeBag = DisposeBag()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewToFillFrame(in: view)
        configureTableViewWithRx()
    
        // Feed UITableView with data (1 item in our case)
        items.accept([ SampleCellViewModel(...) ])
    }
}

// MARK: - Rx table view

extension ViewController: UITableViewWithRxConfigurable {
    
    typealias Item = SampleCellViewModel
    typealias Cell = SampleCell
    
    func configureCell(_ cell: SampleCell, withItem item: SampleCellViewModel) {
        cell.bind(to: item)
    }
    
    func itemSelected(_ item: SampleCellViewModel, at indexPath: IndexPath) {
        print("Item at \(indexPath.row) was selected.")
    }
}
```

This library uses RxSwift and RxCocoa, so to provide data we use ```BehaviorRelay```. When creating our controller we need to provide ```DisposeBag```, ```UITableView``` and ```BehaviorRelay``` as the data producer - ```RxCocoa``` needs to be included for that to work. Then using typealias we estabilish what cell and item's types are going to be and we provide a function to configure the cell with an item. There are also callbacks for tapping the cell.

### Extensions

This section can be considered a small addition to the library. Firstly, to register the Cell's type or Header/Footer's type, we call:

```swift
// extension for registering cell
tableView.register(SampleCell.self)

// extension for registering header/footer
tableView.register(SampleHeaderView.self)
```
It must be noted that __this library allows only table view cells created from code, not from the NIBs.__

Later if we want to dequeue a cell:

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Extension for safely dequeing a cell
    let cell: SampleCell = tableView.cell(for: indexPath)
    cell.bind(to: items[indexPath.row])
    return cell
}
```

We can obtain header/footer view in a similar manner:

```swift
func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    // Extension for safely dequeing a header/footer
    return tableView.headerFooterView(SampleHeaderView.self)
}
```

### TODO
- Configuring UITableView without the use of RxSwift
- Support for protocol-based UIView for Empty View
- Support for sections (headers/footers) in ```UITableView``` - currently ```NoBoilerplateTableViews``` works only with simple lists
