//
//  ProductCVC.swift
//  ProductsDemoTask
//
//  Created by Ahmed Hafez on 12/16/22.
//

import UIKit

class ProductCVC: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        
    }
    
    
    func configure(product: Product) {
        productDescriptionLabel.text = product.productDescription ?? ""
        productPriceLabel.text = "\(product.price ?? 0)"
        productImageView.downloadImage(from: product.image?.url ?? "")
    }

}
