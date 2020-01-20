//
//  ImageHorizontalListTableViewCell.swift
//  DUYTableViewController_Example
//
//  Created by Duy Cao on 1/19/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import DUYTableViewController

class ImageHorizontalListTableViewCell: DUYTableviewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    

    @IBOutlet weak var imageCollectionView : UICollectionView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblSubtitle : UILabel!
    
    weak var viewModel : ImageHorizontalListViewModel!
    var collectionViewCellIdentifier = String.init(describing: ImageCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.register(UINib.init(nibName: self.collectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: self.collectionViewCellIdentifier)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = self.imageCollectionView.frame.size
        size.width = size.width * 2/3
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.listImage.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionViewCellIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell.init()
        }
        cell.imgView.image = UIImage.init(named: self.viewModel.listImage[indexPath.row])
        return cell
    }
    
    override func setData(viewModel: DUYTableviewCellViewModelProtocol) {
        guard let viewModel = viewModel as? ImageHorizontalListViewModel else {return}
        self.viewModel = viewModel
        self.imageCollectionView.reloadData()
        self.lblTitle.text = viewModel.mainTitle
        self.lblSubtitle.text = viewModel.subTitle
    }
    
}
