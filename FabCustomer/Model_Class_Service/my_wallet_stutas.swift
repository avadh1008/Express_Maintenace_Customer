//
//  Fild fasdfsdfsadfsdf sdf .swift
//  BeeBeeClean
//
//  Created by AmitSharma on 23/03/19.
//  Copyright © 2019 AmitSharma. All rights reserved.
//

import Foundation

/*{
    "status": 1,
    "message": "Get my wallet.",
    "data": {
        "amount": "0",
        "currency_type": "$"
    }
}*/



struct my_wallet_Struct : Codable {
    
    var status  = 0
    var message  = "Decode Error"
    var my_wallet  = my_wallet_data_Struct()
    
    
    private enum CodingKeys: String, CodingKey
    {
        
         case my_wallet = "data"
        case message , status
    }
    
}

struct my_wallet_data_Struct : Codable {
    
     var amount = ""
     var currency_type  = ""
    
    
    
    
    private enum CodingKeys: String, CodingKey
    {
        case currency_type = "currency_type"
        case amount
    }
    
}
