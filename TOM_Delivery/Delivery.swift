//
//  Delivery.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/19/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import Foundation

enum DeliveryState {
    case delivered
    case cancelled
    case inProgress
}

class Delivery {
    
    var products = [Product]()
    
    var deliveryDate = Date()
    
    var delivered = false
    
    var total = 0.0
    
    var sate = DeliveryState.inProgress
    
    var mostBoughtProduct: Product?
    
    func calculateDeliveryTotal() {
        total = 0.0
        for product in products {
            total += Double(product.quantity) * product.price
        }
    }
    
    func calculateMostBoughtProduct() {
        let sortedProducts = products.sorted(by: {return $0.quantity > $1.quantity})
        mostBoughtProduct = sortedProducts[0]
    }
}
