//
//  StartViewController.swift
//  MyCar
//
//  Created by Aksilont on 28.04.2022.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: false)
    }


}

