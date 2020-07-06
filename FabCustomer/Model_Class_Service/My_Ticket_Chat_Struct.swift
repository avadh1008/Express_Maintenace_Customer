//
//  cz.swift
//  BeeBeeClean
//
//  Created by AmitSharma on 24/03/19.
//  Copyright © 2019 AmitSharma. All rights reserved.
//

import Foundation

struct My_Ticket_Chat_Data_Struct  : Codable
{
    var id = ""
    var ticket_id = ""
    var comment = ""
    var role = ""
    var user_id = ""
    var created_at = ""
    var userName = ""
    
    private enum CodingKeys: String, CodingKey
    {
        case  ticket_id = "ticket_id"
        case  user_id = "user_id"
        case  created_at = "created_at"
        case id , comment, role, userName
        
    }
    
}


struct My_Ticket_Chat_Struct : Codable {
    
    var status  = 0
    var message  = "Decode Error"
    
    var My_Ticket_Chat_Arr  = [My_Ticket_Chat_Data_Struct]()
    
    private enum CodingKeys: String, CodingKey
    {
        case My_Ticket_Chat_Arr = "ticket_comment"
        
        case message , status
    }
    
}
