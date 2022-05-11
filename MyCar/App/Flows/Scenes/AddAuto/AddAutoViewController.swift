//
//  AddAutoViewController.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit
protocol AddAutoViewControllerDelegate: AnyObject {
    func appendAuto(_ auto: CarModel)
}

class AddAutoViewController: UIViewController, UITextFieldDelegate {
    weak var delegate: AddAutoViewControllerDelegate?
    var indexText: IndexPath?
    var carModel = CarModel(item: "", model: "", number: "", year: "", distance: 0, vin: "", activFlag: false, fuelType: "")
    let carRepository = CarRepository()
    let carParametrsModel = CarParametrsModel()
    
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
        readyButton.addTarget(self, action: #selector(touchReady), for: .touchUpInside)
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
    @objc func touchReady(){
        if carModel.item != "" && carModel.number != "" {
        carRepository.saveCar(carModel: carModel)
        delegate?.appendAuto(carModel)
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            print("no item and no number")
        }
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
            cell.infoTextField.delegate = self
            cell.infoTextField.text = carModel.item
            return cell
        case .Model:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            cell.infoTextField.delegate = self
            cell.infoTextField.text = carModel.model
            return cell
        case .Number:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            cell.infoTextField.delegate = self
            cell.infoTextField.text = carModel.number
            return cell
        case .Year:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            cell.infoTextField.delegate = self
            cell.infoTextField.text = carModel.year
            return cell
        case .Distance:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            cell.infoTextField.delegate = self
            cell.infoTextField.keyboardType = .numbersAndPunctuation
            cell.infoTextField.returnKeyType = .done
            cell.infoTextField.text = String(carModel.distance)
            return cell
        case .FuelType:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            cell.infoTextField.delegate = self
            cell.infoTextField.text = carModel.fuelType
            return cell
        case .Vin:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoCell", for: indexPath) as? AutoCell else {return UITableViewCell()}
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.Model )
            cell.infoTextField.delegate = self
            cell.infoTextField.text = carModel.vin
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
            self.indexText = indexPath
        case .Model:
            cell.infoTextField.becomeFirstResponder()
            self.indexText = indexPath
        case .Number:
            cell.infoTextField.becomeFirstResponder()
            self.indexText = indexPath
        case .Year:
            gotoPopover(cell: cell, model: carParametrsModel.year(), index: indexPath)
            self.indexText = indexPath
        case .Distance:
            cell.infoTextField.becomeFirstResponder()
           // cell.infoTextField.keyboardType = .numberPad
            self.indexText = indexPath
        case .FuelType:
            gotoPopover(cell: cell, model: carParametrsModel.typeFuel, index: indexPath)
            self.indexText = indexPath
        case .Vin:
            cell.infoTextField.becomeFirstResponder()
            self.indexText = indexPath
        case .none:
            break
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let indexCase = indexText?.section ?? 0
        let autoModel = AutoModel(rawValue: indexCase)
        switch autoModel {
    
        case .Item:
            self.carModel.item = textField.text ?? ""
        case .Model:
            self.carModel.model = textField.text ?? ""
        case .Number:
            self.carModel.number = textField.text ?? ""
        case .Year:
            self.carModel.year = textField.text ?? ""
        case .Distance:
            self.carModel.distance = Float(textField.text ?? "0") ?? 0
        case .FuelType:
            self.carModel.fuelType = textField.text ?? ""
        case .Vin:
            self.carModel.vin = textField.text ?? ""
        case .none:
            break
        }
        return false
    }
}

extension AddAutoViewController: UIPopoverPresentationControllerDelegate{
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func gotoPopover(cell: AutoCell, model: [String], index: IndexPath){
        
        let popVC = PopoverTableViewController()
        popVC.modalPresentationStyle = .popover
        popVC.delegate = self
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popVC.model = model
        popVC.index = index
        popOverVC?.sourceView = cell
        popOverVC?.sourceRect = CGRect(x: cell.bounds.width, y: cell.bounds.minY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        self.present(popVC, animated: true)
        
    }
    
}
extension AddAutoViewController: PopoverTableViewControllerDelegate{
    func fuelDidSelect(_ param: String, index: IndexPath) {
        if index.section == 5 {
            self.carModel.fuelType = param
        }else if index.section == 3 {
            self.carModel.year = param
        }
        tableView.reloadData()
    }
    
}


