import UIKit

// MARK: - Cell and Header View

class SampleCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This init shouldn't be used")
    }
    
    func bind(to viewModel: SampleCellViewModel) {
        backgroundColor = viewModel.backgroundColor
    }
}

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

// MARK: - Model

struct SampleCellViewModel: Equatable {
    let backgroundColor: UIColor
}
