//
//  HomeViewHostingController.swift
//  MyCar
//
//  Created by Denis Kuzmin on 15.05.2022.
//

import Foundation
import SwiftUI

class HomeViewHostingController<Content>: UIHostingController<AnyView> where Content : View {
    public init(shouldShowNavigationBar: Bool, rootView: Content) {
        super.init(rootView: AnyView(rootView.navigationBarHidden(!shouldShowNavigationBar)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
      }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
