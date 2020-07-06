//
//  sdfsfa.swift
//  WEDDING_APP
//
//  Created by Samyotech on 03/09/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

// guest_type
struct Get_Guest_Type_Struct  : Decodable
{
    var id = "Nan"
    var type = "Nan"
    var created_at = "Nan"
    var status = "Nan"
    var currency_type = "Nana"
    var invoice_id = "Nana"
    var amount = "Nana"
    var description = "Nana"
    var user_id = "Nana"
    var user_dsfid = "Nana"
    
    private enum CodingKeys: String, CodingKey
    {
       
        case  created_at = "created_at"
        case  user_id  = "user_id"
        case  invoice_id = "invoice_id"
        case  currency_type = "currency_type"
        case  id,type,status, amount,description
    }
    
}
/*
 
 "id": "29",
 "user_id": "1",
 "description": "Booking invoice",
 "amount": "50",
 "invoice_id": "NREXDH4XBJDZ",
 "currency_type": "$",
 "type": "2",
 "status": "1",
 "order_id": "1541061992",
 "created_at": "1541061992"
 
 */
