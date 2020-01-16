//
//  DUYTableviewCell.swift
//  DUYTableviewManager
//
//  Created by Cao Khac Lu Dey on 7/1/20.
//  Copyright © 2020 Duy Personal. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>( with cellClass : T.Type) -> T? {
        return self.dequeueReusableCell(withIdentifier: String.init(describing: cellClass)) as? T
    }
}

public protocol DUYCellViewProtocol  {
    func setData(viewModel: DUYTableviewCellViewModelProtocol)
}

open class DUYTableviewCell: UITableViewCell, DUYCellViewProtocol {

    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    public init() {
        super.init(style: .subtitle, reuseIdentifier: String.init(describing: DUYTableviewCell.self))
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open func setData(viewModel: DUYTableviewCellViewModelProtocol) {
        guard let viewModel = viewModel as? DUYTableViewCellViewModel else {return}
        self.textLabel?.text = viewModel.mainTitle
        self.detailTextLabel?.text = viewModel.subTitle
    }

}
