//
//  ApparelCollectionCell.swift
//  Mercari
//
//  Created by Anh Doan on 6/18/17.
//  Copyright © 2017 Mercari. All rights reserved.
//

import UIKit

class ApparelCollectionCell: UICollectionViewCell {
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var itemStatus: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    
    
    var apparel: Apparel! {
        didSet {
            self.updateUI()
        }
    }
    
    
    func updateUI() {
        itemName.text = apparel.name
        price.text = apparel.price
        itemStatus.image = UIImage() // Clear the old image as cell is dequeue.
        if apparel.status == "sold_out" {
            itemStatus.image = UIImage(named: "sold")
        }
    }
}
