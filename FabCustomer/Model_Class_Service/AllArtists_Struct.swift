//
//  sdfsdffdss.swift
//  FabCustomer
//
//  Created by AmitSharma on 25/07/19.
//

import Foundation

import Foundation
struct AllArtists_Struct : Codable {
    var message : String?
    var artists_Arr = [AllArtists_DataStruct]()
    var status : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case message = "message"
        case artists_Arr = "data"
        case status = "status"
    }
    
    
    
}

import Foundation
struct AllArtists_DataStruct : Codable {
    var currency_type : String?
    var featured = ""
    var update_profile : String?
    var description : String?
    var created_at : String?
    var commission_type : String?
    var fav_status = ""
    var price = ""
    var last_name : String?
    var percentages : Int?
    var artist_commission_type : String?
    var total : Int?
    var jobDone = 0
    var preference : String?
    var updated_at : String?
    var distance : String?
    var ava_rating = 0.0
    var bio : String?
    var latitude : String?
    var skill_text : String?
    var booking_flag : String?
    var banner_image : String?
    var country : String?
    var city : String?
    var category_id : String?
    var flat_type : String?
    var location : String?
    var category_name : String?
    var name : String?
    var live_lat : String?
    var image : String?
    var user_id : String?
    var video_url : String?
    var skills : String?
    var live_long : String?
    var is_online : String?
    var about_us : String?
    var completion_rate : String?
    var id : String?
    var category_price : String?
    var gender : String?
    var longitude : String?
    
    enum CodingKeys: String, CodingKey {
        
        case currency_type = "currency_type"
        case featured = "featured"
        case update_profile = "update_profile"
        case description = "description"
        case created_at = "created_at"
        case commission_type = "commission_type"
        case fav_status = "fav_status"
        case price = "price"
        case last_name = "last_name"
        case percentages = "percentages"
        case artist_commission_type = "artist_commission_type"
        case total = "total"
        case jobDone = "jobDone"
        case preference = "preference"
        case updated_at = "updated_at"
        case distance = "distance"
        case ava_rating = "ava_rating"
        case bio = "bio"
        case latitude = "latitude"
        case skill_text = "skill_text"
        case booking_flag = "booking_flag"
        case banner_image = "banner_image"
        case country = "country"
        case city = "city"
        case category_id = "category_id"
        case flat_type = "flat_type"
        case location = "location"
        case category_name = "category_name"
        case name = "name"
        case live_lat = "live_lat"
        case image = "image"
        case user_id = "user_id"
        case video_url = "video_url"
        case skills = "skills"
        case live_long = "live_long"
        case is_online = "is_online"
        case about_us = "about_us"
        case completion_rate = "completion_rate"
        case id = "id"
        case category_price = "category_price"
        case gender = "gender"
        case longitude = "longitude"
    }
    
    
    
}
