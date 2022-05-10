//
//  AutoCell.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit

class AutoCell: UITableViewCell {
    static let reuseID = "AutoCell"
   
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        
        return iv
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
        textField.textColor = .white
        textField.textAlignment = .center
        textField.autocapitalizationType = .allCharacters
        textField.backgroundColor = .black
        textField.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(iconImageView)
        addSubview(autoLabel)
        contentView.addSubview(infoTextField)
        infoTextField.returnKeyType = UIReturnKeyType.done
        infoTextField.clearsOnBeginEditing = true
        
        backgroundColor = .clear
        // autoLabel constraints
        autoLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        autoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        
        // infoTextField constrains
        infoTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        infoTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        infoTextField.widthAnchor.constraint(equalToConstant:(frame.size.width / 2.5 )).isActive = true
        infoTextField.leadingAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // iconImageView constraints
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(greaterThanOrEqualTo: infoTextField.trailingAnchor, constant: 0).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }
    
}
