//
//  prodctsListVC.swift
//  ProductsDemoTask
//
//  Created by Ahmed Hafez on 12/16/22.
//

import UIKit

class prodctsListVC: UIViewController {

    @IBOutlet weak var productsCV: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProductsCollectionView()
        
    }
    
    
    func setupProductsCollectionView() {
        productsCV.dataSource = self
        productsCV.delegate = self
        productsCV.register(UINib(nibName: "ProductCVC", bundle: nil), forCellWithReuseIdentifier: "ProductCVC")
        if let layout = productsCV?.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }

    }

    
}

//MARK: -> collection view methods
extension prodctsListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCVC", for: indexPath) as! ProductCVC
        cell.productPriceLabel.text = "12"
        
        return cell
    }
    
    
}

//MARK: -> Pinterest layout delegate

extension prodctsListVC: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
}
