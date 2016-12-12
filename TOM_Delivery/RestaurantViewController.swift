//
//  RestaurantViewController.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/23/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ProductCellDelegate {

    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var restaurant = API.restaurant
    
    //MARK: Variables
    
    var menuPresenter: MenuControllerPresenter?
    
    private struct RestaurantVCConstants {
        static let ProductTableViewCellIdentifier = "ProductTableViewCell"        
    }
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: RestaurantVCConstants.ProductTableViewCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: UITableView Delegate and DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant.products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantVCConstants.ProductTableViewCellIdentifier) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        let product = restaurant.products[indexPath.row]
        cell.productName = product.name
        cell.productCost = product.price
        cell.row = indexPath.row
        cell.delegate = self
        cell.productQuantity = product.quantity
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restStoryBoard = UIStoryboard(name: StoryboardConstants.ResturanteMenuStoryboardIdentifier, bundle: nil)
        guard let productViewController = restStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifier.ProductViewControllerIdentifier) as? ProductViewController else {
            return
        }
        let product = restaurant.products[indexPath.row]
        productViewController.product = product
        menuPresenter?.showViewController(controller: productViewController)
    }
    
    //MARK: ProductCell Delegate
    
    func addFromProductAtRow(row: Int) {
        let product = restaurant.products[row]
        product.quantity = product.quantity + 1
        (tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? ProductTableViewCell)?.productQuantity = product.quantity
    }
    
    func removeFromProductAtRow(row: Int) {
        let product = restaurant.products[row]
        product.quantity = product.quantity == 0 ? 0 : product.quantity - 1
        (tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? ProductTableViewCell)?.productQuantity = product.quantity
    }
}
