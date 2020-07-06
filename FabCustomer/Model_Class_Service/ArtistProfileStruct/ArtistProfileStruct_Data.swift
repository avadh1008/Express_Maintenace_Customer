/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ArtistProfileStruct_Data : Codable {
    var id : String?
    var user_id : String?
    var name : String?
    var category_id : String?
    var description : String?
    var about_us : String?
    
    var image : String?
    var completion_rate : String?
    var featured : String?
    var created_at : String?
    var updated_at : String?
    var bio : String?
    var longitude : String?
    var latitude : String?
    var location : String?
    var live_lat : String?
    var live_long : String?
    var city : String?
    var country : String?
    var video_url : String?
    var price : String?
    var booking_flag : String?
    var artist_commission_type : String?
    var is_online : String?
    var gender : String?
    var preference : String?
    var update_profile : String?
    var banner_image : String?
    var category_name : String?
    var currency_type : String?
    var commission_type : String?
    var flat_type : String?
    var category_price : String?
    var ava_rating = 0.0
    
    //var skills : [skil]?
    var products : [Products]?
    var reviews : [Reviews]?
    var gallery : [Gallery]?
    var qualifications : [Qualifications]?
    var artist_booking : [Artist_booking]?
    
    var earning = 0.0
    var jobDone : Int?
    var totalJob : Int?
    var completePercentages : Int?
    var fav_status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_id = "user_id"
        case name = "name"
        case category_id = "category_id"
        case description = "description"
        case about_us = "about_us"
        //case skills = "skills"
        case image = "image"
        case completion_rate = "completion_rate"
        case featured = "featured"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case bio = "bio"
        case longitude = "longitude"
        case latitude = "latitude"
        case location = "location"
        case live_lat = "live_lat"
        case live_long = "live_long"
        case city = "city"
        case country = "country"
        case video_url = "video_url"
        case price = "price"
        case booking_flag = "booking_flag"
        case artist_commission_type = "artist_commission_type"
        case is_online = "is_online"
        case gender = "gender"
        case preference = "preference"
        case update_profile = "update_profile"
        case banner_image = "banner_image"
        case category_name = "category_name"
        case currency_type = "currency_type"
        case commission_type = "commission_type"
        case flat_type = "flat_type"
        case category_price = "category_price"
        case ava_rating = "ava_rating"
        case products = "products"
        case reviews = "reviews"
        case gallery = "gallery"
        case qualifications = "qualifications"
        case artist_booking = "artist_booking"
        case earning = "earning"
        case jobDone = "jobDone"
        case totalJob = "totalJob"
        case completePercentages = "completePercentages"
        case fav_status = "fav_status"
    }
  /*
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        category_id = try values.decodeIfPresent(String.self, forKey: .category_id)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        about_us = try values.decodeIfPresent(String.self, forKey: .about_us)
        skills = try values.decodeIfPresent([String].self, forKey: .skills)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        completion_rate = try values.decodeIfPresent(String.self, forKey: .completion_rate)
        featured = try values.decodeIfPresent(String.self, forKey: .featured)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        live_lat = try values.decodeIfPresent(String.self, forKey: .live_lat)
        live_long = try values.decodeIfPresent(String.self, forKey: .live_long)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        video_url = try values.decodeIfPresent(String.self, forKey: .video_url)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        booking_flag = try values.decodeIfPresent(String.self, forKey: .booking_flag)
        artist_commission_type = try values.decodeIfPresent(String.self, forKey: .artist_commission_type)
        is_online = try values.decodeIfPresent(String.self, forKey: .is_online)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        preference = try values.decodeIfPresent(String.self, forKey: .preference)
        update_profile = try values.decodeIfPresent(String.self, forKey: .update_profile)
        banner_image = try values.decodeIfPresent(String.self, forKey: .banner_image)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        currency_type = try values.decodeIfPresent(String.self, forKey: .currency_type)
        commission_type = try values.decodeIfPresent(String.self, forKey: .commission_type)
        flat_type = try values.decodeIfPresent(String.self, forKey: .flat_type)
        category_price = try values.decodeIfPresent(String.self, forKey: .category_price)
        ava_rating = try values.decodeIfPresent(Int.self, forKey: .ava_rating)
        products = try values.decodeIfPresent([String].self, forKey: .products)
        reviews = try values.decodeIfPresent([String].self, forKey: .reviews)
        gallery = try values.decodeIfPresent([String].self, forKey: .gallery)
        qualifications = try values.decodeIfPresent([String].self, forKey: .qualifications)
        artist_booking = try values.decodeIfPresent([String].self, forKey: .artist_booking)
        earning = try values.decodeIfPresent(Int.self, forKey: .earning)
        jobDone = try values.decodeIfPresent(Int.self, forKey: .jobDone)
        totalJob = try values.decodeIfPresent(Int.self, forKey: .totalJob)
        completePercentages = try values.decodeIfPresent(Int.self, forKey: .completePercentages)
        fav_status = try values.decodeIfPresent(String.self, forKey: .fav_status)
    }
    */
}
