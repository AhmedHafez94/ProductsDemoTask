//
//  UIImage+Ext.swift
//  ProductsDemoTask
//
//  Created by Ahmed Hafez on 12/18/22.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from urlString: String) {
        
        if let image = Constants.cache.object(forKey: urlString as NSString) {
            print("image found in cache")
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {return}
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            Constants.cache
                .setObject(image, forKey: urlString as NSString)
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }
    
}
