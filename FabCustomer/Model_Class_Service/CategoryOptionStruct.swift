//
//  cate asd as.swift
//  FabArtist
//
//  Created by AmitSharma on 27/06/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import Foundation
struct CategoryOptionStruct : Codable {
    
    var status : Int?
    var categoryArr = [CategoryOptionData]()
    var message : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case categoryArr = "data"
        case message = "message"
    }
 
}
struct CategoryOptionData : Codable {
    
    
    
    var currency_type = ""
    var created_at = ""
    var cat_name = ""
    var updated_at = ""
    var status = ""
    var id = ""
    var price = ""
    
    
    
    enum CodingKeys: String, CodingKey {
        
        
       case currency_type = "currency_type"
       case created_at = "created_at"
       case cat_name = "cat_name"
       case updated_at = "updated_at"
       case status , id , price
        
      
    }
    
}
/*
 {
 "message" : "Get all Categories",
 "data" : [
 {
 "currency_type" : "$",
 "created_at" : "1519878981",
 "cat_name" : "IT SUPPORT",
 "updated_at" : "1557714656",
 "status" : "1",
 "id" : "1",
 "price" : "5"
 },
 {
 "currency_type" : "$",
 "created_at" : "1519878981",
 "cat_name" : "Hair Stylist",
 "updated_at" : "1538986457",
 "status" : "1",
 "id" : "2",
 "price" : "5"
 },
 {
 "currency_type" : "$",
 "created_at" : "1530347882",
 "cat_name" : "Nail Technician",
 "updated_at" : "1559917760",
 "status" : "1",
 "id" : "3",
 "price" : "5"
 },
 {
 "currency_type" : "$",
 "created_at" : "1531509437",
 "cat_name" : "Home Cleaning & Repairs",
 "updated_at" : "1560609112",
 "status" : "1",
 "id" : "6",
 "price" : "5"
 },
 {
 "currency_type" : "$",
 "created_at" : "1559917672",
 "cat_name" : "Designer Interior",
 "updated_at" : "1559917672",
 "status" : "1",
 "id" : "60",
 "price" : "5"
 },
 {
 "currency_type" : "$",
 "created_at" : "1560419052",
 "cat_name" : "Band",
 "updated_at" : "1560419052",
 "status" : "1",
 "id" : "61",
 "price" : "5"
 },
 {
 "currency_type" : "$",
 "created_at" : "1560432312",
 "cat_name" : "teste",
 "updated_at" : "1560432312",
 "status" : "1",
 "id" : "62",
 "price" : "5"
 },
 {
 "currency_type" : "$",
 "created_at" : "1561363343",
 "cat_name" : "cleaners",
 "updated_at" : "1561363343",
 "status" : "1",
 "id" : "63",
 "price" : "5"
 }
 ],
 "status" : 1
 }
 */
