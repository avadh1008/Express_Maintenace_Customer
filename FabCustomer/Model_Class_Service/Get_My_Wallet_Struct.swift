//
//  File.swift
//  FabArtist
//
//  Created by apple on 03/11/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import Foundation


struct Get_My_Wallet_DataStruct  : Codable
{
    
    var amount = "Nan"
    
    var currency_type = "Nana"
    
    
    private enum CodingKeys: String, CodingKey
    {
        case  currency_type = "currency_type"
        case  amount
    }
    
    
}

import Foundation
struct Get_My_Wallet_Struct : Codable {
    let message : String?
    let my_Wallet_Data : Get_My_Wallet_DataStruct?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case message = "message"
        case my_Wallet_Data = "data"
        case status = "status"
    }
    
    
}

/*
 "data": {
 "amount": "17792.78",
 "currency_type": "$"
 }
 */
