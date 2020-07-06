//
//  sdasdTableViewCell.swift
//  FabCustomer
//
//  Created by Samyotech on 25/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit


struct Get_applied_job_by_id_Struct: Decodable{
    
    var aj_id           = "0"
    var user_id         = "0"
    var artist_id       = "0"
    var job_id          = "0"
    var description     = "0"
    var status          = "0"
    var created_at      = "0"
    var updated_at      = "0"
    var artist_image    = "0"
    var artist_name     = "0"
    var category_name   = "0"
    var category_price  = "0"
    var artist_address  = "0"
    var artist_mobile   = "0"
    var artist_email    = "0"
    var price = "0"
    var ava_rating      = 0
    var currency_symbol = "0"
    var job_timestamp = "0"
    
   
    private enum CodingKeys: String, CodingKey {
        
        case aj_id              = "aj_id"
        case user_id            = "user_id"
        case artist_id          = "artist_id"
        case job_id             = "job_id"
        case created_at         = "created_at"
        case updated_at         = "updated_at"
        case artist_image       = "artist_image"
        case artist_name        = "artist_name"
        case category_name      = "category_name"
        case category_price     = "category_price"
        case artist_address     = "artist_address"
        case artist_mobile      = "artist_mobile"
        case artist_email       = "artist_email"
        case price = "price"
        case  currency_symbol = "currency_symbol"
        case ava_rating         = "ava_rating"
        case job_timestamp = "job_timestamp"
        case description , status
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ava_rating = try Int(values.decodeIfPresent(Double.self, forKey: .ava_rating) ?? 0)
        aj_id = (try values.decodeIfPresent(String.self, forKey: .aj_id))!
         user_id = (try values.decodeIfPresent(String.self, forKey: .user_id))!
         artist_id = (try values.decodeIfPresent(String.self, forKey: .artist_id))!
        job_id = (try values.decodeIfPresent(String.self, forKey: .job_id))!
         created_at = (try values.decodeIfPresent(String.self, forKey: .created_at))!
         updated_at = (try values.decodeIfPresent(String.self, forKey: .updated_at))!
         artist_image = (try values.decodeIfPresent(String.self, forKey: .artist_image))!
         artist_name = (try values.decodeIfPresent(String.self, forKey: .artist_name))!
          category_name = (try values.decodeIfPresent(String.self, forKey: .category_name))!
         category_price = (try values.decodeIfPresent(String.self, forKey: .category_price))!
        artist_address = (try values.decodeIfPresent(String.self, forKey: .artist_address))!
        artist_mobile = (try values.decodeIfPresent(String.self, forKey: .artist_mobile))!
        artist_email = (try values.decodeIfPresent(String.self, forKey: .artist_email))!
        status = (try values.decodeIfPresent(String.self, forKey: .status))!
        description = (try values.decodeIfPresent(String.self, forKey: .description))!
        price = (try values.decodeIfPresent(String.self, forKey: .price))!
        currency_symbol = (try values.decodeIfPresent(String.self, forKey: .currency_symbol))!
        job_timestamp = (try values.decodeIfPresent(String.self, forKey: .job_timestamp))!
    }
}


struct Get_Single_Invoice: Decodable{
    
    var id           = "0"
    var artist_id         = "0"
    var invoice_id       = "0"
    var user_id          = "0"
    var booking_id     = "0"
    var working_min          = "0"
    var total_amount      = "0"
    var artistName = "0"
    var created_at  =  "0"
    var artistImage  =  "0"
    var currency_type = "0"
    var category_name = "0"
    
    private enum CodingKeys: String, CodingKey {
        
        case id              = "id"
        case artist_id            = "artist_id"
        case invoice_id          = "invoice_id"
        case user_id             = "user_id"
        case booking_id         = "booking_id"
        case working_min         = "working_min"
        case total_amount       = "total_amount"
        case artistName        = "artistName"
        case created_at     = "created_at"
        case artistImage     = "artistImage"
        case currency_type = "currency_type"
        case category_name = "category_name"

    }
/*    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = (try values.decodeIfPresent(String.self, forKey: .id))!
        artist_id = (try values.decodeIfPresent(String.self, forKey: .artist_id))!
        invoice_id = (try values.decodeIfPresent(String.self, forKey: .invoice_id))!
        user_id = (try values.decodeIfPresent(String.self, forKey: .user_id))!
        booking_id = (try values.decodeIfPresent(String.self, forKey: .booking_id))!
        working_min = (try values.decodeIfPresent(String.self, forKey: .working_min))!
        total_amount = (try values.decodeIfPresent(String.self, forKey: .total_amount))!
        artistName = (try values.decodeIfPresent(String.self, forKey: .artistName))!
        created_at = (try values.decodeIfPresent(String.self, forKey: .created_at))!
        artistImage = (try values.decodeIfPresent(String.self, forKey: .artistImage))!
           currency_type = (try values.decodeIfPresent(String.self, forKey: .currency_type))!
        category_name = (try values.decodeIfPresent(String.self, forKey: .category_name))!
      
    }*/
}

/*
{
    "aj_id": "1",
    "user_id": "9",
    "artist_id": "15",
    "job_id": "M8DMEZ",
    "description": "I want this job",
    "status": "4",
    "created_at": "2018-07-24 05:34:39",
    "updated_at": "0000-00-00 00:00:00",
    "artist_image": "http://phpstack-132936-544601.cloudwaysapps.com/assets/images/1530711610.jpeg",
    "artist_name": "Pankaj ",
    "category_name": "Electrician",
    "category_price": "1",
    "artist_address": "cjccjjf",
    "artist_mobile": "7000919818",
    "artist_email": "varun@samyotech.com",
    "ava_rating": 5
}
*/
/*
{
    "aj_id": "2",
    "user_id": "9",
    "artist_id": "15",
    "job_id": "BMXI9Z",
    "description": "fkj",
    "status": "0",
    "created_at": "2018-07-26 05:49:47",
    "updated_at": "0000-00-00 00:00:00",
    "artist_image": "http://phpstack-132936-544601.cloudwaysapps.com/assets/images/1532525778.png",
    "artist_name": "Pankaj",
    "category_name": "Hair Stylist",
    "category_price": "500",
    "artist_address": "cjccjjf",
    "artist_mobile": "7000919818",
    "artist_email": "varun@samyotech.com",
    "ava_rating": 5
}*/

