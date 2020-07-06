//
//  Filesdf.swift
//  Key_Market
//
//  Created by AmitSharma on 10/12/18.
//  Copyright © 2018 apple. All rights reserved.
//

import Foundation

/*
 
 "my_chat" : [
 {
 "userImage" : "http:\/\/uuclean.com\/assets\/images\/1554252316.png",
 "send_by" : "1",
 "artist_id" : "17",
 "user_id" : "15",
 "chat_type" : "1",
 "send_at" : "1555300619",
 "userName" : "Amol",
 "sender_name" : "Amol",
 "message" : " Hi",
 "image" : "",
 "id" : "1",
 "date" : "1555300619"
 }
 ],
 */
struct my_chat_history_Data_Struct  : Codable
{
    
    
    var userImage  : String?
  var send_by = ""
  var artist_id = ""
  var user_id = ""
  var chat_type = ""
  var send_at  = ""
  var userName  = ""
  var sender_name  = ""
  var message = ""
  var image = ""
  var id = ""
  var date = ""
    
    
    
    
    
    private enum CodingKeys: String, CodingKey
    {
      
    
      case  send_by = "send_by"
      case  artist_id = "artist_id"
      case  user_id = "user_id"
      case  chat_type = "chat_type"
      case  send_at  = "send_at"
    
      case  sender_name  = "sender_name"
      case  message ,  image , id , date ,  userImage ,    userName
        
      
    }
    
}

struct my_chat_history_Struct : Codable {
    
    var status  = 0
    var message  = "Decode Error"
    
    var my_chat_history_Arr  = [my_chat_history_Data_Struct]()
    
    private enum CodingKeys: String, CodingKey
    {
        case my_chat_history_Arr = "my_chat"
        case message , status
    }
    
}

/*
 {
 "status": 1,
 "message": "Get chat history.",
 "my_chat": [
 {
 "id": "149",
 "message": "koo",
 "date": "1553326915",
 "sender_name": "thizmorning",
 "user_id": "64",
 "artist_id": "5",
 "send_by": "1",
 "send_at": "1553326915",
 "chat_type": "2",
 "image": "",
 "artistName": null,
 "artistImage": "http://uuclean.com/assets/images/image.png"
 }
 ]
 }
 
 */


/*

 
 "date" : "1551947978",
 "userImage" : "http:\/\/phpstack-225750-688566.cloudwaysapps.com\/assets\/images\/1547792846.jpg",
 "user_id_receiver" : "1",
 "thumb" : "",
 "chat_state" : "0",
 "sender_name" : "duped",
 "user_id" : "58",
 "media" : "",
 "latitude" : "0",
 "chat_type" : "1",
 "longitude" : "0",
 "id" : "212",
 "message" : "Hi",
 "userName" : "Mak"
 

 */
