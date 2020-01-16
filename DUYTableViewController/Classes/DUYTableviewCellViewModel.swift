//
//  DUYTableviewCellViewModel.swift
//  DUYTableviewManager
//
//  Created by Cao Khac Lu Dey on 7/1/20.
//  Copyright © 2020 Duy Personal. All rights reserved.
//

import Foundation
import UIKit

//Cell Level
public typealias DUYCellAction = ((DUYTableviewCellViewModelProtocol)->Void)

open class DUYCellSwipeActionComponent {
    var title : String = ""
    var image : UIImage? = nil
    var background : UIColor = .systemRed
    var tintColor : UIColor = .white
    
    var action : DUYCellAction? = nil
}


/// TableView Cell Level Protocol
public protocol DUYTableviewCellViewModelProtocol {
    var estimatedCellHeight : CGFloat { get set }
    var identifier : String {get set}
    var cellHeight : CGFloat {get set}
    var isEditable : Bool {get set}
    var onTap : DUYCellAction? {get set}
    var onDataChange : DUYCellAction? {get set}
    var swipeRightActions: [DUYCellSwipeActionComponent] {get set}
    var swipeLeftActions : [DUYCellSwipeActionComponent] {get set}
    
    /// Remember to put it as weak var
    var tableViewModel : DUYTableviewViewModelProtocol! {get set}
    
    /// Put it as weak var
    var sectionViewModel : DUYTableViewSectionViewModelProtocol! {get set}
    
    func migrateFrom<T>(type: T.Type)
    
    func insertRightAction(atIndex: Int, actionComp: DUYCellSwipeActionComponent)
    func insertLeftAction(atIndex: Int,  actionComp: DUYCellSwipeActionComponent)
    
    
    func setIdentifier(id : String)->DUYTableviewCellViewModelProtocol
    func setCellHeight(h : CGFloat) -> DUYTableviewCellViewModelProtocol
    func setTapAction(action :  @escaping DUYCellAction) -> DUYTableviewCellViewModelProtocol
    func setDataChangeAction(action :  @escaping DUYCellAction) -> DUYTableviewCellViewModelProtocol
}

/// Tableview Cell Level Class
open class DUYTableViewCellViewModel : DUYTableviewCellViewModelProtocol{
    weak open var tableViewModel: DUYTableviewViewModelProtocol!
    
    weak open var sectionViewModel: DUYTableViewSectionViewModelProtocol!
    
    open var estimatedCellHeight: CGFloat = 48.0
    
    open var identifier: String = String.init(describing: DUYTableviewCell.self)
    
    open var cellHeight: CGFloat = 48.0
     
    open var isEditable: Bool = false
    
    open var onTap: DUYCellAction? = nil
    
    open var onDataChange: DUYCellAction? = nil {
        didSet {
            self.onDataChange?(self)
        }
    }
    
    open var swipeRightActions: [DUYCellSwipeActionComponent] = []
    
    open var swipeLeftActions: [DUYCellSwipeActionComponent] = []
    
    
    open var mainTitle : String = ""
    open var subTitle : String = ""
    
    private init(){
        
    }
    
    public init(sectionViewModel : DUYTableViewSectionViewModelProtocol, tableViewModel : DUYTableviewViewModelProtocol, section : Int, row : Int) {
        self.sectionViewModel = sectionViewModel
        self.tableViewModel = tableViewModel
        self.tableViewModel.onConfiguringCell?(self,section,row)
    }
    
    open func migrateFrom<T>(type: T.Type) {
        
    }
    
    open func insertRightAction(atIndex: Int, actionComp: DUYCellSwipeActionComponent) {
        self.swipeRightActions.insert(actionComp, at: atIndex)
    }
    
    open func insertLeftAction(atIndex: Int, actionComp: DUYCellSwipeActionComponent) {
        self.swipeLeftActions.insert(actionComp, at: atIndex)
    }
    
    open func setIdentifier(id: String) -> DUYTableviewCellViewModelProtocol {
        self.identifier = id
        return self
    }
    
    open func setCellHeight(h: CGFloat) -> DUYTableviewCellViewModelProtocol {
        self.cellHeight = h
        return self
    }
    
    open func setTapAction(action: @escaping (DUYTableviewCellViewModelProtocol) -> Void) -> DUYTableviewCellViewModelProtocol {
        self.onTap = action
        return self
    }
    
    
    open func setDataChangeAction(action: @escaping DUYCellAction) -> DUYTableviewCellViewModelProtocol {
        self.onDataChange = action
        return self
    }
    
}



/// TableView Section Level Protocol
public protocol DUYTableViewSectionViewModelProtocol : class {
    var tableViewModel : DUYTableviewViewModelProtocol! { get set }
    var cellViewModelArray : [DUYTableviewCellViewModelProtocol] { get set }
    var onDataChanged : (([DUYTableviewCellViewModelProtocol])->())? { get set }
    
    var mainTitle : String { get set }
    func delete(atIndex : Int) -> DUYTableviewCellViewModelProtocol
    func insert(atIndex : Int, cellViewModel: DUYTableviewCellViewModelProtocol)
    func getCellViewModelAt(index :Int) -> DUYTableviewCellViewModelProtocol
    

}

/// TableView Section Level Class
open class DUYTableViewSectionViewModel : DUYTableViewSectionViewModelProtocol {
    open weak var tableViewModel: DUYTableviewViewModelProtocol!
    
    open var cellViewModelArray: [DUYTableviewCellViewModelProtocol] = [] {
        didSet{
            onDataChanged?(self.cellViewModelArray)
        }
    }
    
    open var onDataChanged: (([DUYTableviewCellViewModelProtocol]) -> ())? {
        didSet{
            self.onDataChanged?(self.cellViewModelArray)
        }
    }
    
    open var mainTitle: String = ""
    
    init(tableViewModel : DUYTableviewViewModelProtocol, section : Int = 0) {
        self.tableViewModel = tableViewModel
        self.onDataChanged = {
            [weak self] array in
            guard let self = self else {return}
            self.tableViewModel.onDataChanged?([self],section)
        }
    }
    
    open func delete(atIndex: Int) -> DUYTableviewCellViewModelProtocol {
        return self.cellViewModelArray.remove(at: atIndex)
    }
    
    open func insert(atIndex: Int, cellViewModel: DUYTableviewCellViewModelProtocol) {
        self.cellViewModelArray.insert(cellViewModel, at: atIndex)
    }
    
    open func getCellViewModelAt(index: Int) -> DUYTableviewCellViewModelProtocol {
        return self.cellViewModelArray[index]
    }
    
}




/// TableView Level Protocol
public protocol DUYTableviewViewModelProtocol : class {
    var sectionViewModelArray : [DUYTableViewSectionViewModelProtocol] { get set }
    var onDataChanged: (([DUYTableViewSectionViewModelProtocol], _ section : Int?) -> ())? { get set }
    var onRowTap : ((DUYTableviewCellViewModelProtocol, _ section : Int, _ row : Int)->Void)? { get set}
    var onConfiguringCell : ((DUYTableviewCellViewModelProtocol, _ section : Int, _ row : Int)->Void)? {get set}
        
    func fetchData()
    func insertSection(index : Int, viewModel: DUYTableViewSectionViewModelProtocol)
    func delete(section: Int, row : Int) -> DUYTableviewCellViewModelProtocol
    func getSectionViewModelAt(index : Int) -> DUYTableViewSectionViewModelProtocol
    func getCellViewModelAt(section : Int, row : Int) -> DUYTableviewCellViewModelProtocol
}


/// TableView Class Level
open class DUYTableviewViewModel : DUYTableviewViewModelProtocol {
    
    open var onConfiguringCell: ((DUYTableviewCellViewModelProtocol, Int, Int) -> Void)?
    
    open var onRowTap: ((DUYTableviewCellViewModelProtocol, _ section: Int, _ row: Int)->Void)?

    open var onDataChanged: (([DUYTableViewSectionViewModelProtocol], _ section : Int?) -> ())?
    
    
    open var sectionViewModelArray: [DUYTableViewSectionViewModelProtocol] = [] {
        didSet {
            self.onDataChanged?(self.sectionViewModelArray, nil)
        }
    }
    
    public init() {
        let oneSection = DUYTableViewSectionViewModel.init(tableViewModel: self,section: 0)
        self.insertSection(index: 0, viewModel: oneSection)
    }
    
    open func insertSection(index : Int, viewModel: DUYTableViewSectionViewModelProtocol) {
        self.sectionViewModelArray.insert(viewModel, at: index)
    }
    
    open func fetchData(){
        preconditionFailure("overriden needed")
    }
    
    open func delete(section: Int, row: Int) -> DUYTableviewCellViewModelProtocol {
        return self.sectionViewModelArray[section].cellViewModelArray.remove(at: row)
    }
    
    open func getCellViewModelAt(section: Int, row: Int) -> DUYTableviewCellViewModelProtocol {
        return self.sectionViewModelArray[section].cellViewModelArray[row]
    }
    
    open func getSectionViewModelAt(index: Int) -> DUYTableViewSectionViewModelProtocol {
        return sectionViewModelArray[index]
    }
}

