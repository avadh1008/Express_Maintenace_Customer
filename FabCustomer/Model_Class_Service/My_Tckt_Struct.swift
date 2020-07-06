//
//  assdddfr.swift
//  BeeBeeClean
//
//  Created by AmitSharma on 24/03/19.
//  Copyright © 2019 AmitSharma. All rights reserved.
//

import Foundation




struct My_Tckt_Data_Struct  : Codable
{
    
    var id = ""
    var user_id = ""
    var reason = ""
    var status : String?
    var craeted_at : String?
    var description = ""
    
    private enum CodingKeys: String, CodingKey
    {
        
        case  user_id = "user_id"
        case  craeted_at = "craeted_at"
        case id, reason, status ,description
        
    }
    
}

struct My_Tckt_Struct : Codable {
    
    var status  = 0
    var message  = "Decode Error"
    
    var my_Tckt_Arr  = [My_Tckt_Data_Struct]()
    
    private enum CodingKeys: String, CodingKey
    {
        case my_Tckt_Arr = "my_ticket"
        
        case message , status
    }
    
}
