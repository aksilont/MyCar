//
//  PopoverTableViewController.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit

protocol PopoverTableViewControllerDelegate: AnyObject {
    func fuelDidSelect(_ param: String, index: IndexPath)
}

class PopoverTableViewController: UITableViewController {
    weak var delegate: PopoverTableViewControllerDelegate?
    var model: [String] = []
    var index: IndexPath = [0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(registerClass: PopoverCell.self)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PopoverCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let param = model[indexPath.row]
        cell.textLabel?.text = param
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        let param = model[indexPath.row]
        delegate?.fuelDidSelect(param, index: self.index )
    }
    
}
