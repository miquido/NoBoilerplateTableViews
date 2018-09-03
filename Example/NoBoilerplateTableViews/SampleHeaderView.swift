import UIKit

class SampleHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let bgView = UIView()
        bgView.backgroundColor = .red
        backgroundView = bgView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This init shouldn't be used")
    }
}
