//
//  LoginViewController.swift
//  MyCar
//
//  Created by Aksilont on 01.05.2022.
//

import UIKit
import Combine
import SwiftUI

class LoginViewController: UIViewController {

    @IBOutlet weak var numPadView: NumPad!
    
    @IBOutlet weak var firstDot: UIImageView!
    @IBOutlet weak var secondDot: UIImageView!
    @IBOutlet weak var thirdDot: UIImageView!
    @IBOutlet weak var fourthDot: UIImageView!
    
    private let viewModel = LoginViewModel()
    
    private var currentPin = ""
    
    private let imageDotted = UIImage(systemName: "circle")
    private let imageFilled = UIImage(systemName: "circle.fill")
    
    private var subscriptions: Set<AnyCancellable> = []
        
    private var observer: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        observer = navigationController?.observe(
//            \.navigationBar.isHidden,
//             options: [.new]
//        ) { [weak self] _, change in
//            guard change.newValue == false else { return }
//            self?.navigationController?.navigationBar.isHidden = true
//        }
        
        setupUI()
    }
    
    
    private func setupUI() {
        if !viewModel.hasPinCode() {
            let mainView = UIHostingViewControllerCustom(rootView: MainView())
            mainView.modalPresentationStyle = .fullScreen
            present(mainView, animated: false)
//            navigationController?.setNavigationBarHidden(true, animated: false)
//            navigationController?.pushViewController(mainView, animated: false)
//            mainView.navigationController?.isNavigationBarHidden = true
//            navigationController?.pushViewController(MainTabController(), animated: false)
        }
        
        numPadView.subject.sink { [unowned self] value in
            switch value {
            case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero:
                if currentPin.count < 4 {
                    currentPin += value.rawValue
                }
                else {
                    return
                }
                checkInputPin()
            case .faceID:
                break
            case .delete:
                if currentPin.count > 0 {
                    currentPin.removeLast()
                    checkInputPin()
                }
            case .undefined:
                break
            }
            
        }
        .store(in: &subscriptions)
    }
    
    private func checkInputPin() {
        switch currentPin.count {
        case 1:
            firstDot.image = imageFilled
            secondDot.image = imageDotted
            thirdDot.image = imageDotted
            fourthDot.image = imageDotted
        case 2:
            firstDot.image = imageFilled
            secondDot.image = imageFilled
            thirdDot.image = imageDotted
            fourthDot.image = imageDotted
        case 3:
            firstDot.image = imageFilled
            secondDot.image = imageFilled
            thirdDot.image = imageFilled
            fourthDot.image = imageDotted
        case 4:
            firstDot.image = imageFilled
            secondDot.image = imageFilled
            thirdDot.image = imageFilled
            fourthDot.image = imageFilled
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [unowned self] in
                checkPin()
            }
        default:
            resetAllDots()
        }
    }
    
    private func resetAllDots() {
        firstDot.image = imageDotted
        secondDot.image = imageDotted
        thirdDot.image = imageDotted
        fourthDot.image = imageDotted
    }
    
    private func checkPin() {
        resetAllDots()
        if viewModel.checkPin(currentPin) {
            let mainView = UIHostingController(rootView: MainView())
            mainView.modalPresentationStyle = .fullScreen
            present(mainView, animated: false)
        } else {
            currentPin = ""
        }
    }
    
}
