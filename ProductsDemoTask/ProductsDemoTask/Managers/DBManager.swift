//
//  DBManager.swift
//  ProductsDemoTask
//
//  Created by Ahmed Hafez on 12/18/22.
//


import UIKit
import CoreData

class DBManager {
    
    static let shared = DBManager()
    
//    let appDelegat = UIApplication.shared.delegate as! AppDelegate
    
    
      func saveProduct(product: Product) {
        let appDelegat = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegat.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Products", in: context)
        let newProduct = NSManagedObject(entity: entity!, insertInto: context)
        newProduct.setValue("\(product.toJSONString())", forKey: "product")
        newProduct.setValue(product.id ?? 0, forKey: "id")
        
        do {
            try context.save()
            print("product save succesfully")
        } catch {
            print("cant save product \(error.localizedDescription)")
        }
    }
    
    func saveProducts(products: [Product]) {
        for product in products {
            saveProduct(product: product)
        }
    }
    
    func fetchLocalProducts() -> [Product] {
        let appDelegat = UIApplication.shared.delegate as! AppDelegate
        var productsArr: [Product] = []
        let context = appDelegat.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for element in result {
                let id = (element as AnyObject).value(forKey: "id") as? Int ?? 0
                let productString = (element as AnyObject).value(forKey: "product") as? String ?? ""
                if let product: Product = instantiate(jsonString: productString) {
                    productsArr.append(product)
                }
            }
        } catch {
            print("error fetch local products \(error.localizedDescription)")
        }
        
        return productsArr
    }
    
}
