//
//  CustomLabel.swift
//  PetStand
//
//  Created by Samyotech on 10/07/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
@IBDesignable
class CustomLabel: UILabel {
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    /*
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
   */
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    override internal func awakeFromNib() {
        super.awakeFromNib()
        
        self.text = defaultLocalizer.stringForKey(key: (text!))
        //self.setTitle(defaultLocalizer.stringForKey(key: (titleLabel?.text!)!), for: .normal)
    }
}
