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
    var modelByMark:[String] = []
    var marka = ""
    var model = ""
    
    var selectText: String = ""
    var itemArray = [String]()
    var fullArray = [String]()
    
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
    
    let infoTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.textAlignment = .center
        textField.becomeFirstResponder()
        textField.placeholder = "начните ввод марки авто"
        textField.backgroundColor = .black
        textField.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearsOnBeginEditing = true
        return textField
    }()
    
    let lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .white
        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationAttributes()
        setupElements()
        setupConstraints()
        
        carPicker.dataSource = self
        carPicker.delegate = self
        infoTextField.delegate = self
        
        itemArray = carsDecodable.itemArray
        fullArray = carsDecodable.itemArray
       
    }
    func setupNavigationAttributes(){
        let titleGarage = "Марка и модель Авто"
        navigationItem.title = titleGarage
    }
    func setupElements() {
        view.addSubview(autoLabel)
        view.addSubview(carPicker)
        view.addSubview(infoTextField)
        view.addSubview(lineView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            infoTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            infoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoTextField.heightAnchor.constraint(equalToConstant: 40),
            lineView.topAnchor.constraint(equalTo: infoTextField.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            autoLabel.topAnchor.constraint(equalTo: infoTextField.bottomAnchor, constant: 10),
            autoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            autoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            carPicker.topAnchor.constraint(equalTo: infoTextField.bottomAnchor, constant: 10),
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
      
        case 0: return itemArray.count
        case 1: return modelByMark.count
        default:
            return 0
        }
    }
    
}
extension AddItemAndModelViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     
        if component == 0 {
            let item = itemArray.first
            modelByMark = carsDecodable.getModel(item: item ?? "")
            let nameItem = itemArray[row]
            self.marka = item ?? ""
            autoLabel.text = "\(self.marka) \(self.model)"
            return nameItem
        } else {
            var models = [""]
            models = modelByMark
            let nameModel = models[row]
            self.model = models.first ?? ""
            autoLabel.text = "\(self.marka) \(self.model)"
            return nameModel
        }
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
        if component == 0 {
            let marka = itemArray[row]
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
extension AddItemAndModelViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        selectText = textField.text ?? ""
        self.itemArray = fullArray.filter { $0.hasPrefix(selectText) }
        self.carPicker.reloadComponent(0)
        let item = itemArray.first
        modelByMark = carsDecodable.getModel(item: item ?? "")
        self.carPicker.reloadComponent(1)
        self.marka = selectText
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
