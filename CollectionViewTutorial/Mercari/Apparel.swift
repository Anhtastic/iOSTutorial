//
//  Apparel.swift
//  Mercari
//
//  Created by Anh Doan on 6/18/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import Foundation

struct Apparel {
    
    enum SerializationError: Error {
        case missing(String)
    }
    
    internal var price: String?
    internal var name: String?
    internal var status: String?
    
    init(price: String, name: String, status: String) {
        self.price = price
        self.name = name
        self.status = status
    }
    
    init(dict: [String: Any]) throws {
        guard let name = dict["name"] as? String else {
            throw SerializationError.missing("name")
        }
        guard let price = dict["price"] as? Int else {
            throw SerializationError.missing("price")
        }
        guard let status = dict["status"] as? String else {
            throw SerializationError.missing("status")
        }
        self.name = name
        self.price = "$\(price)"
        self.status = status
    }
    
}

extension Apparel {
    
    // method to parse json in main bundle.
    static func downloadJson() -> [Apparel] {
        var apparels = [Apparel]()
        
        let jsonPath = Bundle.main.path(forResource: "all", ofType: "json")
        let jsonURL = URL(fileURLWithPath: jsonPath!)
        let jsonData = try? Data(contentsOf: jsonURL)
        if let jsonDict = ParseJsonManager.parseJSONData(data: jsonData) {
            guard let data = jsonDict["data"] as? [[String: Any]] else {
                print("data does not exist in json file")
                return apparels
            }
            for d in data {
                do {
                    let apparel = try Apparel(dict: d)
                    apparels.append(apparel)
                } catch {
                    print(error)
                }
            }
            
        }
        return apparels
    }
    
    // method to request json from web.
    static func downloadJsonFromAPI(urlString: String) -> [Apparel] {
        var apparels = [Apparel]()
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            let jsonDict = ParseJsonManager.parseJSONData(data: data)
            guard let data = jsonDict?["data"] as? [[String: Any]] else {
                print("data does not exist in json file")
                return
            }
            for d in data {
                do {
                    let apparel = try Apparel(dict: d)
                    apparels.append(apparel)
                } catch {
                    print(error)
                }
            }
        }.resume()
        return apparels
    }
}
























