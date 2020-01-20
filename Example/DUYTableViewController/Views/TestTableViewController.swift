//
//  TestTableViewController.swift
//  DUYTableviewManager
//
//  Created by Cao Khac Lu Dey on 15/1/20.
//  Copyright © 2020 Duy Personal. All rights reserved.
//

import UIKit
import DUYTableViewController

class TestTableViewController: DUYTableViewController {
    @IBOutlet weak var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView(tableViewModel: TestTableViewModel.init(), tableView: self.tableView)
        self.tableViewModel.fetchData()
    }
    
    override func getRegisteredCells() -> [TableCellRegistration<DUYTableviewCell>] {
        let results : [TableCellRegistration<DUYTableviewCell>] = [
            (classType : ImageTitleTableViewCell.self, isFromXib: true),
            (classType : ImageHorizontalListTableViewCell.self, isFromXib: true)
        ]
        return results
    }
    
    override func setUpBinding() {
        super.setUpBinding()
        self.tableViewModel.onDataChanged = {
            [weak self] vm, section in
            self?.tableView.reloadData()
        }
        
        self.tableViewModel.onRowTap = {
            [weak self] vm, section, row in
            guard let vm = vm as? DUYTableViewCellViewModel else {return}
            self?.showAlert(title: vm.mainTitle, message: vm.subTitle + "\(row)")
        }
    }
    
    override func configureCellViewModel(viewModel: DUYTableviewCellViewModelProtocol, section: Int, row: Int) {
        super.configureCellViewModel(viewModel: viewModel, section: section, row: row)
        switch viewModel {
        case let someVm as ImageTitleCellViewModel:
            let _ = someVm
                .setIdentifierCell(class: ImageTitleTableViewCell.self)
                .setCellHeight(h: 223)
        default:
            return
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
