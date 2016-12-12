//
//  MenuTableViewCell.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/22/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

protocol MenuTableViewCellDelegate {
    func tappedMenuTableViewCellDelegateWith(optionName: String)
}

class MenuTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet private weak var menuOptionNameLabel: UILabel!
    
    //MARK: Variable
    
    var optionName = "" {
        didSet {
            menuOptionNameLabel.text = optionName
        }
    }
    
    var delegate: MenuTableViewCellDelegate?
    
    //MARK: Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        selectionStyle = .none
    }
}
