//
//  ProductDescriptionVC.swift
//  ProductsDemoTask
//
//  Created by Ahmed Hafez on 12/19/22.
//

import UIKit

class ProductDescriptionVC: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    var product: Product?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProduct()
       
    }
    

    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupProduct() {
        productDescriptionLabel.text = product?.productDescription ?? ""
        productPriceLabel.text = "\(product?.price ?? 0)"
        productImageView.downloadImage(from: product?.image?.url ?? "")
    }
    

}
