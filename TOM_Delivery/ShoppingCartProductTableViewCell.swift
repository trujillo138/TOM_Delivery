//
//  ShoppingCartProductTableViewCell.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/31/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

class ShoppingCartProductTableViewCell: UITableViewCell {

    //MARK: Outlets
    
    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    
    @IBOutlet private weak var productTotalCostLabel: UILabel!
    
    @IBOutlet private weak var productUnitPrice: UILabel!
    
    
    //MARK: Variables
    
    var productName: String? {
        didSet {
            productNameLabel.text = productName
            productImageView.image = UIImage(named: productName ?? "")
        }
    }
    
    var productTotalCost = 0.0 {
        didSet {
            productTotalCostLabel.text = "$\(productTotalCost)"
        }
    }
    
    var productCost = 0.0 {
        didSet {
            productUnitPrice.text = "$\(productCost)"
        }
    }
    
    //MARK: Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = UIColor.clear
    }
    
}
