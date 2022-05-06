//
//  PopoverTableViewController.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit
protocol PopoverTableViewControllerDelegate: AnyObject {
    func fuelDidSelect(_ fuel: String)
}

class PopoverTableViewController: UITableViewController {
    weak var delegate: PopoverTableViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PopoverCell.self, forCellReuseIdentifier: PopoverCell.reuseID)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FuelModel.allCases.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopoverCell", for: indexPath) as? PopoverCell else {return UITableViewCell()}
        let fuelModel = FuelModel(rawValue: indexPath.row)
        cell.textLabel?.text = fuelModel?.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        let indexCase = indexPath.row
        let fuelModel = FuelModel(rawValue: indexCase)
        let fuel = fuelModel?.description ?? ""
        delegate?.fuelDidSelect(fuel)
        
        print(fuel)
        
    }
    
    
}
