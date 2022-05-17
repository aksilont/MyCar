//
//  HomeViewController.swift
//  MyCar
//
//  Created by Aksilont on 06.05.2022.
//

import UIKit
import SwiftUI
import Combine

class HomeViewController: UIViewController {
    
    lazy var viewModel = HomeViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubscriptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadCarData()
    }
    
    private func exitDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    private func garageDidTap() {
        let garageVC = GarageCollectionViewController()
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(garageVC, animated: true)
    }

    private func setupView() {
        let child = UIHostingViewControllerCustom(rootView: HomeView(viewModel: viewModel))
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            child.view.topAnchor.constraint(equalTo:  self.view.safeAreaLayoutGuide.topAnchor),
            child.view.bottomAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupSubscriptions() {
        viewModel.garageButoonSubject.sink {
            self.garageDidTap()
        }
        .store(in: &subscriptions)
        
        viewModel.exitButtonSubject.sink {
            self.exitDidTap()
        }
        .store(in: &subscriptions)
    }
}
