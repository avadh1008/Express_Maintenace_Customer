//
//  File.swift
//  FabArtist
//
//  Created by AmitSharma on 18/07/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import Foundation


import Foundation


struct Chat_Struct : Codable {
    let status : Int?
    let message : String?
    var my_chat : [My_chat]?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case message = "message"
        case my_chat = "my_chat"
    }
    
    
    
}

/*
struct My_chat : Codable {
    let id : String?
    let message : String?
    let date : String?
    let sender_name : String?
    let user_id : String?
    let artist_id : String?
    let send_by : String?
    let send_at : String?
    let chat_type : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case message = "message"
        case date = "date"
        case sender_name = "sender_name"
        case user_id = "user_id"
        case artist_id = "artist_id"
        case send_by = "send_by"
        case send_at = "send_at"
        case chat_type = "chat_type"
        case image = "image"
    }
   
}



import Foundation*/
struct My_chat : Codable {
    let artistImage : String?
    let artistName : String?
    let send_by : String?
    let sender_name : String?
    let artist_id : String?
    let send_at : String?
    let message : String?
    let id : String?
    let chat_type : String?
    let user_id : String?
    let date : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case artistImage = "artistImage"
        case artistName = "artistName"
        case send_by = "send_by"
        case sender_name = "sender_name"
        case artist_id = "artist_id"
        case send_at = "send_at"
        case message = "message"
        case id = "id"
        case chat_type = "chat_type"
        case user_id = "user_id"
        case date = "date"
        case image = "image"
    }
    
  /*  init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artistImage = try values.decodeIfPresent(String.self, forKey: .artistImage)
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
        send_by = try values.decodeIfPresent(String.self, forKey: .send_by)
        sender_name = try values.decodeIfPresent(String.self, forKey: .sender_name)
        artist_id = try values.decodeIfPresent(String.self, forKey: .artist_id)
        send_at = try values.decodeIfPresent(String.self, forKey: .send_at)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        chat_type = try values.decodeIfPresent(String.self, forKey: .chat_type)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    */
}
