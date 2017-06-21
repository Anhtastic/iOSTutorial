//
//  ShoppingListCollectionViewController.swift
//  Mercari
//
//  Created by Anh Doan on 6/17/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ApparelCell"
private let urlString = "" // Enter web url where json is located.

class ApparelViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var apparels = [Apparel]()
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apparels = Apparel.downloadJson()
//        apparels = Apparel.downloadJsonFromAPI(urlString: urlString)

    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apparels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ApparelCollectionCell
        cell.backgroundColor = .black
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        let apparel = apparels[indexPath.row]
        cell.apparel = apparel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let lengthPerItem = availableWidth/itemsPerRow
        return CGSize(width: lengthPerItem, height: lengthPerItem)
    }
    
}


















