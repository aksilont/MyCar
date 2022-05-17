//
//  AddItemAndModelViewController.swift
//  MyCar
//
//  Created by Alex Larin on 16.05.2022.
//

import UIKit

class AddItemAndModelViewController: UIViewController {
    
    let carPicker: UIPickerView = {
        let carPicker = UIPickerView()
        carPicker.translatesAutoresizingMaskIntoConstraints = false
        return carPicker
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationAttributes()
        setupElements()
        setupConstraints()
        carPicker.dataSource = self
        carPicker.delegate = self
        
    }
    func setupNavigationAttributes(){
        let titleGarage = "Марка и модель Авто"
        navigationItem.title = titleGarage
    }
    func setupElements() {
        view.addSubview(carPicker)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            carPicker.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            carPicker.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2),
            carPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            carPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AddItemAndModelViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    
}
extension AddItemAndModelViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Com \(component) Row \(row)"
    }
    
}
