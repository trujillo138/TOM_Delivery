//
//  ProductTableViewCell.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/27/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

protocol ProductCellDelegate {
    func addFromProductAtRow(row: Int)
    func removeFromProductAtRow(row: Int)
}

class ProductTableViewCell: UITableViewCell, CircularImageButtonDelegate {

    //MARK: Outlets
    
    @IBOutlet private weak var addButton: CircularImageButton!
    
    @IBOutlet private weak var minusButton: CircularImageButton!
    
    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productNameLabel: UILabel!
    
    @IBOutlet private weak var productCostLabel: UILabel!
    
    @IBOutlet private weak var productQuantityLabel: UILabel!
    //MARK: Variables
    
    var row = -1
    
    var delegate: ProductCellDelegate?
    
    var productName: String? {
        didSet {
            productImageView.image = UIImage(named: productName ?? "")
            productNameLabel.text = productName
        }
    }
    
    var productCost: Double? {
        didSet {
            productCostLabel.text = "$\(productCost ?? 0.0)"
        }
    }
    
    var productQuantity: Int? {
        didSet {
            DispatchQueue.main.async {
                self.productQuantityLabel.text = "\(self.productQuantity ?? 0)"
            }
        }
    }
    
    //MARK: Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addButton.imageName = "add"
        addButton.buttonType = .add
        addButton.delegate = self
        minusButton.imageName = "remove"
        minusButton.buttonType = .remove
        minusButton.delegate = self
        selectionStyle = .none
        backgroundColor = UIColor.clear
    }
    
    //MARK: CircularButton Delegate
    
    func pressedButtonWith(type: CirculaImageButtonType) {
        if type == .add {
            delegate?.addFromProductAtRow(row: row)
        } else if type == .remove {
            delegate?.removeFromProductAtRow(row: row)
        }
    }
}
