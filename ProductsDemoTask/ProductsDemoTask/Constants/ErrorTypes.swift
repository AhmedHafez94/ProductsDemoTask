//
//  ErrorTypes.swift
//  ProductsDemoTask
//
//  Created by Ahmed Hafez on 12/18/22.
//

import Foundation


enum NetworkError: String, Error {
    
    case invalidUrl = "The url is corrupted please connect with the backend"
    case unabletToComplete = "something went wrong please try again later"
    case invalidData = "invalid data please try again later"
    case invalidResponse = "invalid response from the server, please try again"
    
    
}
