//
//  TabsdfsdfleViewCell.swift
//  FabCustomer
//
//  Created by Samyotech on 26/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit
//getAllArtists

struct Get_All_Artists_Struct: Decodable{
    
   
    
    var id                      = "0"
    var user_id                 = "0"
    var name                    = "0"
    var category_id             = "0"
    var description             = "0"
    var about_us                = "0"
    var skills                  = "0"
    var image                   = "0"
    var completion_rat          = "0"
    var featured                = "0"
    var created_at              = "0"
    var updated_at              = "0"
    var bio                     = "0"
    var longitude               = "0"
    var latitude                = "0"
    var location                = "0"
    var video_url               = "0"
    var price                   = "0"
    var booking_flag            = "0"
    var is_online               = "0"
    var gender                  = "0"
    var preference              = "0"
    var update_profile          = "0"
    var total                   = "0"
    var percentages             =  0
    var jobDone                 = "0"
    var category_name           = "0"
    var category_price          = "0"
    var distance                = "0"
    var ava_rating              = "0"
    var fav_status              = "0"
    
    private enum CodingKeys: String, CodingKey {

       
        case user_id            = "user_id"
        case category_id        = "category_id"
        case about_us           = "about_us"
        case completion_rat     = "completion_rat"
        case created_at         = "created_at"
        case updated_at         = "updated_at"
        case video_url          = "video_url"
        case booking_flag       = "booking_flag"
        case is_online          = "is_online"
        case update_profile     = "update_profile"
        case category_name      = "category_name"
        case category_price     = "category_price"
        case ava_rating         = "ava_rating"
        case fav_status         = "fav_status"
        
        
        case id, name, description, skills, image, featured, bio, longitude, latitude ,   location, price, gender, preference, total, percentages, jobDone, distance
    }
}


/*
 {
 "id": "8",
 "user_id": "14",
 "name": "Hugo",
 "category_id": "2",
 "description": "",
 "about_us": "Svb",
 "skills": "[\r\n  3,\r\n  4\r\n]",
 "image": "http://phpstack-132936-544601.cloudwaysapps.com/assets/images/1530692882.png",
 "completion_rate": "0",
 "featured": "0",
 "created_at": "1530620219",
 "updated_at": "1530701325",
 "bio": "Do",
 "longitude": "75.8986339",
 "latitude": "22.7494152",
 "location": "Shree Paras Deep Girls Hostel",
 "video_url": "",
 "price": "13",
 "booking_flag": "0",
 "is_online": "1",
 "gender": "0",
 "preference": "0",
 "update_profile": "1",
 "total": 12,
 "percentages": 8,
 "jobDone": 1,
 "category_name": "Makeup Artist",
 "category_price": "10",
 "distance": "0",
 "ava_rating": 0,
 "fav_status": "0"
 }
 */
