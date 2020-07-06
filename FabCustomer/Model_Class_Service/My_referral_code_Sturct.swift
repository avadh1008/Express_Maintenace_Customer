//
//  vz.swift
//  FabCustomer
//
//  Created by AmitSharma on 25/07/19.
//


import Foundation

struct My_referral_code_Sturct : Codable {
    let message : String?
    let status : Int?
    let my_referral_code : My_referral_code?
    
    enum CodingKeys: String, CodingKey {
        
        case message = "message"
        case status = "status"
        case my_referral_code = "my_referral_code"
    }
    
}

struct My_referral_code : Codable {
    let code : String?
    let description : String?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "code"
        case description = "description"
    }
    
    
}
