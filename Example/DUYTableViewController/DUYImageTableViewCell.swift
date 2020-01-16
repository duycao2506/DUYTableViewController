//
//  DUYImageTableViewCell.swift
//  DUYTableviewManager
//
//  Created by Cao Khac Lu Dey on 16/1/20.
//  Copyright © 2020 Duy Personal. All rights reserved.
//

import UIKit
import DUYTableViewController

class DUYImageTableViewCell: DUYTableviewCell {

    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setData(viewModel: DUYTableviewCellViewModelProtocol) {
        guard let viewModel = viewModel as? DUYTableViewCellViewModel else {return}
        self.lblTitle.text = viewModel.mainTitle
        self.lblSubtitle.text = viewModel.subTitle
    }
    
}
