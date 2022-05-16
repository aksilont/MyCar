//
//  AddItemAndModelViewController.swift
//  MyCar
//
//  Created by Alex Larin on 16.05.2022.
//

import UIKit

class AddItemAndModelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationAttributes()
        setupElements()
        setupConstraints()
        
    }
    func setupNavigationAttributes(){
        let titleGarage = "Марка и модель Авто"
        navigationItem.title = titleGarage
    }
    func setupElements() {
        
    }
    
    func setupConstraints() {
        
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
