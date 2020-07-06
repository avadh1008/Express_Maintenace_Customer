//
//  asdada.swift
//  BeeBeeClean
//
//  Created by AmitSharma on 26/03/19.
//  Copyright © 2019 AmitSharma. All rights reserved.
//

import Foundation



struct Finished_Booking_Struct : Codable {
    
    var status  = 0
    var message  = "Decode Error"
    
    var finished_Booking_Arr  = [Finished_Booking_Data_Struct]()
    
    private enum CodingKeys: String, CodingKey
    {
        case finished_Booking_Arr = "data"
        
        case message , status
    }
    
}




struct Finished_Booking_Data_Struct : Codable {
    
    
    var  id = ""
    var  user_id = ""
    var  artist_id = ""
    var  service_id = ""
    var  booking_time = ""
    var  description = ""
    var  duration = ""
    var  start_time = ""
    var  user_car_id = ""
    var  car_id = ""
    var  booking_date = ""
    var  end_time = ""
    var  price = ""
    var  status = ""
    var  booking_flag = ""
    var  decline_by = ""
    var  time_zone = ""
    var  decline_reason = ""
    var  booking_timestamp = ""
    var  created_at = ""
    var  updated_at = ""
    var  start_image : String?
    var  end_image  : String?
    var  address = ""
    var  latitude = ""
    var  longitude = ""
    var  payment_status = ""
    var  payment_type = ""
    var  confirm_pay = ""
    var  invoice_id = ""
    var  attemp = ""
    var  coupon_code = ""
    var  discount_amount = ""
    var  final_amount = ""
    var  commssion_amount = ""
    var  commission = ""
    var  applied_artist = ""
    var  tax = ""
    var  tax_amount = ""
    var  admin_amount = ""
    var  carType = ""
    var  serviceTitle = ""
    var  servicePrice = ""
    var  carModel = ""
    var  year = ""
    var  licence_plate = ""
    var  currency_symbol = ""
    var  artistName = ""
    var  artistImage = ""
    var  artistMobile = ""
    var  artistEmail = ""
    var  artistLocation = ""
    var  userName = ""
    var  userAddress = ""
    var  userEmail = ""
    var  userMobile = ""
    var  jobDone = 0
    var  completePercentages = 0
    var  ava_rating = 0
    var  working_min = 0.0
    var  userImage = ""
    var finished_Booking_Reviwe_Arr = [Finished_Booking_Reviwe_Struct]()
    
    private enum CodingKeys: String, CodingKey
    {
        
        case finished_Booking_Reviwe_Arr = "reviews"
        case  user_id = "user_id"
        case  artist_id = "artist_id"
        case  service_id = "service_id"
        case  booking_time = "booking_time"
        case  start_time = "start_time"
        case  user_car_id = "user_car_id"
        case  car_id = "car_id"
        case  booking_date = "booking_date"
        case  end_time = "end_time"
        case  booking_flag = "booking_flag"
        case  decline_by = "decline_by"
        case  time_zone = "time_zone"
        case  decline_reason = "decline_reason"
        case  booking_timestamp = "booking_timestamp"
        case  created_at = "created_at"
        case  updated_at = "updated_at"
        case  start_image = "start_image"
        case  end_image = "end_image"
        case  payment_status = "payment_status"
        case  payment_type = "payment_type"
        case  confirm_pay = "confirm_pay"
        case  invoice_id = "invoice_id"
        case  coupon_code = "coupon_code"
        case  discount_amount = "discount_amount"
        case  final_amount = "final_amount"
        case  commssion_amount = "commssion_amount"
        case  tax_amount = "tax_amount"
        case  applied_artist = "applied_artist"
        case  admin_amount = "admin_amount"
        case  ava_rating = "ava_rating"
        case  working_min = "working_min"
        case  licence_plate = "licence_plate"
        case  currency_symbol = "currency_symbol"
        
        case  id , description , duration , price ,  status , address , latitude ,  longitude, attemp , commission ,  tax ,  carType , serviceTitle, servicePrice ,  carModel , year ,  artistName , artistImage , artistMobile ,  artistEmail , artistLocation, userName ,  userAddress , userEmail , userMobile , jobDone , completePercentages ,  userImage
        
        
        
        
        
        
    }
    
}
struct Finished_Booking_Reviwe_Struct : Codable {
    
    
    
    var id = ""
    var user_id = ""
    var artist_id = ""
    var rating = ""
    var comment = ""
    var created_at = ""
    var status = ""
    var booking_id = ""
    var name = ""
    var image = ""
    
    
    
    private enum CodingKeys: String, CodingKey
    {
        
        
        case id , rating , comment ,status , name , image
        
        case user_id = "user_id"
        case artist_id = "artist_id"
        case created_at = "created_at"
        case booking_id = "booking_id"
    }
    
}

/*
 
 {
 "id": "61",
 "user_id": "15",
 "artist_id": "17",
 "service_id": "2",
 "booking_time": "04:55 PM",
 "description": "",
 "duration": "",
 "start_time": "",
 "user_car_id": "29",
 "car_id": "2",
 "booking_date": "10 Mar 2019",
 "end_time": "",
 "price": "57.5",
 "status": "1",
 "booking_flag": "5",
 "decline_by": "2",
 "time_zone": "GMT+05:30",
 "decline_reason": "Busy",
 "booking_timestamp": "1551699190",
 "created_at": "1551699190",
 "updated_at": "1551699190",
 "start_image": 0,
 "end_image": 0,
 "address": "68, Vijay Nagar Square, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India",
 "latitude": "22.7498325",
 "longitude": "75.89878515625",
 "payment_status": "1",
 "payment_type": "1",
 "confirm_pay": "1",
 "invoice_id": "",
 "attemp": "1",
 "coupon_code": "",
 "discount_amount": "",
 "final_amount": "57.5",
 "commssion_amount": "5",
 "commission": "10",
 "applied_artist": "43,17",
 "tax": "15",
 "tax_amount": "7.5",
 "admin_amount": "52.5",
 "carType": "Van",
 "serviceTitle": "driving",
 "servicePrice": "50",
 "carModel": "fxhfxj",
 "year": "2008",
 "licence_plate": "cjtxjtdjyd",
 "currency_symbol": "$",
 "artistName": "hem",
 "artistImage": "http://uuclean.com/assets/images/image.png",
 "artistMobile": "+919691179911",
 "artistEmail": "varunverma@samyotech.com",
 "artistLocation": "indore india",
 "userName": "Amol",
 "userAddress": "",
 "userEmail": "amol@email.com",
 "userMobile": "9188752588658858888858",
 "jobDone": 0,
 "completePercentages": 0,
 "ava_rating": 0,
 "working_min": 0,
 "userImage": "http://uuclean.com/assets/images/1553558802.png"
 
 
 "reviews": [
 {
 "id": "11",
 "user_id": "15",
 "artist_id": "17",
 "rating": "3",
 "comment": "Good",
 "created_at": "1550135087",
 "status": "1",
 "booking_id": "84",
 "name": "Amol",
 "image": "http://uuclean.com/assets/images/1553558802.png"
 },
 {
 "id": "12",
 "user_id": "15",
 "artist_id": "17",
 "rating": "4",
 "comment": "Bznsjsjs",
 "created_at": "1550222289",
 "status": "1",
 "booking_id": "87",
 "name": "Amol",
 "image": "http://uuclean.com/assets/images/1553558802.png"
 },
 {
 "id": "13",
 "user_id": "15",
 "artist_id": "17",
 "rating": "5",
 "comment": "Ttujj",
 "created_at": "1550223532",
 "status": "1",
 "booking_id": "89",
 "name": "Amol",
 "image": "http://uuclean.com/assets/images/1553558802.png"
 },
 {
 "id": "14",
 "user_id": "15",
 "artist_id": "17",
 "rating": "5",
 "comment": "Oydiysysoysododopd",
 "created_at": "1550224212",
 "status": "1",
 "booking_id": "90",
 "name": "Amol",
 "image": "http://uuclean.com/assets/images/1553558802.png"
 },
 {
 "id": "15",
 "user_id": "15",
 "artist_id": "17",
 "rating": "5",
 "comment": "Tu oj",
 "created_at": "1550225561",
 "status": "1",
 "booking_id": "91",
 "name": "Amol",
 "image": "http://uuclean.com/assets/images/1553558802.png"
 },
 {
 "id": "21",
 "user_id": "15",
 "artist_id": "17",
 "rating": "3",
 "comment": "ok",
 "created_at": "1551080281",
 "status": "1",
 "booking_id": "14",
 "name": "Amol",
 "image": "http://uuclean.com/assets/images/1553558802.png"
 },
 {
 "id": "22",
 "user_id": "15",
 "artist_id": "17",
 "rating": "3",
 "comment": "Good work",
 "created_at": "1551083831",
 "status": "1",
 "booking_id": "15",
 "name": "Amol",
 "image": "http://uuclean.com/assets/images/1553558802.png"
 },
 {
 "id": "24",
 "user_id": "15",
 "artist_id": "17",
 "rating": "3",
 "comment": "good work",
 "created_at": "1551240933",
 "status": "1",
 "booking_id": "1",
 "name": "Amol",
 "image": "http://uuclean.com/assets/images/1553558802.png"
 },
 {
 "id": "25",
 "user_id": "15",
 "artist_id": "17",
 "rating": "4",
 "comment": "thank you",
 "created_at": "1551243551",
 "status": "1",
 "booking_id": "2",
 "name": "Amol",
 "image": "http://uuclean.com/assets/images/1553558802.png"
 }
 ]
 }
 */
