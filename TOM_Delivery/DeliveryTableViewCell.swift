//
//  DeliveryTableViewCell.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 11/6/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

class DeliveryTableViewCell: UITableViewCell, T_TimerDelegate {

    //MARK: Outlets
    
    @IBOutlet private weak var deliveryMostBoughtProductImageView: UIImageView!
    
    @IBOutlet private weak var deliveryDateLabel: UILabel!
    
    @IBOutlet private weak var deliveryTimerLabel: UILabel!
    
    @IBOutlet private weak var deliveryStatusLabel: UILabel!
    
    //MARK: Variables
    
    private var deliveryRemainingTime = 0 {
        didSet {
            let secondsRem = deliveryRemainingTime % 60
            let minutes = (deliveryRemainingTime - secondsRem) / 60
            let formatseconds = secondsRem < 10 ? "0\(secondsRem)" : "\(secondsRem)"
            let formatMinutes = minutes < 10 ? "0\(minutes)" : "\(minutes)"
            deliveryTimerLabel.text = "\(formatMinutes):\(formatseconds)"
        }
    }
    
    var deliveryDate: Date? {
        didSet {
            guard let date = deliveryDate else {
                return
            }
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            deliveryDateLabel.text = formatter.string(from: date)
        }
    }
    
    var deliveryStatus: String? {
        didSet {
            deliveryStatusLabel.text = deliveryStatus
        }
    }
    
    var onGoingDelivery = false {
        didSet {
            deliveryTimerLabel.isHidden = !onGoingDelivery
            deliveryStatusLabel.isHidden = onGoingDelivery
            if onGoingDelivery {
                startTimer()
            }
        }
    }
    
    var mostBoughtProductImageName =  "" {
        didSet{
            deliveryMostBoughtProductImageView.image = UIImage(named: mostBoughtProductImageName)
        }
    }
    
    private var devliveryTimer: T_Timer?
    
    //MARK: Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func stopDeliveryTimer() {
        devliveryTimer?.stopTimer()
    }
    
    //MARK: Timer
    
    private func startTimer() {
        guard let dvryDate = deliveryDate else {
            return
        }
        let seconds = dvryDate.timeIntervalSince(Date())
        devliveryTimer = T_Timer.fireTimerWith(seconds: seconds)
        devliveryTimer?.delegate = self
    }
    
    func timerUpdated(seconds: Double, timer: T_Timer) {
        print("Remaining seconds \(seconds)")
        deliveryRemainingTime = Int(seconds)
    }
    
    func timerFinished(timer: T_Timer) {
        onGoingDelivery = false
        deliveryStatusLabel.text = "DELIVERED"
    }
}
