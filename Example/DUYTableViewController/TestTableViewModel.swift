//
//  TestTableViewModel.swift
//  DUYTableviewManager
//
//  Created by Cao Khac Lu Dey on 16/1/20.
//  Copyright © 2020 Duy Personal. All rights reserved.
//

import UIKit
import DUYTableViewController

class TestTableViewModel : DUYTableviewViewModel{
    override func fetchData(){
        /// Sample code
        var tmpArr : [DUYTableViewCellViewModel] = []
        let section = self.getSectionViewModelAt(index: 0)
        for i in 0...20 {
            let vm = DUYTableViewCellViewModel.init(sectionViewModel: section, tableViewModel: self, section: 0, row : i)
            vm.subTitle = "Hello \(i)"
            vm.mainTitle = "Title \(i)"
            tmpArr.append(vm)
        }
        
        section.cellViewModelArray = tmpArr
        /// Sample code end
        
    }
}
