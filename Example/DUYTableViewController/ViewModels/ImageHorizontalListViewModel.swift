//
//  ImageHorizontalListViewModel.swift
//  DUYTableViewController_Example
//
//  Created by Duy Cao on 1/19/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import DUYTableViewController

class ImageHorizontalListViewModel : DUYTableViewCellViewModel {
    var listImage : [String] = []
    
    override init(sectionViewModel: DUYTableViewSectionViewModelProtocol, tableViewModel: DUYTableviewViewModelProtocol, section: Int, row: Int) {
        super.init(sectionViewModel: sectionViewModel, tableViewModel: tableViewModel, section: section, row: row)
        self.cellHeight = 250.0
        self.estimatedCellHeight = self.cellHeight
        self.identifier = String.init(describing: ImageHorizontalListTableViewCell.self)
    }
    
    
    
}

