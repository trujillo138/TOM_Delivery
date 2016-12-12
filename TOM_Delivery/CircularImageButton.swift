//
//  CircularImageButton.swift
//  TOM_Delivery
//
//  Created by Tomas Trujillo on 10/27/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

enum CirculaImageButtonType {
    case add
    case remove
    case buy
}

protocol CircularImageButtonDelegate {
    func pressedButtonWith(type: CirculaImageButtonType)
}

class CircularImageButton: UIView {

    //MARK: Variables
    
    private var imageView: UIImageView?
    
    var imageName: String?
    
    var buttonType: CirculaImageButtonType?
    
    var delegate: CircularImageButtonDelegate?
    
    //MARK: Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView == nil {
            imageView = UIImageView(frame: bounds)
            addSubview(imageView!)
        } else {
            imageView?.frame = bounds
        }
        imageView?.image = UIImage(named: imageName ?? "")
    }
    
    private func setup() {
        isOpaque = false
        backgroundColor = UIColor.clear
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pressedButton)))
    }

    //MARK: Gestures
    
    func pressedButton(tapGesture: UIGestureRecognizer) {
        guard let type = buttonType else {
            return
        }
        delegate?.pressedButtonWith(type: type)
        animateView(view: self)
    }
    
    //MARK: Animations
    
    private func animateView(view: UIView) {
        let scale: CGFloat = 1.1
        UIView.animate(withDuration: 0.1, animations: {
            view.transform = CGAffineTransform(scaleX: scale, y: scale)
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, animations: {
                    view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    }, completion: nil)
        })
    }
    
    private func transformView(_ view: UIView, size: CGSize, toPoint: CGPoint) {
        var frame = view.frame
        frame.size = size
        frame.origin = toPoint
        view.frame = frame
    }
    
}
