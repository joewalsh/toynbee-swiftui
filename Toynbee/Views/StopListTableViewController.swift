import UIKit
import SwiftUI

struct StopListTableViewControllerWrapper: UIViewControllerRepresentable {
    @EnvironmentObject var model: ToynbeeModel
    let title: String
        
    func makeUIViewController(context: UIViewControllerRepresentableContext<StopListTableViewControllerWrapper>) -> UINavigationController {
        let stopListTableViewController = StopListTableViewController(stops: model.stops) { (stop) in
            model.select(stop: stop)
        } onCancel: {
            model.cancelStopSelection()
        }
        stopListTableViewController.title = title
        return UINavigationController(rootViewController: stopListTableViewController)
    }
    
    func updateUIViewController(_ viewController: UINavigationController, context: UIViewControllerRepresentableContext<StopListTableViewControllerWrapper>) {

    }
}

class StopListTableViewController: UITableViewController {
    let onSelection: (Stop) -> Void
    let onCancel: () -> Void
    var dataSource: StopListTableViewDataSource!
    
    init(stops: [Stop], onSelection: @escaping (Stop) -> Void, onCancel: @escaping () -> Void) {
        self.onSelection = onSelection
        self.onCancel = onCancel
        super.init(style: .plain)
        self.dataSource = StopListTableViewDataSource(stops: stops, tableView: tableView)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        let cancelButton = UIBarButtonItem(image: UIImage(named: "xmark"), style: .plain, target: self, action: #selector(cancel))
        cancelButton.accessibilityLabel = NSLocalizedString("Cancel", comment: "Cancel")
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelection(dataSource.stops[indexPath.item])
    }
    
    @objc func cancel() {
        onCancel()
    }
}

extension StopListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        dataSource.performSearch(with: searchController.searchBar.text)
    }
}
