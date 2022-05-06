//
//  GarageCollectionViewCell.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit

class GarageCollectionViewCell: UICollectionViewCell {
    static let reuseId = "GarageCell"

    let autoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "car2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let itemAutoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "AUDI Q3"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let modelAutoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tickmark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let numberAutoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "A123AA177"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let checkMarkView: SSCheckMark = {
        let checkMark = SSCheckMark()
        checkMark.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        return checkMark
        
    }()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        
        addSubview(autoImageView)
        addSubview(itemAutoLabel)
        addSubview(modelAutoLabel)
        addSubview(numberAutoLabel)
        addSubview(checkMarkView)
        backgroundColor = .lightGray
        
        // autoImageView constraints
        autoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        autoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        autoImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        autoImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        itemAutoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        itemAutoLabel.topAnchor.constraint(equalTo: autoImageView.bottomAnchor, constant: 10).isActive = true
        
        numberAutoLabel.topAnchor.constraint(equalTo: itemAutoLabel.bottomAnchor, constant: 0).isActive = true
        numberAutoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        checkMarkView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        checkMarkView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        checkMarkView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        checkMarkView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkMarkView.addTarget(self, action: #selector(changeState), for: .touchUpInside)
        
  
    }
    @objc func changeState(){
        checkMarkView.checked.toggle()
        
       
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
