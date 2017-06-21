//
//  NetworkManager.swift
//  Mercari
//
//  Created by Anh Doan on 6/18/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import Foundation

class ParseJsonManager {
    
    static func parseJSONData(data: Data?) -> [String: AnyObject]? {
        if let data = data {
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject]
                return jsonDict
            } catch let error as NSError {
                print("Error trying to process data: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    
}
















