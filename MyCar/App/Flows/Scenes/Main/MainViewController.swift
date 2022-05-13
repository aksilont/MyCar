//
//  MainViewController.swift
//  MyCar
//
//  Created by Aksilont on 01.05.2022.
//

import UIKit
import SwiftUI

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "house"),
                                         selectedImage: UIImage(systemName: "house.fill"))
        
        let statisticsVC = StaticticsViewController()
        statisticsVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "waveform.path.ecg.rectangle"),
                                         selectedImage: UIImage(systemName: "waveform.path.ecg.rectangle.fill"))
        
        let documentsVC = DocumentsViewController()
        documentsVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "doc.on.doc"),
                                         selectedImage: UIImage(systemName: "doc.on.doc.fill"))
        
        let eventsVC = EventsViewController()
        eventsVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "calendar"),
                                         selectedImage: UIImage(systemName: "calendar"))
        
        let settingsView = SettingsView()
        let settingsVC = UIHostingViewControllerCustom(rootView: settingsView)
        settingsVC.tabBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "ellipsis"),
                                         selectedImage: UIImage(systemName: "ellipsis"))
        
        tabBar.tintColor = UIColor.systemTeal
        tabBar.unselectedItemTintColor = UIColor.white
        viewControllers = [homeVC, statisticsVC, documentsVC, eventsVC, settingsVC]
    }
}
