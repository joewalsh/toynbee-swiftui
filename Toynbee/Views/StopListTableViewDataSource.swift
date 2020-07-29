import UIKit

class StopListTableViewDataSource {
    enum Section: CaseIterable {
        case favorites
        case nearby
        case main
    }
    
    static let cellIdentifier = "com.example.cell.stop"
    
    let stops: [Stop]
    let dataSource: UITableViewDiffableDataSource<Section, Stop>
    
    init(stops: [Stop], tableView: UITableView) {
        self.stops = stops
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: StopListTableViewDataSource.cellIdentifier)
        dataSource = UITableViewDiffableDataSource<Section, Stop>(tableView: tableView, cellProvider: { (tableView, indexPath, stop) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StopListTableViewDataSource.cellIdentifier) else {
                fatalError()
            }
            cell.textLabel?.text = stop.name
            return cell
        })
        var firstSnapshot = NSDiffableDataSourceSnapshot<Section, Stop>()
        firstSnapshot.appendSections([.main])
        firstSnapshot.appendItems(stops, toSection: .main)
        dataSource.apply(firstSnapshot, animatingDifferences: false)
    }
    
    func performSearch(with searchString: String?) {
        var nextSnapshot = NSDiffableDataSourceSnapshot<Section, Stop>()
        nextSnapshot.appendSections([.main])
        defer {
            dataSource.apply(nextSnapshot, animatingDifferences: false)
        }
        guard let searchString = searchString else {
            nextSnapshot.appendItems(stops, toSection: .main)
            return
        }
        let stops = self.stops.filter { (stop) -> Bool in
            stop.name.starts(with: searchString) { (char, element) -> Bool in
                char.lowercased() == element.lowercased()
            }
        }
        nextSnapshot.appendItems(stops, toSection: .main)
    }
}
