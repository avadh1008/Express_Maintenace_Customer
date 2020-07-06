//
//  IOS_Devices.swift
//  Pixel eCommerce
//
//  Created by samyotech on 13/11/17.
//  Copyright © 2017 samyotech. All rights reserved.
//

import UIKit

class IOS_Device: NSObject {
    //MARK:- Check Device IPHONE
    
    static let kIphone_4s : Bool =  (UIScreen.main.bounds.size.height == 480)
    
    static let kIphone_5 : Bool =  (UIScreen.main.bounds.size.height == 568)
    
    static let kIphone_6 : Bool =  (UIScreen.main.bounds.size.height == 667)
    
    static let kIphone_6_Plus : Bool =  (UIScreen.main.bounds.size.height == 736)
    
    static let kIphone_X : Bool =  (UIScreen.main.bounds.size.height == 812.0)
}
