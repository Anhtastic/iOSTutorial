//
//  ViewController.swift
//  ParsingTextField
//
//  Created by Anh Doan on 7/25/17.
//  Copyright © 2017 Anh Doan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textEntered: UITextField!
    @IBOutlet weak var textDisplayed: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let jsonModel = JsonModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textEntered.delegate = self
        activityIndicator.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            do {
                // Turn on indicator to let the user know we're fetching network data
                activityIndicator.startAnimating()
                // Reset model
                jsonModel.resetEmoticons()
                jsonModel.resetLinksAndTitles()
                // Get emoticons
                let pattern = "\\((.{1,15})\\)"
                let regex =  try NSRegularExpression(pattern: pattern, options: [])
                let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count))
                
                for match in matches {
                    for n in 1 ..< match.numberOfRanges {
                        let range = match.rangeAt(n)
                        let r = text.index(text.startIndex, offsetBy: range.location) ..< text.index(text.startIndex, offsetBy: range.location + range.length)
                        let emoticon = text.substring(with: r)
                        jsonModel.appendEmoticon(emoticon: emoticon)
                    }
                }
                
                // Get link in order to parse the title in html page.
                let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
                let urlMatches = detector.matches(in: text, options: [], range: NSMakeRange(0, text.utf16.count))
                for match in urlMatches {
                    let urlString = (text as NSString).substring(with: match.range)
                    jsonModel.setTitle(link: urlString, title: "")
                }
                // Let's initially just show the user emoticons and links without titles and then we download the titles in the background thread.
                textDisplayed.text = "\temoticons: \(jsonModel.getEmoticons()) \n\n\tlinks: \(jsonModel.getLinks())"
                downloadTitleInBackground()
            } catch {
                print("Error in regular expression: \(error)")
            }
        }
    }
    
    // Parsing html pages in order to get the titles of the links. Since we're fetching data, we'll do it in the background.
    func downloadTitleInBackground() {
        DispatchQueue.global().async {
            for link in self.jsonModel.getLinks() {
                if let linkAndTitle = NetworkRequest.shared.downloadTitle(urlString: link) {
                    self.jsonModel.setTitle(link: linkAndTitle.0, title: linkAndTitle.1)
                }
            }
            DispatchQueue.main.async(qos: .userInitiated) {
                let linksAndTitles = self.jsonModel.getLinksAndTitle()
                if !linksAndTitles.isEmpty {
                    var texts = "\temoticons: \(self.jsonModel.getEmoticons()) \n\n\tlinks: \n\t[\n"
                    for (k, v) in linksAndTitles {
                        texts += "\t\tlink: \(k), title: \(v)\n"
                    }
                    texts += "\t]"
                    self.textDisplayed.text = texts
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
}






