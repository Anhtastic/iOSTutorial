//
//  ViewController.swift
//  Meow Fest
//
//  Created by Anh Doan on 7/29/17.
//  Copyright © 2017 Anh Doan. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    
    var catModels = [MeowModel]()
    let urlString = "https://chex-triplebyte.herokuapp.com/api/cats?page=0"
    var currentCatIndex = 0
    var downloadInProgress = false
    
    
    var spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 1000)
        scrollView.alwaysBounceVertical = true
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .orange
        
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinner.hidesWhenStopped = true
        spinner.frame.size = CGSize(width: 50, height: 50)

        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

//        catModels = NetworkRequest.shared.downloadJsonData(urlString: urlString)
        catModels = NetworkRequest.shared.downloadSwiftyJsonData(urlString: urlString)
        updateScrollView()
    }
    
    
    func updateScrollView() {
        guard currentCatIndex < catModels.count && currentCatIndex >= 0 else { return }
        let subView = ModelView()
        containerView.addSubview(subView)
        
//        if let url = URL(string: catModels[currentCatIndex].imageUrl) {
//            downloadImage(url: url, imageView: subView.imageView)
//        } else { return }
        downloadImageWithAlamoFire(urlString: catModels[currentCatIndex].imageUrl, imageView: subView.imageView)
        subView.label.text = catModels[self.currentCatIndex].name
        subView.textView.text = catModels[self.currentCatIndex].description
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.scrollView.frame.size.height * CGFloat(self.currentCatIndex + 1))

        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor).isActive = true
        subView.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor).isActive = true
        subView.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor, constant: scrollView.frame.size.height * CGFloat(currentCatIndex)).isActive = true
        subView.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor, constant: scrollView.frame.size.height * CGFloat(currentCatIndex)).isActive = true
    }
    // Using built in URLSession
    func downloadImage(url: URL, imageView: UIImageView) {
        downloadInProgress = true
        spinner.startAnimating()
        imageView.contentMode = .scaleAspectFit
        NetworkRequest.shared.getDataFromUrl(url: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                guard self.currentCatIndex < self.catModels.count && self.currentCatIndex >= 0 else { return }
                imageView.image = UIImage(data: data)
                self.spinner.stopAnimating()
                self.downloadInProgress = false
                self.currentCatIndex += 1
            }
        }
    }
    // Using Alamofire
    func downloadImageWithAlamoFire(urlString: String, imageView: UIImageView) {
        downloadInProgress = true
        spinner.startAnimating()
        imageView.contentMode = .scaleAspectFit
        Alamofire.request(urlString).response { (response) in
            if let data = response.data {
                DispatchQueue.main.async {
                    guard self.currentCatIndex < self.catModels.count && self.currentCatIndex >= 0 else { return }
                    imageView.image = UIImage(data: data)
                    self.spinner.stopAnimating()
                    self.downloadInProgress = false
                    self.currentCatIndex += 1
                }
            }
        }
    }

}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if downloadInProgress { return }
        
        let offset = scrollView.contentOffset
        let bounds = scrollView.bounds
        let size = scrollView.contentSize
        let inset = scrollView.contentInset
        
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        let reloadDistance = CGFloat(30.0)
        
        if y > h + reloadDistance {
            guard currentCatIndex < catModels.count && currentCatIndex >= 0 else { return }
            updateScrollView()
        }
    }
}
















