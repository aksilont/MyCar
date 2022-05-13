//
//  UIHostingControllerCustom.swift
//  MyCar
//
//  Created by Aksilont on 12.05.2022.
//

import UIKit
import SwiftUI

class UIHostingViewControllerCustom<Content>: UIHostingController<Content> where Content: View {
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
//        let _ = rootView.navigationBarBackButtonHidden(true)
    }
}
