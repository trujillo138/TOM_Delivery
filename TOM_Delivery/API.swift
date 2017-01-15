//
//  API.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/30/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import Foundation
import UserNotifications

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
        API.requestNotificationAuthorization()
        let newDelivery = Delivery()
        newDelivery.products = restaurant.products.filter({$0.quantity > 0}).map { p in
            return Product.clone(product: p)
        }
        clearCart()
        newDelivery.calculateDeliveryTotal()
        newDelivery.deliveryDate = calculateNextDeliveryDate()
        newDelivery.calculateMostBoughtProduct()
        API.scheduleNotification(forDelivery: newDelivery)
        API.deliveries.append(newDelivery)
    }
    
    private class func requestNotificationAuthorization() {
        let uNNotificationCenter = UNUserNotificationCenter.current()
        uNNotificationCenter.requestAuthorization(options: [.sound, .alert]) { (grantAccess, error) in
            //Do something if denied permission
        }
    }
    
    private class func scheduleNotification(forDelivery delivery: Delivery) {
        let nextSaleDate = delivery.deliveryDate
        let uNNotificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Order delivered!"
        content.body = "Your $\(delivery.total) order has arrived"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = APINotification.DeliveryNotificationCategory
        content.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: nextSaleDate.timeIntervalSince(Date()), repeats: false)
        let request = UNNotificationRequest(identifier: "Delivery\(delivery.total)", content: content, trigger: trigger) // Schedule the notification.
        uNNotificationCenter.add(request)
    }
    
    private class func clearCart() {
        for product in restaurant.products {
            product.quantity = 0
        }
    }
    
    private class func calculateNextDeliveryDate() -> Date {
        var date = Date()
        date.addTimeInterval(20)
        return date
    }
    
}
