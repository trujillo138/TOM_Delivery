//
//  DeliveriesViewController.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/23/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

class DeliveriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Outlets
    
    @IBOutlet private weak var deliveriesTableView: UITableView!
    
    //MARK: Variables
    
    var menuPresenter: MenuControllerPresenter?
    
    private lazy var deliveries = API.deliveries
    
    private struct DeliveriesVCConstants {
        static let DeliveryCellIdentifier = "Delivery table view cell"
    }
    
    //MARK: Viewcontroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        deliveriesTableView.dataSource = self
        deliveriesTableView.delegate = self
        deliveriesTableView.register(UINib(nibName: "DeliveryTableViewCell", bundle: nil), forCellReuseIdentifier: DeliveriesVCConstants.DeliveryCellIdentifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    //MARK: TableView Datasource and delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = deliveriesTableView.dequeueReusableCell(withIdentifier: DeliveriesVCConstants.DeliveryCellIdentifier) as? DeliveryTableViewCell else {
            return UITableViewCell()
        }
        let delivery = deliveries[indexPath.row]
        cell.deliveryDate = delivery.deliveryDate
        cell.mostBoughtProductImageName = delivery.mostBoughtProduct?.name ?? ""
        if delivery.deliveryDate.compare(Date()) == .orderedDescending {
            cell.onGoingDelivery = true
        } else {
            cell.onGoingDelivery = false
            if delivery.sate == .cancelled {
                cell.deliveryStatus = "CANCELLED"
            } else {
                cell.deliveryStatus = "DELIVERED"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let deliveryCell = cell as? DeliveryTableViewCell  else {
            return
        }
        deliveryCell.stopDeliveryTimer()
    }
    
}
