//
//  TablwereViewCell.swift
//  WEDDING_APP
//
//  Created by Samyotech on 03/09/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//


import Foundation
struct Get_Mony_his_Struct : Codable {
    let status : Int?
    let message : String?
    var mony_his_Arr : [Get_Mony_his_DataStruct]?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case message = "message"
        case mony_his_Arr = "data"
    }
   
    
}


struct Get_Mony_his_DataStruct  : Codable
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
    
    
    private enum CodingKeys: String, CodingKey
    {
        
        case  created_at = "created_at"
        case  user_id  = "user_id"
        case  invoice_id = "invoice_id"
        case  currency_type = "currency_type"
        case  id,type,status, amount,description
    }
    
    
}

