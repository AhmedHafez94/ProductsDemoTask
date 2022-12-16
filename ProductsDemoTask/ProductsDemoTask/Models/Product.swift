//
//  Product.swift
//  ProductsDemoTask
//
//  Created by Ahmed Hafez on 12/16/22.
//

import Foundation


struct Product: Codable {
    var id: Int?
    var productDescription: String?
    var price: Float?
    var image: ProductImage?
    
}


struct ProductImage: Codable {
    var width: Float?
    var height: Float?
    var url: String?
}
