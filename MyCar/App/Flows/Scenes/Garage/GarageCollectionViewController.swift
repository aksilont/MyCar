//
//  GarageCollectionViewController.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit

protocol CellMarker {
    func loadAuto()
}

class GarageCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
       self.collectionView!.register(GarageCollectionViewCell.self, forCellWithReuseIdentifier: "GarageCell")
       self.collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .black
       // navigationItem.title = "Гараж"
       let titleGarage = "Гараж"
      
        let rightButton = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(addAuto))
        navigationItem.rightBarButtonItem = rightButton
       
        navigationItem.title = titleGarage
        
       
    }
    @objc func addAuto(){
       let vc = AddAutoViewController(nibName: "AddAutoViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(20)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 40, bottom: 0, trailing: 40)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GarageCollectionViewCell.reuseId, for: indexPath) as! GarageCollectionViewCell
        cell.checkMarkView.checked.toggle()
        
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
       
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: view.frame.width, height: view.frame.height)
        }
    init() {
            super.init(collectionViewLayout: UICollectionViewFlowLayout())
        }
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
