//
//  AddItemAndModelViewController.swift
//  MyCar
//
//  Created by Alex Larin on 16.05.2022.
//

import UIKit

protocol AddItemAndModelDelegate: AnyObject {
    func itemAndModelDidSelect(item: String, model: String)
    
}

class AddItemAndModelViewController: UIViewController {
    weak var delegate: AddItemAndModelDelegate?

    let carsDecodable = CarDecodable()
    var carsModels = ["key":["value"]]
    var modelByMark:[String] = []
    var marka = ""
    var model = ""
    
    let carPicker: UIPickerView = {
        let carPicker = UIPickerView()
        carPicker.translatesAutoresizingMaskIntoConstraints = false
        return carPicker
    }()
    
    let autoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationAttributes()
        setupElements()
        setupConstraints()
        carPicker.dataSource = self
        carPicker.delegate = self
        carsModels =  carsDecodable.load().list
    }
    func setupNavigationAttributes(){
        let titleGarage = "Марка и модель Авто"
        navigationItem.title = titleGarage
    }
    func setupElements() {
        view.addSubview(autoLabel)
        view.addSubview(carPicker)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            autoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            autoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            autoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            carPicker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            carPicker.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2),
            carPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            carPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
extension AddItemAndModelViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
      
        case 0: return carsDecodable.itemArray.count
        case 1: return modelByMark.count
        default:
            return 0
        }
    }
    
}
extension AddItemAndModelViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     
        if component == 0 {
            let item = carsDecodable.itemArray.first
            modelByMark = carsDecodable.getModel(item: item ?? "")
            let nameItem = carsDecodable.itemArray[row]
            return nameItem
        } else {
            var models = [""]
            models = modelByMark
            let nameModel = models[row]
            return nameModel
        }
        
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
        if component == 0 {
            let marka = carsDecodable.itemArray[row]
            self.marka = marka
            modelByMark = carsDecodable.getModel(item: marka)
            self.model = modelByMark[0]
            autoLabel.text = "\(self.marka) \(self.model)"
            delegate?.itemAndModelDidSelect(item: self.marka, model: self.model)
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
        } else {
            let model = modelByMark[row]
            self.model = model
            autoLabel.text = "\(self.marka) \(self.model)"
            delegate?.itemAndModelDidSelect(item: self.marka, model: self.model)
           
        }
    }
    
}
