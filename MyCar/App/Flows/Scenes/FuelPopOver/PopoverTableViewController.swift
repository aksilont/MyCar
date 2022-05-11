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
    var model:[String] = []
    var index:IndexPath = [0,0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PopoverCell.self, forCellReuseIdentifier: PopoverCell.reuseID)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopoverCell", for: indexPath) as? PopoverCell else {return UITableViewCell()}
        
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
