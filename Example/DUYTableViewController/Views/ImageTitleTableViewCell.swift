//
//  DUYImageTableViewCell.swift
//  DUYTableviewManager
//
//  Created by Cao Khac Lu Dey on 16/1/20.
//  Copyright © 2020 Duy Personal. All rights reserved.
//

import UIKit
import DUYTableViewController

class ImageTitleTableViewCell: DUYTableviewCell {

    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgView.layer.cornerRadius = 24.0
        self.imgView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(viewModel: DUYTableviewCellViewModelProtocol) {
        guard let viewModel = viewModel as? ImageTitleCellViewModel else {return}
        self.lblTitle.text = viewModel.mainTitle
        self.lblSubtitle.text = viewModel.subTitle
        self.imgView.image = viewModel.image
    }
    
}
