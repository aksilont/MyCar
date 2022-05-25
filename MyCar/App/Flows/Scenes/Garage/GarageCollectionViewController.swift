//
//  GarageCollectionViewController.swift
//  MyCar
//
//  Created by Alex Larin on 06.05.2022.
//

import UIKit

protocol CheckMarkerDelegate {
    func setFlag(indexPath: IndexPath)
    func showAlert(_: GarageCollectionViewCell)
    func showDeleteIndex(indexPath: IndexPath)
}

class GarageCollectionViewController: UICollectionViewController {
    var cars:[CarModel] = []
    let carRepository = CarRepository()
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(registerClass: GarageCollectionViewCell.self)
        self.collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .black
        setupNavigationAttributes()
      //  carRepository.deleteAllCars()
        getCarsFromCoreData()
    }
    
    func setupNavigationAttributes(){
        let titleGarage = "Гараж"
        let rightButton = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(addAuto))
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.title = titleGarage
    }
    
    func getCarsFromCoreData() {
        let carsFromCoreData = carRepository.fetchCars()
        cars = carRepository.convertModel(coreDataModel: carsFromCoreData)
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
    
    @objc func addAuto(){
        let vc = AddAutoViewController(nibName: "AddAutoViewController", bundle: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cars.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GarageCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.itemAutoLabel.text = cars[indexPath.row].item
        cell.numberAutoLabel.text = cars[indexPath.row].number
        cell.checkMarkView.checked = cars[indexPath.row].activFlag
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        gotoCarInfo(index: indexPath)
        
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

extension GarageCollectionViewController: AddAutoViewControllerDelegate {
    func appendAuto(_ auto: CarModel) {
        let carsFromCoreData = carRepository.fetchCars()
        cars = carRepository.convertModel(coreDataModel: carsFromCoreData)
        collectionView.reloadData()
        
    }
}

extension GarageCollectionViewController: CheckMarkerDelegate {
    
    func setFlag(indexPath: IndexPath) {
        self.indexPath = indexPath
        for index in 0 ..< cars.count {
            if index == indexPath.row {
                if cars[index].activFlag == false {
                    cars[index].activFlag = true
                    carRepository.updateFlag(carModel: cars[index])
                }
                
            } else {
                cars[index].activFlag = false
                carRepository.updateFlag(carModel: cars[index])
            }
            collectionView.reloadData()
        }
    }
    
    func showDeleteIndex(indexPath: IndexPath) {
        self.indexPath = indexPath
    }
   
    func showAlert(_: GarageCollectionViewCell) {
       showAction()
    }
    
    func showAction() {
        let alertController = UIAlertController(title: "", message: "Вы уверены, что хотите удалить этот авто?", preferredStyle: .actionSheet)
       
        let okButton = UIAlertAction(title: "Удалить", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            let number = self.cars[self.indexPath?.row ?? 0].number
            self.carRepository.deleteCar(number: number)

            let cars = self.carRepository.fetchCars()
            self.cars = self.carRepository.convertModel(coreDataModel:cars)
            self.collectionView.reloadData()
        })
      
        let deleteButton = UIAlertAction(title: "Назад", style: .destructive, handler: { (action) -> Void in
            print("Delete button tapped")
        })

        alertController.addAction(okButton)
        alertController.addAction(deleteButton)

        self.present(alertController, animated: true, completion: nil)
    }
}
extension GarageCollectionViewController {
    func gotoCarInfo(index: IndexPath) {
    let vc = AddAutoViewController(nibName: "AddAutoViewController", bundle: nil)
        vc.delegate = self
        vc.carModel = cars[index.row]
        vc.status = .correct
    self.navigationController?.pushViewController(vc, animated: true)
    }
}
