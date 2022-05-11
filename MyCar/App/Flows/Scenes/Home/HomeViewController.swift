//
//  HomeViewController.swift
//  MyCar
//
//  Created by Aksilont on 06.05.2022.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func exitDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}
