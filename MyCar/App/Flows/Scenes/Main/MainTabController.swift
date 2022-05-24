//
//  MainTabController.swift
//  MyCar
//
//  Created by Aksilont on 01.05.2022.
//

import SwiftUI

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        let homeViewModel = HomeViewModel()
        let homeVC = HomeViewController(viewModel: homeViewModel)
        homeVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        
        let statisticsVC = StaticticsViewController()
        statisticsVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "waveform.path.ecg.rectangle"),
                                         selectedImage: UIImage(systemName: "waveform.path.ecg.rectangle.fill"))
        
        let settingsView = SettingsView()
        let settingsVC = UIHostingViewControllerCustom(rootView: settingsView)
        settingsVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "ellipsis"),
                                         selectedImage: UIImage(systemName: "ellipsis"))
        
        tabBar.tintColor = UIColor.systemTeal
        tabBar.unselectedItemTintColor = UIColor.white
        viewControllers = [homeVC, statisticsVC, settingsVC]
    }
}
