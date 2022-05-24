//
//  NumPad.swift
//  MyCar
//
//  Created by Aksilont on 05.05.2022.
//

import UIKit
import Combine

struct rowOfDigits {
    let values: [PinState]
    init(_ values: PinState...) {
        self.values = values
    }
}

@IBDesignable
class NumPad: UIView {
    
    let subject = PassthroughSubject<PinState, Never>()
    
    private let alphaComponent = 0.8
    private let buttonColor = UIColor.systemBlue
    
    private let digitsData: [rowOfDigits] = [
        rowOfDigits(.one, .two, .three),
        rowOfDigits(.four, .five, .six),
        rowOfDigits(.seven, .eight, .nine),
        rowOfDigits(.faceID, .zero, .delete)
    ]
    
    private var numberOfRows: CGFloat {
        CGFloat(digitsData.count)
    }
    
    private var digitsInRow: CGFloat {
        var maxDigits = 0
        for row in digitsData {
            maxDigits = maxDigits >= row.values.count ? maxDigits : row.values.count
        }
        return CGFloat(maxDigits)
    }
    
    private var sizeOfButton: CGFloat {
        (bounds.width + bounds.width) / (2 * (digitsInRow + 1))
    }
    
    private var sizeOfFont: CGFloat {
        sizeOfButton / 2
    }
    
    private var sizeOfImage: CGFloat {
        sizeOfFont
    }
    
    private var inset: CGFloat {
        sizeOfButton / 1.3
    }
    
    private lazy var spacingRows = {
        (bounds.height - numberOfRows * sizeOfButton - inset) / (numberOfRows - 1)
    }()
    
    private lazy var spacingDigits = {
        (bounds.width - digitsInRow * sizeOfButton - inset) / (digitsInRow - 1)
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = spacingRows
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        for row in digitsData {
            stackView.addArrangedSubview(makeStackRow(row.values))
        }
        addSubview(stackView)
        return stackView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func makeButton(pinState: PinState) -> PinButton {
        var image: UIImage?
        
        let button = PinButton(pinState: pinState)
        button.widthAnchor.constraint(equalToConstant: sizeOfButton).isActive = true
        button.heightAnchor.constraint(equalToConstant: sizeOfButton).isActive = true
        button.setTitleColor(buttonColor.withAlphaComponent(alphaComponent), for: .normal)
        button.setTitleColor(buttonColor, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: sizeOfFont, weight: .light)
        
        switch pinState {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero:
            button.setTitle(pinState.rawValue, for: .normal)
        case .faceID:
            image = UIImage(systemName: "faceid")?
                .imageResized(to: CGSize(width: sizeOfImage, height: sizeOfImage / 1.1))
        case .delete:
            image = UIImage(systemName: "delete.left")?
                .imageResized(to: CGSize(width: sizeOfImage, height: sizeOfImage / 1.3))
        case .undefined:
            button.setTitle(pinState.rawValue, for: .normal)
            return button
        }
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        guard let image = image else { return button }
        button.setImage(image.withTintColor(buttonColor.withAlphaComponent(alphaComponent)),
                        for: .normal)
        button.setImage(image.withTintColor(buttonColor),
                        for: .highlighted)
        
        return button
    }
    
    private func makeStackRow(_ symbols: [PinState]) -> UIStackView {
        let stackViewRow = UIStackView()
        stackViewRow.spacing = spacingDigits
        stackViewRow.axis = .horizontal
        stackViewRow.alignment = .center
        stackViewRow.distribution = .fillEqually
        for item in symbols {
            let button = makeButton(pinState: item)
            stackViewRow.addArrangedSubview(button)
        }
        return stackViewRow
    }
    
    @objc func buttonTapped(_ sender: PinButton) {
        subject.send(sender.pinState)
    }

}
