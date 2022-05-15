//
//  HomeViewController.swift
//  MyCar
//
//  Created by Aksilont on 06.05.2022.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    @IBOutlet weak var garageButton: UIButton!
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadData()
    }
    
    @IBAction func exitDidTap(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func garageDidTap(_ sender: UIButton) {
        let garageVC = GarageCollectionViewController()
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(garageVC, animated: true)
    }

    private func setupView() {
        let child = HomeViewHostingController(shouldShowNavigationBar: false, rootView: HomeView(viewModel: viewModel))
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            child.view.topAnchor.constraint(equalTo:  self.garageButton.bottomAnchor),
            child.view.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
