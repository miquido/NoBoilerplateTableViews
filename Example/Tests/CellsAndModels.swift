import UIKit

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

struct SampleCellViewModel: Equatable {
    let backgroundColor: UIColor
}
