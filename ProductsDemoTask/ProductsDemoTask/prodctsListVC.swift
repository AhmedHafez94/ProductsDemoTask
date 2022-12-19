//
//  prodctsListVC.swift
//  ProductsDemoTask
//
//  Created by Ahmed Hafez on 12/16/22.
//

import UIKit
import CoreData

class prodctsListVC: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var productsCV: UICollectionView!
    
    var productsArr: [Product]? = []
    let transition = StretchAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products list"
        setupProductsCollectionView()
//        if let data = readLocalFile(forName: "productsJsonData") {
//            let productArray = parse(jsonData: data)
//            productsArr = try? data.decoded()
//            print("new test value will be printed \(productsArr)")
//        }
        
        fetchProducts()
        
        
        
    }
    
    
    func setupProductsCollectionView() {
        productsCV.dataSource = self
        productsCV.delegate = self
        productsCV.register(UINib(nibName: "ProductCVC", bundle: nil), forCellWithReuseIdentifier: "ProductCVC")
        if let layout = productsCV?.collectionViewLayout as? PinterestLayout {
          layout.delegate = self
        }

    }
    
    func showActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
        }
       
    }
    
    
    func fetchProducts () {
        showActivityIndicator()
        NetworkManager.shared.fetchProducts { [weak self] (result) in
            guard let self = self else { return }
            self.hideActivityIndicator()
            switch result {
            case .success(let products):
                print("products will be pricted \(products)")
                self.productsArr?.append(contentsOf: products)
                DispatchQueue.main.async {
                    self.productsCV.reloadData()
                }
            case .failure(let error):
                print("error happened when \(error.localizedDescription)")
            }
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
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
    func goToProductDetails(product: Product) {
        let SB = UIStoryboard(name: "Main", bundle: nil)
        let destVC = SB.instantiateViewController(identifier: "ProductDescriptionVC") as! ProductDescriptionVC
        destVC.product = product
        destVC.transitioningDelegate = self
        destVC.modalPresentationStyle = .fullScreen
        self.present(destVC, animated: true, completion: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let product = productsArr?[indexPath.row] {
            goToProductDetails(product: product)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        print("offsetY \(offsetY)")
        print("contentHeight \(contentHeight)")
        print("height \(height)")
        
        if offsetY > contentHeight - height {
            fetchProducts()
        }
    }
    
    
}

//MARK: -> Pinterest layout delegate

extension prodctsListVC: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let textHeight = heightForView(text: productsArr?[indexPath.item].productDescription ?? "", font: UIFont.systemFont(ofSize: 10), width: 100)
        return (CGFloat(productsArr?[indexPath.item].image?.height ?? 180) + textHeight)
    }
    
    
}

//MARK: -> UIViewControllerTransitioningDelegate

extension prodctsListVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            transition.presenting = true
            return transition
        }
        
        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            transition.presenting = false
            return transition
        }
}


