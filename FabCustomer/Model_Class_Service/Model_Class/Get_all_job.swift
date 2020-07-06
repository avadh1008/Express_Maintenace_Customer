//
//  TableViesdwCell.swift
//  FabCustomer
//
//  Created by Samyotech on 24/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

struct Get_all_job: Decodable{
    
    
    var id          = "0"
    var job_id      = "0"
    var user_id     = "0"
    var title       = "0"
    var description = "0"
    var category_id = "0"
    var status      = "0"
    var avtar       = "0"
    var address     = "0"
    var lati        = "0"
    var longi       = "0"
    var created_at  = "0"
    var updated_at  = "0"
    var category_name   = "0"
    var category_price  = "0"
    var price        =  "0"
    var currency_symbol = "0"
    var is_edit = 0
    
    
    
    
  
    
    private enum CodingKeys: String, CodingKey {
        
        case job_id         = "job_id"
        case user_id        = "user_id"
        case category_id    = "category_id"
        case created_at     = "created_at"
        case updated_at     = "updated_at"
        case category_name  = "category_name"
        case category_price = "category_price"
        
        
        
        
        case id , title , status , avtar , address , lati , longi , description , price , currency_symbol,is_edit
    }
}

/*
 {
 "id": "4",
 "job_id": "KB8QNM",
 "user_id": "96",
 "title": "light fitting",
 "description": "sjcjvjvklxlzmcn vkkakdkzmxcm",
 "category_id": "6",
 "status": "0",
 "avtar": "http://phpstack-132936-544601.cloudwaysapps.com/assets/images/1532411426.jpg",
 "address": "MR 10 Service Road, Sheetal Nagar, Indore, Madhya Pradesh 452011, India",
 "lati": "22.749753",
 "longi": "75.89973599999999",
 "created_at": "2018-07-24 05:50:26",
 "updated_at": "0000-00-00 00:00:00",
 "category_name": "Electrician",
 "category_price": "1",
 "user_image": "http://phpstack-132936-544601.cloudwaysapps.com/",
 "user_name": "c",
 "user_address": "",
 "user_mobile": ""
 }
 */
/*
 "id": "6",
 "job_id": "FQTGAL",
 "user_id": "9",
 "title": "Samyotech",
 "description": "At Samyotech, we like to collaborate with our clients and get them involved in the project development process",
 "category_id": "1",
 "status": "0",
 "avtar": "http://phpstack-132936-544601.cloudwaysapps.com/assets/images/1532514667.png",
 "address": "Samyotech Labs, Sheetal Nagar, Indore, Madhya Pradesh",
 "lati": "22.754645",
 "longi": "75.898703",
 "created_at": "2018-07-25 10:31:07",
 "updated_at": "0000-00-00 00:00:00",
 "category_name": "Hair Stylist",
 "category_price": "500"
 */
