//
//  prodctsListVC.swift
//  ProductsDemoTask
//
//  Created by Ahmed Hafez on 12/16/22.
//

import UIKit

class prodctsListVC: UIViewController {

    @IBOutlet weak var productsCV: UICollectionView!
    
    var productsArr: [Product]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProductsCollectionView()
        if let data = readLocalFile(forName: "productsJsonData") {
            let productArray = parse(jsonData: data)
            productsArr = try? data.decoded()
            print("new test value will be printed \(productsArr)")
        }
        
        
    }
    
    
    func setupProductsCollectionView() {
        productsCV.dataSource = self
        productsCV.delegate = self
        productsCV.register(UINib(nibName: "ProductCVC", bundle: nil), forCellWithReuseIdentifier: "ProductCVC")
        if let layout = productsCV?.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }

    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) -> [Product] {
        do {
            let decodedData = try JSONDecoder().decode([Product].self,
                                                       from: jsonData)
            
            print("decodedData: ")
            print("===================================")
            print(decodedData)
            return decodedData
        } catch {
            print("decode error")
            return []
        }
    }
    
  
    
}

//MARK: -> collection view methods
extension prodctsListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCVC", for: indexPath) as! ProductCVC
        cell.configure(product: productsArr![indexPath.row])
        
        return cell
    }
    
    
}

//MARK: -> Pinterest layout delegate

extension prodctsListVC: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(productsArr?[indexPath.item].image?.height ?? 180.0)
    }
    
    
}


extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
