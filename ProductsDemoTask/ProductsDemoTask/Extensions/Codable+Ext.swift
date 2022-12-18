//
//  Codable+Ext.swift
//  ProductsDemoTask
//
//  Created by Ahmed Hafez on 12/18/22.
//

import Foundation


extension Encodable {
    func toJSONString() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
    
}

func instantiate<T: Decodable>(jsonString: String) -> T? {
    return try? JSONDecoder().decode(T.self, from: jsonString.data(using: .utf8)!)
}
