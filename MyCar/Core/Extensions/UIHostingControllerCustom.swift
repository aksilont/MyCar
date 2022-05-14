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
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
