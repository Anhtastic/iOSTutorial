//
//  NetworkRequest.swift
//  Meow Fest
//
//  Created by Anh Doan on 7/29/17.
//  Copyright © 2017 Anh Doan. All rights reserved.
//

import Foundation
import SwiftyJSON

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    // Using built in JsonSerialization
    func downloadJsonData(urlString: String) -> [MeowModel] {
        var meowModel = [MeowModel]()
        if let url = URL(string: urlString) {
            let data = try? Data(contentsOf: url)
            if let jsonDict = self.parseJsonData(data: data) {
                for d in jsonDict {
                    if let title = d["title"], let description = d["description"], let imageUrl = d["image_url"] {
                        let meow = MeowModel(name: title as! String, description: description as! String, imageUrl: imageUrl as! String)
                        meowModel.append(meow)
                    }
                }
            }
        }
        return meowModel
    }
    
    private func parseJsonData(data: Data?) -> [[String: AnyObject]]? {
        if let data = data {
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: data) as? [[String: AnyObject]]
                return jsonDict
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    // Using SwiftyJson
    func downloadSwiftyJsonData(urlString: String) -> [MeowModel] {
        var meowModel = [MeowModel]()
        if let url = URL(string: urlString) {
            let data = try! Data(contentsOf: url)
            let json = JSON(data: data)
            for (_, subJson) in json {
                if let title = subJson["title"].string, let description = subJson["description"].string, let imageUrl = subJson["image_url"].string {
                    let meow = MeowModel(name: title, description: description, imageUrl: imageUrl)
                    meowModel.append(meow)
                }
            }
        }
        return meowModel
    }
    
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    
    
}
