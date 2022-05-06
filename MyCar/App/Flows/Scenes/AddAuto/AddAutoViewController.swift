//
//  AddAutoViewController.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit

class AddAutoViewController: UIViewController {
    var fuelType = ""
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AutoCell.self, forCellReuseIdentifier: AutoCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let readyButton: UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.backgroundColor = #colorLiteral(red: 0.2172074616, green: 0.6069719195, blue: 0.6331881881, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .highlighted)
        button.setTitle("Готово", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .dateAndTime
        picker.backgroundColor = #colorLiteral(red: 0.04778223485, green: 0.108998023, blue: 0.1143187657, alpha: 1)
        picker.layer.cornerRadius = 20
        picker.layer.masksToBounds = false
        picker.sizeToFit()
        picker.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        let localID = "RU"//Locale.preferredLanguages.first
        picker.locale = Locale(identifier: localID)
        let dateAgo = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateLater = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        picker.minimumDate = dateAgo
        picker.maximumDate = dateLater
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigationAttributes()
        configureTableView()
        configurElements()
      
    }
    func configurElements(){
        self.view.addSubview(readyButton)
        readyButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0).isActive = true
        readyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        readyButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 1.5).isActive = true
        readyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: view.frame.size.height - 50 ).isActive = true
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.rowHeight = 60
        tableView.backgroundColor = .black
        
    }
    func setupNavigationAttributes(){
        self.title = "Добавить авто"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
 
}
extension AddAutoViewController: UITableViewDelegate, UITableViewDataSource {
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return AutoModel.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexCase = indexPath.section
        let autoModel = AutoModel(rawValue: indexCase)
        switch autoModel {
    
        case .Item:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            return cell
        case .Model:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            return cell
        case .Number:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            return cell
        case .Year:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            return cell
        case .Distance:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            return cell
        case .FuelType:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            cell.infoTextField.text = fuelType
            return cell
        case .Vin:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            return cell
        case .none:
            break
       
        }
        return UITableViewCell()
    }
    func cellContent(cell: AutoCell, autoModel: AutoModel){
        cell.iconImageView.image = autoModel.image
        cell.autoLabel.text = autoModel.description
        cell.infoTextField.text = ""
        cell.selectionStyle = .none
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! AutoCell

        let indexCase = indexPath.section
        let autoModel = AutoModel(rawValue: indexCase)
        switch autoModel {
    
        case .Item:
            cell.infoTextField.becomeFirstResponder()
            print("item")
        case .Model:
            cell.infoTextField.becomeFirstResponder()
            print("Model")
        case .Number:
            cell.infoTextField.becomeFirstResponder()
            print("Number")
        case .Year:
            cell.infoTextField.becomeFirstResponder()
            cell.infoTextField.inputView = datePicker
            print("Year")
        case .Distance:
            cell.infoTextField.becomeFirstResponder()
            print("Distance")
        case .FuelType:
            cell.infoTextField.becomeFirstResponder()
            gotoPopover(cell: cell)
            print("FuelType")
        case .Vin:
            cell.infoTextField.becomeFirstResponder()
            print("VIN")
        case .none:
            break
       
        }
    }
   
}

extension AddAutoViewController: UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func gotoPopover(cell: AutoCell){
      
        let popVC = PopoverTableViewController()
        popVC.modalPresentationStyle = .popover
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = cell
        popOverVC?.sourceRect = CGRect(x: cell.bounds.width, y: cell.bounds.minY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        self.present(popVC, animated: true)
        
    }
    
}
extension AddAutoViewController: PopoverTableViewControllerDelegate{
    func fuelDidSelect(_ fuel: String) {
        self.fuelType = fuel
        print(fuel + fuel)
        tableView.reloadData()
    }
    
    
}


