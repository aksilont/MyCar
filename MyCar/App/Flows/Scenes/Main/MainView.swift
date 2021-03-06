//
//  MainView.swift
//  MyCar
//
//  Created by Aksilont on 05.06.2022.
//

import SwiftUI

struct MainView: View {
    
//    init() {
//        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.primary)
//        UITabBar.appearance().barTintColor = .systemTeal
//        UITabBar.appearance().backgroundColor = .systemTeal
//    }
    
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Image(systemName: "house")
                }
            StatisticsView()
                .tabItem {
                    Image(systemName: "waveform.path.ecg.rectangle")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "ellipsis")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
