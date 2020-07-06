//
//  File.swift
//  FabCustomer
//
//  Created by AmitSharma on 22/07/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import Foundation

import Foundation
struct Banner : Codable {
    let id : String?
    let image : String?
    let created_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case image = "image"
        case created_at = "created_at"
    }
    
   
    
}


struct Category : Codable {
    let id : String?
    let cat_name : String?
    let price : String?
    let created_at : String?
    let image : String?
    let updated_at : String?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case cat_name = "cat_name"
        case price = "price"
        case created_at = "created_at"
        case image = "image"
        case updated_at = "updated_at"
        case status = "status"
    }
    
    
    
}



struct HomeDataDicStruct : Codable {
    var category : [Category]?
    var banner : [Banner]?
    
    enum CodingKeys: String, CodingKey {
        
        case category = "category"
        case banner = "banner"
    }
    
   
    
}


struct HomeDataStruct : Codable {
    let status : Int?
    let message : String?
    var homeDataDic : HomeDataDicStruct?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case message = "message"
        case homeDataDic = "data"
    }
    
  
    
}
