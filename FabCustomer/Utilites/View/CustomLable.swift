//
//  CustomLable.swift
//  PetSafe
//
//  Created by samyotech on 15/12/17.
//  Copyright © 2017 samyotech. All rights reserved.
//

import UIKit


class CustomLable: UILabel {
    
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    override internal func awakeFromNib() {
        super.awakeFromNib()
        
        self.text = defaultLocalizer.stringForKey(key: (text!))
        //self.setTitle(defaultLocalizer.stringForKey(key: (titleLabel?.text!)!), for: .normal)
    }
    
}
