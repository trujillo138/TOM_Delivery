//
//  API.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/30/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import Foundation

struct StoryboardConstants {
    static let ResturanteMenuStoryboardIdentifier = "RestaurantStoryboard"
    static let ShoppingCartStoryboardIdentifier = "ShoppingCartStoryboard"
    static let DeliveriesStoryboardIdentifier = "DeliveriesStoryboard"
    static let AboutStoryboardIdentifier = "AboutStoryboard"
    static let ResturanteMenuViewControllerIdentifier = "RestaurantViewController"
    static let ShoppingCartViewControllerIdentifier = "ShoppingCartViewController"
    static let DeliveriesViewControllerIdentifier = "DeliveriesViewController"
    static let AboutViewControllerIdentifier = "AboutViewController"
    static let MenuTableViewCellIdentifier = "MenuTableViewCell"
}

struct ViewControllersIdentifier {
    static let ProductViewControllerIdentifier = "ProductViewController"
}

class API {
    
    //MARK: Variables
    
    static let restaurant = Restaurant.GetModel()
    
    static var deliveries = [Delivery]()
    
    //MARK: Shopping cart functions
    
    class func buyCart() {
        let newDelivery = Delivery()
        newDelivery.products = restaurant.products.filter({$0.quantity > 0}).map { p in
            return Product.clone(product: p)
        }
        clearCart()
        newDelivery.calculateDeliveryTotal()
        newDelivery.deliveryDate = calculateNextDeliveryDate()
        newDelivery.calculateMostBoughtProduct()
        API.deliveries.append(newDelivery)
    }
    
    private class func clearCart() {
        for product in restaurant.products {
            product.quantity = 0
        }
    }
    
    private class func calculateNextDeliveryDate() -> Date {
        var date = Date()
        date.addTimeInterval(3 * 60)
        return date
    }
    
}
