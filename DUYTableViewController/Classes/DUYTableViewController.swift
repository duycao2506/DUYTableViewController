//
//  ViewController.swift
//  DUYTableviewManager
//
//  Created by Cao Khac Lu Dey on 7/1/20.
//  Copyright © 2020 Duy Personal. All rights reserved.
//

import UIKit
public typealias TableCellRegistration <T:DUYTableviewCell> = (classType : T.Type, isFromXib : Bool)
open class DUYTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private weak var duyTableView :UITableView!
    open var tableViewModel : DUYTableviewViewModelProtocol!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    open func getRegisteredCells() -> [TableCellRegistration<DUYTableviewCell>]{
        preconditionFailure("overriden needed")
    }
    
    
    
    open func setUpBinding(){
        self.tableViewModel.onConfiguringCell = {
            [weak self] vm, section, row in
            guard let self = self else {return}
            self.configureCellViewModel(viewModel: vm, section: section, row: row)
        }
    }
    
    open func configureCellViewModel(viewModel : DUYTableviewCellViewModelProtocol, section : Int, row : Int){
        var viewModel = viewModel
        viewModel.onTap = {
            [weak self] vm in
            self?.tableViewModel.onRowTap?(vm, section, row)
        }
        return 
    }
    
    open func setUpTableView(tableViewModel : DUYTableviewViewModelProtocol = DUYTableviewViewModel.init(), tableView: UITableView) {
        self.duyTableView = tableView
        self.tableViewModel = tableViewModel
        let registrations = self.getRegisteredCells()
        for registry in registrations {
            let strClass = String.init(describing: registry.classType)
            if registry.isFromXib {
                self.duyTableView.register(UINib.init(nibName: strClass, bundle: nil), forCellReuseIdentifier: strClass)
            }else{
                self.duyTableView.register(registry.classType, forCellReuseIdentifier: strClass)
            }
        }
        
        self.setUpBinding()
    }
    
    
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = self.tableViewModel.getCellViewModelAt(section: indexPath.section, row: indexPath.row)
        return cellViewModel.cellHeight
    }
    
    internal func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = self.tableViewModel.getCellViewModelAt(section: indexPath.section, row: indexPath.row)
        return cellViewModel.estimatedCellHeight
    }
    
    internal func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let cellViewModel = self.tableViewModel.getCellViewModelAt(section: indexPath.section, row: indexPath.row)
        return cellViewModel.isEditable
    }
    
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var vm = self.tableViewModel.getCellViewModelAt(section: indexPath.section, row: indexPath.row)
        vm.estimatedCellHeight = cell.frame.size.height
    }
    
    internal func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cellViewModel = self.tableViewModel.getCellViewModelAt(section: indexPath.section, row: indexPath.row)
        var actionContextual : [UIContextualAction] = []
        for actionComp in cellViewModel.swipeRightActions {
            let action = UIContextualAction.init(style: .normal, title: actionComp.title) { (action, view, complete) in
                actionComp.action?(cellViewModel)
                complete(true)
            }
            action.backgroundColor = actionComp.background
            action.image = actionComp.image
            actionContextual.append(action)
        }
        let configuration = UISwipeActionsConfiguration(actions: actionContextual)
        return configuration
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.getSectionViewModelAt(index: section).cellViewModelArray.count
    }
    
    private func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vm = self.tableViewModel.getCellViewModelAt(section: indexPath.section, row: indexPath.row)
        vm.onTap?(vm)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = self.tableViewModel.sectionViewModelArray[indexPath.section].cellViewModelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier) ?? tableView.dequeueReusableCell(with: DUYTableviewCell.self) ?? DUYTableviewCell.init()
        guard let cellData = cell as? DUYCellViewProtocol else {
            return cell
        }
        cellData.setData(viewModel: cellViewModel)
        return cell
    }
    
    open func showAlert(title : String, message : String) {
        let alertVc = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alertVc.addAction(.init(title: "OK", style: .cancel, handler: nil))
        self.present(alertVc, animated: true, completion: nil)
    }

}


