//
//  ShoppingCartViewController.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/23/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CircularImageButtonDelegate {

    //MARK: Outlets
    
    @IBOutlet weak var mostBoughtProductImageView: UIImageView!
    
    @IBOutlet weak var totalCostLabel: UILabel!
    
    @IBOutlet weak var shoppingCartTableView: UITableView!
    
    @IBOutlet weak var buyButton: CircularImageButton!
    
    //MARK: Variables
    
    var menuPresenter: MenuControllerPresenter?
    
    private var shoppingCartProducts: [Product] {
        return API.restaurant.products.filter {$0.quantity > 0}
    }
    
    private struct ShoppingCartVCConstants {
        static let ShoppingCartProductCellIdentifier = "Shopping cart product cell"
    }
    
    private var mostBoughtProduct: Product? {
        var mostBoughtProd: Product?
        if shoppingCartProducts.count > 0 {
            mostBoughtProd = shoppingCartProducts.sorted(by: {$0.quantity > $1.quantity})[0]
        }
        return mostBoughtProd
    }
    
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        buyButton.buttonType = .buy
        buyButton.imageName = "buy"
        buyButton.delegate = self
        shoppingCartTableView.register(UINib(nibName: "ShoppingCartProductTableViewCell", bundle: nil),
                                       forCellReuseIdentifier: ShoppingCartVCConstants.ShoppingCartProductCellIdentifier)
        shoppingCartTableView.delegate = self
        shoppingCartTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shoppingCartTableView.reloadData()
        updateUI()
    }
    
    private func updateUI() {
        setMostBoughtProductImage()
        setTotalPrice()
    }
    
    private func setMostBoughtProductImage() {
        guard let mostBoughtprod = mostBoughtProduct else {
            mostBoughtProductImageView.image = nil
            return
        }
        mostBoughtProductImageView.image = UIImage(named: mostBoughtprod.name)
    }
    
    private func setTotalPrice() {
        var sum = 0.0
        for product in shoppingCartProducts {
            sum += Double(product.quantity) * product.price
        }
        totalCostLabel.text = "$\(sum)"
    }
    
    //MARK: UITableView Delegate and DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = shoppingCartTableView.dequeueReusableCell(withIdentifier: ShoppingCartVCConstants.ShoppingCartProductCellIdentifier)
            as? ShoppingCartProductTableViewCell else {
                return UITableViewCell()
        }
        let product = shoppingCartProducts[indexPath.row]
        cell.productName = product.name
        cell.productTotalCost = Double(product.quantity) * product.price
        cell.productCost = product.price
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restStoryBoard = UIStoryboard(name: StoryboardConstants.ResturanteMenuStoryboardIdentifier, bundle: nil)
        guard let productViewController = restStoryBoard.instantiateViewController(withIdentifier: ViewControllersIdentifier.ProductViewControllerIdentifier) as? ProductViewController else {
            return
        }
        let product = shoppingCartProducts[indexPath.row]
        productViewController.product = product
        menuPresenter?.showViewController(controller: productViewController)
    }
    
    //MARK: CircularImageButton Delegate
    
    func pressedButtonWith(type: CirculaImageButtonType) {
        if type == .buy && shoppingCartProducts.count > 0 {
            API.buyCart()
            let alertController = UIAlertController(title: "Shopping cart purchased!", message: "Thanks for your purchase. Expect delivery in the next 3 minutes",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            shoppingCartTableView.reloadData()
            updateUI()
        }
    }
}
