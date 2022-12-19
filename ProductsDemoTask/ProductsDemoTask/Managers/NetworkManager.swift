//
//  NetworkManager.swift
//  ProductsDemoTask
//
//  Created by Ahmed Hafez on 12/18/22.
//

import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
//    let cache = NSCache<NSString, UIImage>()
    
   private init() { }
    
    func fetchProducts(firstFetch: Bool, completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        
        let endPoint = Constants.baseUrl
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUrl))
            // present alert to show error
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode([Product].self, from: data)
                completion(.success(products))
                if firstFetch == true {
//                    DBManager
                }
                DBManager.shared.saveProducts(products: products)
            } catch {
                completion(.failure(.unabletToComplete))
            }
            
        }
        
        task.resume()
        
    }
}
