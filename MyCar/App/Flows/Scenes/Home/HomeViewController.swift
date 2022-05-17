//
//  HomeViewController.swift
//  MyCar
//
//  Created by Aksilont on 06.05.2022.
//

import UIKit
import SwiftUI
import Combine

class HomeViewController: UIHostingController<HomeView> {
    
    var viewModel: HomeViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: HomeViewModel) {
        let homeView = HomeView(viewModel: viewModel)
        self.viewModel = viewModel
        super.init(rootView: homeView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubscriptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        viewModel.loadCarData()
    }
    
    private func garageDidTap() {
        let garageVC = GarageCollectionViewController()
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(garageVC, animated: true)
    }
    
    private func setupSubscriptions() {
        viewModel.garageButtonSubject.sink {
            self.garageDidTap()
        }
        .store(in: &subscriptions)
    }
}
