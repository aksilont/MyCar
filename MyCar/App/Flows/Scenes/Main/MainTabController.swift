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
        title = "Мой авто"
        
        tabBar.backgroundImage = UIImage()
        // Blur effect for tabBar
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = tabBar.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.addSubview(blurEffectView)
        
        let homeViewModel = HomeViewModel()
//        let homeVC = HomeViewController(viewModel: homeViewModel)
        let homeVC = UIHostingViewControllerCustom(rootView: HomeView(viewModel: homeViewModel))
        homeVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        
        let statisticsView = StatisticsView()
        let statisticsVC = UIHostingViewControllerCustom(rootView: statisticsView)
        statisticsVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "waveform.path.ecg.rectangle"),
                                         selectedImage: UIImage(systemName: "waveform.path.ecg.rectangle.fill"))
        
        let settingsView = SettingsView()
        let settingsVC = UIHostingViewControllerCustom(rootView: settingsView)
        settingsVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "ellipsis"),
                                         selectedImage: UIImage(systemName: "ellipsis"))
        
        tabBar.tintColor = UIColor.systemTeal
        viewControllers = [homeVC, statisticsVC, settingsVC]
    }
}
