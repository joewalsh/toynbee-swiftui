import UIKit
import SwiftUI

struct StopListTableViewControllerWrapper: UIViewControllerRepresentable {
    @EnvironmentObject var model: ToynbeeModel
        
    func makeUIViewController(context: UIViewControllerRepresentableContext<StopListTableViewControllerWrapper>) -> StopListTableViewController {
        return StopListTableViewController(model: model)
    }
    
    func updateUIViewController(_ viewController: StopListTableViewController, context: UIViewControllerRepresentableContext<StopListTableViewControllerWrapper>) {
        viewController.tableView.reloadData()
    }
}

class StopListTableViewController: UITableViewController {
    init(model: ToynbeeModel) {
        self.model = model
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let model: ToynbeeModel
    
    static let cellIdentifier = "com.example.cell.stop"
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        sb.delegate = self
        sb.text = model.stopSearchString
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
        return model.stops.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StopListTableViewController.cellIdentifier, for: indexPath)
        let stop = model.stops[indexPath.item]
        cell.textLabel?.text = stop.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.select(stop: model.stops[indexPath.item])
    }
}

extension StopListTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.stopSearchString = searchText
    }
}
