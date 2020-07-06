//
//  b.swift
//  Ubeaut
//
//  Created by Samyotech on 06/04/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
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
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.masksToBounds = true
            layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
            
        }
    }
    
    @IBInspectable var cornerRadiusByHeight: Bool = false {
        didSet {
            
            self.layer.masksToBounds = true
            layer.cornerRadius = self.frame.size.height/2
            
        }
    }
    
    @IBInspectable var roundButton: Bool = false {
        didSet {
            self.layer.masksToBounds = true
            layer.cornerRadius = self.frame.size.width / 2
            self.clipsToBounds = true
            
        }
    }
    
    
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        
        didSet {
            
            layer.shadowColor = shadowColor.cgColor
            layer.masksToBounds = false
        }
    }
    
    
    @IBInspectable var shadowOpacity: CGFloat = 0.0 {
        
        didSet {
            
            layer.shadowOpacity = Float(shadowOpacity.hashValue)
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        
        didSet {
            
            layer.shadowOpacity = Float(shadowRadius.hashValue)
            layer.masksToBounds = false
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
    }


    override internal func awakeFromNib() {
        super.awakeFromNib()
        
        self.setTitle(defaultLocalizer.stringForKey(key: (titleLabel?.text ?? " ")!  ), for: .normal)
    }
    
    
}




