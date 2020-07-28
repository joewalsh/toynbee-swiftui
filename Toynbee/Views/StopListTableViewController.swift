import UIKit
import SwiftUI

struct StopListTableViewControllerWrapper: UIViewControllerRepresentable {
    @EnvironmentObject var model: ToynbeeModel
    let title: String
        
    func makeUIViewController(context: UIViewControllerRepresentableContext<StopListTableViewControllerWrapper>) -> UINavigationController {
        let stopListTableViewController = StopListTableViewController(stops: model.stops) { (searchString) in
            model.stopSearchString = searchString
        } onSelection: { (stop) in
            model.select(stop: stop)
        } onCancel: {
            model.cancelStopSelection()
        }
        stopListTableViewController.title = title
        return UINavigationController(rootViewController: stopListTableViewController)
    }
    
    func updateUIViewController(_ viewController: UINavigationController, context: UIViewControllerRepresentableContext<StopListTableViewControllerWrapper>) {
        guard let stopListVC = viewController.viewControllers.first as? StopListTableViewController else {
            return
        }
        stopListVC.update(stops: model.stops)
    }
}

class StopListTableViewController: UITableViewController {
    private(set) var stops: [Stop] {
        didSet {
            tableView.reloadData()
        }
    }
    let onSearchStringChange: (String) -> Void
    let onSelection: (Stop) -> Void
    let onCancel: () -> Void
    
    init(stops: [Stop], onSearchStringChange: @escaping (String) -> Void, onSelection: @escaping (Stop) -> Void, onCancel: @escaping () -> Void) {
        self.stops = stops
        self.onSearchStringChange = onSearchStringChange
        self.onSelection = onSelection
        self.onCancel = onCancel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(stops updatedStops: [Stop]) {
        guard !updatedStops.difference(from: stops).isEmpty else {
            return
        }
        stops = updatedStops
    }
    
    static let cellIdentifier = "com.example.cell.stop"
    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: StopListTableViewController.cellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.becomeFirstResponder()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StopListTableViewController.cellIdentifier, for: indexPath)
        let stop = stops[indexPath.item]
        cell.textLabel?.text = stop.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelection(stops[indexPath.item])
    }
    
    @objc func cancel() {
        onCancel()
    }
}

extension StopListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        onSearchStringChange(searchController.searchBar.text ?? "")
    }
}
