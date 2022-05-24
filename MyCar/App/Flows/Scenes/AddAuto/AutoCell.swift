//
//  AutoCell.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit

class AutoCell: UITableViewCell {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let autoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Кастомный текст"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    let infoTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .white
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.backgroundColor = .black
        textField.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearsOnBeginEditing = true
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupElements()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        addSubview(iconImageView)
        addSubview(autoLabel)
        contentView.addSubview(infoTextField)
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            autoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            autoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            infoTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoTextField.heightAnchor.constraint(equalToConstant: 60),
            infoTextField.widthAnchor.constraint(equalToConstant:(frame.size.width / 2.5 )),
            infoTextField.leadingAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.leadingAnchor.constraint(greaterThanOrEqualTo: infoTextField.trailingAnchor, constant: 0),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(with state: AutoModel?, carModel: CarModel) {
        guard let state = state else { return }
        switch state {
            
        case .item:
            infoTextField.text = carModel.item
        case .model:
            infoTextField.text = carModel.model
        case .number:
            infoTextField.text = carModel.number
        case .year:
            infoTextField.text = carModel.year
        case .distance:
            infoTextField.keyboardType = .numbersAndPunctuation
            infoTextField.returnKeyType = .done
            infoTextField.text = String(carModel.distance)
        case .fuelType:
            infoTextField.text = carModel.fuelType
        case .vin:
            infoTextField.text = carModel.vin
        }
        
    }
    
}
