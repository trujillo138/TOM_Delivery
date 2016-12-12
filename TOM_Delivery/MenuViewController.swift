//
//  MenuViewController.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/22/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

enum MenuOptions:Int {
    case restaurantController = 0
    case shoppingCartController = 1
    case deliveriesController = 2
    case aboutController = 3
    
    static func nameFor(option: MenuOptions) -> String {
        switch option {
        case .restaurantController:
            return "TOM Restaurant"
        case .shoppingCartController:
            return "Shopping cart"
        case .deliveriesController:
            return "Deliveries"
        case .aboutController:
            return "About"
        }
    }
    
}

protocol MenuControllerPresenter {
    func showViewController(controller: UIViewController)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MenuControllerPresenter {

    //MARK: Outlets
    
    @IBOutlet private weak var hidingMenuConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var showingMenuContraint: NSLayoutConstraint!
    
    @IBOutlet private weak var menuTableView: UITableView!
    
    //MARK: Variables
    
    private var showing = false
    
    private var presentingController: UIViewController?
    
    private var previouslySelectedPosition = -1
    
    //MARK: Viewcontroller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib.init(nibName: "MenuTableViewCell", bundle: nil) ,
                               forCellReuseIdentifier: StoryboardConstants.MenuTableViewCellIdentifier)
        loadControllerSelectedAtPosistion(0)
    }

    //MARK: Menu Actions
    
    private func slideMenuToTheLeft() {
        UIView.animate(withDuration: 0.3, animations: {
            self.showingMenuContraint.isActive = false
            self.hidingMenuConstraint.isActive = true
            self.view.layoutIfNeeded()
        })
    }
    
    private func slideMenuToTheRight() {
        UIView.animate(withDuration: 0.3, animations: {
            self.hidingMenuConstraint.isActive = false
            self.showingMenuContraint.isActive = true
            self.view.layoutIfNeeded()
        })
    }
    
    private func loadControllerSelectedAtPosistion(_ position: Int) {
        guard let menuOption = MenuOptions(rawValue: position) else {
            return
        }
        if previouslySelectedPosition == position {
            slideMenuToTheLeft()
        } else {
            previouslySelectedPosition = position
            switch menuOption {
            case .restaurantController:
                let restStoryBoard = UIStoryboard(name: StoryboardConstants.ResturanteMenuStoryboardIdentifier, bundle: nil)
                let restViewController = restStoryBoard.instantiateViewController(withIdentifier: StoryboardConstants.ResturanteMenuViewControllerIdentifier)
                (restViewController as? RestaurantViewController)?.menuPresenter = self
                presentMenuController(restViewController)
                title = "TOM Delivery"
            case .shoppingCartController:
                let shoppingCartStoryBoard = UIStoryboard(name: StoryboardConstants.ShoppingCartStoryboardIdentifier, bundle: nil)
                let shoppingCartViewController = shoppingCartStoryBoard.instantiateViewController(withIdentifier: StoryboardConstants.ShoppingCartViewControllerIdentifier)
                (shoppingCartViewController as? ShoppingCartViewController)?.menuPresenter = self
                presentMenuController(shoppingCartViewController)
                title = "Shopping cart"
            case .deliveriesController:
                let deliveriesStoryBoard = UIStoryboard(name: StoryboardConstants.DeliveriesStoryboardIdentifier, bundle: nil)
                let deliveriesViewController = deliveriesStoryBoard.instantiateViewController(withIdentifier: StoryboardConstants.DeliveriesViewControllerIdentifier)
                (deliveriesViewController as? DeliveriesViewController)?.menuPresenter = self
                presentMenuController(deliveriesViewController)
                title = "Deliveries"
            case .aboutController:
                let aboutStoryBoard = UIStoryboard(name: StoryboardConstants.AboutStoryboardIdentifier, bundle: nil)
                let aboutViewController = aboutStoryBoard.instantiateViewController(withIdentifier: StoryboardConstants.AboutViewControllerIdentifier)
                (aboutViewController as? AboutViewController)?.menuPresenter = self
                presentMenuController(aboutViewController)
                title = "About"
            }
        }
    }
    
    private func presentMenuController(_ controllerToPresent: UIViewController?) {
        guard let controller = controllerToPresent else {
            return
        }
        addNewMenuSelectionToView(controller)
    }
    
    private func addNewMenuSelectionToView(_ controllerToAdd: UIViewController) {
        let viewToAdd = controllerToAdd.view!
        var outSideFrame = viewToAdd.frame
        outSideFrame.origin = CGPoint(x: -view.bounds.width, y: 0.0)
        viewToAdd.frame = outSideFrame
        let previousPresentedController = presentingController
        presentingController = controllerToAdd
        self.addChildViewController(controllerToAdd)
        controllerToAdd.didMove(toParentViewController: self)
        UIView.animate(withDuration: 0.3, animations: {
            viewToAdd.frame = self.view.bounds
            self.view.insertSubview(viewToAdd, belowSubview: self.menuTableView)
            self.slideMenuToTheLeft()
            }) { (_) in
                previousPresentedController?.view.removeFromSuperview()
                previousPresentedController?.removeFromParentViewController()
        }
    }
    
    func showViewController(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = menuTableView.dequeueReusableCell(withIdentifier: StoryboardConstants.MenuTableViewCellIdentifier) as? MenuTableViewCell,
        let option = MenuOptions(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        cell.optionName = MenuOptions.nameFor(option: option)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showing = !showing
        self.loadControllerSelectedAtPosistion(indexPath.row)
    }
    
    //MARK: Actions
    
    func showHideMenu() {
        openMenu(self)
    }
    
    @IBAction func openMenu(_ sender: AnyObject) {
        if (showing) {
            slideMenuToTheLeft()
        } else {
            slideMenuToTheRight()
        }
        showing = !showing
    }
    
}
