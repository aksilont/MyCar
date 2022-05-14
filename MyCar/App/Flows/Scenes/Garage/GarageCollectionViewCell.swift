//
//  GarageCollectionViewCell.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit

class GarageCollectionViewCell: UICollectionViewCell {
    
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
        label.textColor = .black
        label.text = "AUDI Q3"
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
        label.textColor = .black
        label.text = "A123AA177"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkMarkView: SSCheckMark = {
        let checkMark = SSCheckMark()
        // checkMark.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        checkMark.backgroundColor = UIColor(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        return checkMark
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewCell()
        setupElements()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewCell() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        backgroundColor = .lightGray
    }
    
    private func setupElements() {
        addSubview(autoImageView)
        addSubview(itemAutoLabel)
        addSubview(numberAutoLabel)
        addSubview(checkMarkView)
        checkMarkView.addTarget(self, action: #selector(changeState), for: .touchUpInside)
       
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            autoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            autoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            autoImageView.widthAnchor.constraint(equalToConstant: 80),
            autoImageView.heightAnchor.constraint(equalToConstant: 80),
            itemAutoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemAutoLabel.topAnchor.constraint(equalTo: autoImageView.bottomAnchor, constant: 10),
            numberAutoLabel.topAnchor.constraint(equalTo: itemAutoLabel.bottomAnchor, constant: 0),
            numberAutoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkMarkView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            checkMarkView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            checkMarkView.widthAnchor.constraint(equalToConstant: 30),
            checkMarkView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    @objc func changeState(){
        checkMarkView.checked.toggle()
    }
    
}
