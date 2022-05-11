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
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func exitDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func garageDidTap(_ sender: UIButton) {
        let garageVC = GarageCollectionViewController()
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(garageVC, animated: true)
    }

}
