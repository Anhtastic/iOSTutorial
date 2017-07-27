//
//  JsonModel.swift
//  ParsingTextField
//
//  Created by Anh Doan on 7/26/17.
//  Copyright © 2017 Anh Doan. All rights reserved.
//

import Foundation

class JsonModel {
    
    private var emoticons = [String]()
    private var linksAndTitles = [String: String]()
    
    
    func getEmoticons() -> [String] {
        return emoticons
    }
    
    func getLinks() -> [String] {
        let links = Array(linksAndTitles.keys)
        return links
    }
    
    func appendEmoticon(emoticon: String) {
        emoticons.append(emoticon)
    }
    
    
    func setTitle(link: String, title: String) {
        guard !link.isEmpty else { return }
        linksAndTitles[link] = title
    }
    
    func getLinksAndTitle() -> [String: String] {
        return linksAndTitles
    }
    
    func resetEmoticons() {
        emoticons = []
    }
    
    func resetLinksAndTitles() {
        linksAndTitles = [:]
    }
}









































