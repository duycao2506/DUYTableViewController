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
    var dataImageTitle : [(String,String,String)] = [
        ("Justice league 1", "Best movie in 2018", "justice"),
        ("Hello Scene", "The most breathtaking scene in 2019", "scene"),
        ("Justice league 1", "Best movie in 2018", "news")
    ]
    
    var dataBasic : [(String, String)] = [
        ("Cruise line makes claim about granddad holding tot before she fell off ship","Royal Caribbean is seeking to dismiss a civil lawsuit filed by the family of Chloe Wiegand, claiming that her grandfather"),
        ("GRANDFATHER WHO DROPPED TODDLER SPEAKS OUT FOLLOWING TRAGIC INCIDENT","An attorney for the Wiegand family said later that month that Anello had held Chloe up to what he believed to be a window, so she could bang on the glass")
    ]
    
    var dataCollection : [(String,String,[String])] = [
        ("The death of the blockbuster: How The Rise of Skywalker marks the end of a cinematic era", "With Star Wars in trouble and Marvel at a turning point, and X-Men, Men in Black and Terminator among the established franchises faltering in 2019, Adam White asks what’s next for the traditional blockbuster", ["scene", "justice"]),
        ("These Colleges Don’t Make The Grade","The Universities That Just Aren’t Worth The Tuition",["news", "scene"]),
        ("$120K Banana Makes For An Expensive Snack","Typically, bananas are one of nature’s most nutritious, delicious, and affordable snacks. At the grocery store",["justice","scene","news"])
    ]
    
    
    
    override func fetchData(){
        /// Sample code
        var tmpArr : [DUYTableViewCellViewModel] = []
        let section = self.getSectionViewModelAt(index: 0)
        for i in 0...dataCollection.count-1{
            let vm = ImageHorizontalListViewModel.init(sectionViewModel: section, tableViewModel: self, section: 0, row: i)
            vm.subTitle = dataCollection[i].1
            vm.mainTitle = dataCollection[i].0
            vm.listImage = dataCollection[i].2
            tmpArr.append(vm)
        }
        for i in 0...dataImageTitle.count-1 {
            let vm = ImageTitleCellViewModel.init(sectionViewModel: section, tableViewModel: self, section: 0, row : i)
            vm.subTitle = dataImageTitle[i].0
            vm.mainTitle = dataImageTitle[i].1
            vm.image = UIImage.init(named: dataImageTitle[i].2)
            tmpArr.append(vm)
        }
        
        for i in 0...dataBasic.count-1{
            let vm = DUYTableViewCellViewModel.init(sectionViewModel: section, tableViewModel: self, section: 0, row : i)
            vm.subTitle = dataBasic[i].0
            vm.mainTitle = dataBasic[i].1
            tmpArr.append(vm)
        }
        
        section.cellViewModelArray = tmpArr
        /// Sample code end
        
    }
}
