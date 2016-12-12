//
//  Product.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/19/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import Foundation

class Product {
    
    //MARK: Variables
    
    var name = ""
    
    var productDescription = ""
    
    var price = 0.0
    
    var quantity = 0
    
    class func clone(product: Product) -> Product {
        let cloneProduct = Product()
        cloneProduct.name = product.name
        cloneProduct.productDescription = product.productDescription
        cloneProduct.price = product.price
        cloneProduct.quantity = product.quantity
        return cloneProduct
    }
    
}
