//
//  ImageCollectionViewCell.swift
//  DUYTableViewController_Example
//
//  Created by Duy Cao on 1/21/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.imgView.layer.cornerRadius = 24.0
        self.imgView.layer.masksToBounds = true
    }

}
