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

class AddAutoViewController: UIViewController {
    weak var delegate: AddAutoViewControllerDelegate?
    var carModel = CarModel(item: "", model: "", number: "", year: "", distance: 0, vin: "", activFlag: false, fuelType: "")
    let carRepository = CarRepository()
    let carParametrsModel = CarParametrsModel()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(registerClass: AutoCell.self)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.rowHeight = 60
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let readyButton: UIButton = {
        let button = UIButton()
        button.sizeToFit()
        button.backgroundColor = UIColor(red: 54/255, green: 155/255, blue: 161/255, alpha: 1)
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
        setupElements()
        setupConstraints()
    }
    
    private func setupElements() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.addSubview(readyButton)
        readyButton.addTarget(self, action: #selector(touchReady), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: view.frame.size.height - 50 ),
            readyButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0),
            readyButton.heightAnchor.constraint(equalToConstant: 40),
            readyButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 1.5),
            readyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    func setupNavigationAttributes(){
        self.title = "Добавить авто"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc func touchReady(){
        if carModel.item != "" && carModel.number != "" {
            let cars = carRepository.fetchCars()
            if cars.isEmpty {
                carModel.activFlag = true
            }
            carRepository.saveCar(carModel: carModel)
            delegate?.appendAuto(carModel)
            self.navigationController?.popViewController(animated: true)
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
            
        case .item, .model, .number, .year, .distance, .fuelType, .vin:
            let cell: AutoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cellContent(cell: cell, autoModel: autoModel ?? AutoModel.item )
            cell.configure(with: autoModel, carModel: carModel)
            cell.infoTextField.delegate = self
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
        guard let cell = tableView.cellForRow(at: indexPath) as? AutoCell else { return }
        let indexCase = indexPath.section
        let autoModel = AutoModel(rawValue: indexCase)
        switch autoModel {
            
        case .item:
            gotoAddItemAndModel()
        case .model, .number, .distance, .vin:
            cell.infoTextField.becomeFirstResponder()
        case .year:
            gotoPopover(cell: cell, model: carParametrsModel.year(), index: indexPath)
        case .fuelType:
            gotoPopover(cell: cell, model: carParametrsModel.typeFuel, index: indexPath)
        case .none:
            break
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
        let indexCase = index.section
        let autoModel = AutoModel(rawValue: indexCase)
        switch autoModel {
        case .item:
            break
        case .model, .number, .distance, .vin:
           break
        case .year:
            self.carModel.year = param
        case .fuelType:
            self.carModel.fuelType = param
        case .none:
            break
        }
        tableView.reloadData()
    }
}

extension AddAutoViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let center: CGPoint = textField.center
        guard let rootViewPoint: CGPoint = textField.superview?.convert(center, to: tableView),
              let indexPath: IndexPath = tableView.indexPathForRow(at: rootViewPoint) else { return }
        let autoModel = AutoModel(rawValue: indexPath.section)
        switch autoModel {
        case .item:
            self.carModel.item = textField.text ?? ""
        case .model:
            self.carModel.model = textField.text ?? ""
        case .number:
            self.carModel.number = textField.text ?? ""
        case .year:
            self.carModel.year = textField.text ?? ""
        case .distance:
            self.carModel.distance = Float(textField.text ?? "") ?? 0
        case .fuelType:
            self.carModel.fuelType = textField.text ?? ""
        case .vin:
            self.carModel.vin = textField.text ?? ""
        case .none:
            break
        }
    }
}

extension AddAutoViewController {
    func gotoAddItemAndModel() {
        let vc = AddItemAndModelViewController(nibName: "AddItemAndModelViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

