import UIKit
import SwiftUI

struct StopListTableViewControllerWrapper: UIViewControllerRepresentable {
    @EnvironmentObject var model: ToynbeeModel
        
    func makeUIViewController(context: UIViewControllerRepresentableContext<StopListTableViewControllerWrapper>) -> StopListTableViewController {
        return StopListTableViewController(stops: model.stops) { (searchString) in
            model.stopSearchString = searchString
        } onSelection: { (stop) in
            model.select(stop: stop)
        } onCancel: {
            model.cancelStopSelection()
        }
    }
    
    func updateUIViewController(_ viewController: StopListTableViewController, context: UIViewControllerRepresentableContext<StopListTableViewControllerWrapper>) {
        viewController.update(stops: model.stops)
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
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        sb.delegate = self
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = searchBar
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: StopListTableViewController.cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.becomeFirstResponder()
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
}

extension StopListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        onSearchStringChange(searchText)
    }
}
