//
//  ViesdsdswController.swift
//  FabCustomer
//
//  Created by Samyotech on 25/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit
// getAllCaegory


struct Get_All_Caegory: Decodable{
    
    
    var id          = ""
    var cat_name    = ""
    var price       = ""
    var created_at  = ""
    var updated_at  = ""
    var status      = ""
    
    private enum CodingKeys: String, CodingKey {
        
        case cat_name         = "cat_name"

        case price, created_at, updated_at,status,id
    }
}


   /* "id": "1",
    "cat_name": "Hair Stylist",
    "price": "500",
    "created_at": "1519878981",
    "updated_at": "1531991686",
    "status": "1"*/

