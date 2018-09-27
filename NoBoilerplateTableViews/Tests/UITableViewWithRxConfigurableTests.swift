import Foundation
import RxSwift
import RxCocoa
import XCTest

class UITableViewWithRxConfigurableTests: XCTestCase {
    
    private lazy var viewController: SampleRxTableViewController = {
        let vc = SampleRxTableViewController(with: items)
        vc.loadViewIfNeeded()
        return vc
    }()
    
    private let items = [
        SampleCellViewModel(backgroundColor: .yellow),
        SampleCellViewModel(backgroundColor: .blue)
    ]
    
    func testTableViewHasRightNumberOfCells() {
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), items.count)
    }
    
    func testTableViewHasRightNumberOfSections() {
        XCTAssertEqual(viewController.tableView.numberOfSections, 1)
    }
    
    func testCellsExistAndHaveRightType() {
        for i in 0 ..< items.count {
            let currentIndexPath = IndexPath(row: i, section: 0)
            let cell = viewController.tableView.cellForRow(at: currentIndexPath)
            XCTAssertNotNil(cell)
            XCTAssertTrue(cell!.isKind(of: SampleCell.self))
        }
    }
    
    func testSelectingCells() {
        let tapExp = expectation(description: "Waiting to select the right item")
        
        viewController.itemSelectedClosure = { [weak self] (selectedItem, selectedIndexPath) in
            //Checking if tap on first cell selected the right item
            
            let selectedItemIndex = self?.items.index(of: selectedItem)
            XCTAssertEqual(selectedIndexPath.row, selectedItemIndex)
            
            let itemAtIndexPathBackgroundColor = self?.items[selectedIndexPath.row].backgroundColor
            XCTAssertEqual(selectedItem.backgroundColor, itemAtIndexPathBackgroundColor)
            
            tapExp.fulfill()
        }
        
        let indexPathToSelect = IndexPath(row: 0, section: 0)
        let tableView = viewController.tableView
        tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPathToSelect)
        wait(for: [tapExp], timeout: 1.0)
    }
    
    func testReuseIdentifiersAreCorrect() {
        XCTAssertEqual(SampleCell.reuseIdentifier, "SampleCell")
        XCTAssertEqual(SampleHeaderView.reuseIdentifier, "SampleHeaderView")
    }
}
