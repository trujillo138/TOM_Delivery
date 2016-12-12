//
//  ProductViewController.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/30/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, CircularImageButtonDelegate {

    //MARK: Outlets
    
    @IBOutlet private weak var productImageView: UIImageView!
    
    @IBOutlet private weak var productCostLabel: UILabel!
    
    @IBOutlet private weak var productDescriptionTextView: UITextView!
    
    @IBOutlet private weak var addButton: CircularImageButton!
    
    @IBOutlet private weak var minusButton: CircularImageButton!
    
    @IBOutlet private weak var productQuantityLabel: UILabel!
    
    //MARK: Variables
    
    var product: Product?
    
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialValues()
        setupCircularButtons()
    }
    
    private func setInitialValues() {
        guard let prod = product else {
            return
        }
        title = prod.name
        productImageView.image = UIImage(named: prod.name)
        productCostLabel.text = "\(prod.price)"
        productDescriptionTextView.text = "\(prod.productDescription)"
        productQuantityLabel.text = "\(prod.quantity)"
    }
    
    //MARK: CircularButton Delegate
    
    private func setupCircularButtons() {
        addButton.imageName = "add"
        addButton.buttonType = .add
        addButton.delegate = self
        minusButton.imageName = "remove"
        minusButton.buttonType = .remove
        minusButton.delegate = self
    }
    
    func pressedButtonWith(type: CirculaImageButtonType) {
        guard let prod = product else {
            return
        }
        if type == .add {
            prod.quantity = prod.quantity + 1
        } else if type == .remove {
            prod.quantity = prod.quantity == 0 ? 0 : prod.quantity - 1
        }
        productQuantityLabel.text = "\(prod.quantity)"
    }
    
}
