//
//  sdfsdfsdfsf.swift
//  BeeBeeClean
//
//  Created by AmitSharma on 23/03/19.
//  Copyright © 2019 AmitSharma. All rights reserved.
//

import Foundation


struct my_notifications_Struct : Codable {
    
    var status  = 0
    var message  = "Decode Error"
    
    var my_notifications_Arr  = [my_notifications_Data_Struct]()
    
    
    private enum CodingKeys: String, CodingKey
    {
        case my_notifications_Arr = "my_notifications"
        
        case message , status
    }
    
}

struct my_notifications_Data_Struct: Codable{
    
    
  var  id = ""
  var  user_id = ""
  var  title = ""
  var  type = ""
  var  msg = ""
    var  created_at : String?
    
    
    private enum CodingKeys: String, CodingKey
    {
      case id ,title , type, msg
      case user_id = "user_id"
      case created_at = "created_at"
   
    }
    
}

/*
 {
 "status": 1,
 "message": "Get my notifications.",
 "my_notifications": [
 {
 "id": "408",
 "user_id": "0",
 "title": "aa",
 "type": "All",
 "msg": "aa",
 "created_at": "1551782166"
 },
 */
