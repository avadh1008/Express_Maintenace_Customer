//
//  TableViaasdasewCell.swift
//  
//
//  Created by Samyotech on 24/07/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

struct Get_Stutas : Decodable {
    
    var status  = 0
    var message  = ""
    
    
    
}


struct CouponVal_stutas : Codable {
    
    var status  = 0
    var message  = ""
    
    
    
    // "status": 1,
    ///"message": "Applied successfully.",
    var final_amount = 0.0
    var discount_amount = "0"
    private enum CodingKeys: String, CodingKey
    {
        
        case final_amount = "final_amount"
        case discount_amount = "discount_amount"
        case message , status
    }
    
}
