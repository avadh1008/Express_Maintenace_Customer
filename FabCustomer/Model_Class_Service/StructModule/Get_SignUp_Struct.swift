//
//  adsfasdfdfdfViewController.swift
//  WEDDING_APP
//
//  Created by Samyotech on 24/08/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

//userAuthontication

struct Get_SignUp_Struct : Codable {
    
    let status : Int?
    let message : String?
    var SignUdata : Get_SignUpData_Struct?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case message = "message"
        case SignUdata = "data"
    }
    
}



struct Get_SignUpData_Struct : Codable {
   var user_id : String?
   var name : String?
   var email_id : String?
   var password : String?
   var image : String?
   var address : String?
   var office_address : String?
   var live_lat : String?
   var live_long : String?
   var role : String?
   var status : String?
   var approval_status : String?
   var created_at : String?
   var mobile : String?
   var referral_code : String?
   var user_referral_code : String?
   var gender : String?
   var city : String?
   var country : String?
   var updated_at : String?
   var device_type : String?
   var device_id : String?
   var device_token : String?
   var latitude : String?
   var longitude : String?
   var i_card : String?
   var country_code : String?
   var mobile_no : String?
   var bank_name : String?
   var account_no : String?
   var ifsc_code : String?
   var account_holder_name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case user_id = "user_id"
        case name = "name"
        case email_id = "email_id"
        case password = "password"
        case image = "image"
        case address = "address"
        case office_address = "office_address"
        case live_lat = "live_lat"
        case live_long = "live_long"
        case role = "role"
        case status = "status"
        case approval_status = "approval_status"
        case created_at = "created_at"
        case mobile = "mobile"
        case referral_code = "referral_code"
        case user_referral_code = "user_referral_code"
        case gender = "gender"
        case city = "city"
        case country = "country"
        case updated_at = "updated_at"
        case device_type = "device_type"
        case device_id = "device_id"
        case device_token = "device_token"
        case latitude = "latitude"
        case longitude = "longitude"
        case i_card = "i_card"
        case country_code = "country_code"
        case mobile_no = "mobile_no"
        case bank_name = "bank_name"
        case account_no = "account_no"
        case ifsc_code = "ifsc_code"
        case account_holder_name = "account_holder_name"
    }
    

    
}
class SignUpDataClass : NSObject {
    
    var signUpData : Get_SignUp_Struct?
    class var shareMngr : SignUpDataClass{
        struct staticVal {
            static let instance = SignUpDataClass()
        }
        return staticVal.instance
    }
    
}
