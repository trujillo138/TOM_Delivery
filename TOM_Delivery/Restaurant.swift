//
//  Restaurant.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/19/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import Foundation

class Restaurant {
    
    //MARK: Variables
    
    var products = [Product]()
    
    var deliveries = [Delivery]()
    
    //MARK: Class Methods
    
    class func GetModel() -> Restaurant {
        let restaurant = Restaurant()
        restaurant.createMockModel()
        return restaurant
    }
    
    //MARK: Mock model
    
    private func createMockModel() {
        let hotDog = Product()
        hotDog.name = "Hot dog"
        hotDog.productDescription = "Hot dog description"
        hotDog.price = 15000.0
        let hamburger = Product()
        hamburger.name = "Cheeseburger"
        hamburger.productDescription = "Cheeses burger description"
        hamburger.price = 15000.0
        let fries = Product()
        fries.name = "Fries"
        fries.productDescription = "Potato fries description"
        fries.price = 3000.0
        let soda = Product()
        soda.name = "Coke"
        soda.productDescription = "Coke description"
        soda.price = 2000.0
        let sandwich = Product()
        sandwich.name = "Sandwich"
        sandwich.productDescription = "Sandwich description"
        sandwich.price = 18500.0
        let salad = Product()
        salad.name = "Tomato soup"
        salad.productDescription = "Tomato soup description"
        salad.price = 10000.0
        let soup = Product()
        soup.name = "Onion soup"
        soup.productDescription = "Onion soup description"
        soup.price = 11000.0
        let cheesecake = Product()
        cheesecake.name = "Strawberry cheesecake"
        cheesecake.productDescription = "Strawberry cheesecake description"
        cheesecake.price = 8000.0
        let milkShake = Product()
        milkShake.name = "Milkshake"
        milkShake.productDescription = "Milkshake description"
        milkShake.price = 12000.0
        let brownie = Product()
        brownie.name = "Brownie"
        brownie.productDescription = "Brownie description"
        brownie.price = 7500.0
        
        products.append(hotDog)
        products.append(hamburger)
        products.append(fries)
        products.append(soda)
        products.append(sandwich)
        products.append(salad)
        products.append(soup)
        products.append(cheesecake)
        products.append(milkShake)
        products.append(brownie)
    }
    
}
