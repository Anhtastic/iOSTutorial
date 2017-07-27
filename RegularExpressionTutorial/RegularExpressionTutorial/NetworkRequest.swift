//
//  NetworkRequest.swift
//  ParsingTextField
//
//  Created by Anh Doan on 7/26/17.
//  Copyright © 2017 Anh Doan. All rights reserved.
//

import Foundation


class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    func downloadTitle(urlString: String) -> (String, String)? {
        if let url = URL(string: urlString) {
            let title = getTitleFromHTML(url: url)
            return (urlString, title)
        }
        return nil
    }
    
    private func getTitleFromHTML(url: URL) -> String {
        do {
            let html = try String(contentsOf: url, encoding: .ascii)
            let pattern = "<title>(.*?)</title>"
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: html, options: [], range: NSRange(location: 0, length: html.characters.count))
            for match in matches {
                for n in 1 ..< match.numberOfRanges {
                    let range = match.rangeAt(n)
                    let r = html.index(html.startIndex, offsetBy: range.location) ..< html.index(html.startIndex, offsetBy: range.location + range.length)
                    let title = html.substring(with: r)
                    return title
                }
            }
        } catch let error {
            print("Error: \(error)")
        }
        return "No Title Available"
    }
    
}































