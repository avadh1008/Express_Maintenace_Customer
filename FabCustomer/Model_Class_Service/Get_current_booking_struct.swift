//
//  sddsdsdsdsd.swift
//  FabCustomer
//
//  Created by AmitSharma on 22/04/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import Foundation



struct Get_current_booking_struct : Codable {
    
    var status  = 0
    var message  = "Decode Error"
    var current_booking = [Get_current_booking_Data_Struct]()
    
    private enum CodingKeys: String, CodingKey
    {
        case  current_booking = "data"
        case  message , status
    }
    
}

struct Get_current_booking_Data_Struct : Codable {
    
    var address = "";
    var artistEmail = "";
    var artistImage = ""
    var artistLocation = ""
    var artistMobile = "";
    var artistName = "";
    var artist_commission_type = "";
    var artist_id = "";
    var ava_rating = 0;
    var booking_date = "";
    var booking_flag = "";
    var booking_time = "";
    var booking_timestamp = ""
    var booking_type = "";
    var category_name = "";
    var category_price = "";
    var commission_type = "";
    var completePercentages = 0;
    var created_at = "";
    var currency_type = "";
    var decline_by = "";
    var decline_reason = "";
    var description = ""
    var duration = "";
    var end_time = "";
    var flat_type = "";
    var id = "";
    var invoiceDic  :     Get_invoice_struct? ;
    var invoice_id = "";
    var jobDone = 0
    var job_id = "";
    var price = "";
    var reviews =   ""          ;
    var service_id = "";
    var start_time = "";
    var status = "";
    var time_zone = "";
   //  var total_amount = 0;
    var updated_at = "";
    var userImage = ""
    var userName = "";
    var user_id = "";
    var working_min = 0.0;
    
    var coupon_code : String?
    private enum CodingKeys: String, CodingKey
    {
        
        case invoiceDic = "invoice"
        
        case working_min =  "working_min"
        case  artist_commission_type            = "artist_commission_type"
        case  artist_id                         = "artist_id"
        case  ava_rating                = "ava_rating"
        case  booking_date              = "booking_date"
        case  booking_flag              = "booking_flag"
        case  booking_time              = "booking_time"
        case  booking_timestamp                 = "booking_timestamp"
        case  booking_type                      = "booking_type"
        case  category_name                     = "category_name"
        case  category_price                = "category_price"
        case  commission_type               = "commission_type"
        case  created_at                    = "created_at"
        case  currency_type             = "currency_type"
        case  decline_by                = "decline_by"
        case  decline_reason            = "decline_reason"
        case  end_time                  = "end_time"
        case  flat_type         = "flat_type"
        case  invoice_id        = "invoice_id";
        case  job_id            = "job_id"
        case  service_id                            = "service_id"
        case  start_time                            = "start_time"
        case  time_zone                             = "time_zone"
        //case  total_amount                          = "total_amount"
        case  updated_at                            = "updated_at"
        case  user_id                                = "user_id"
        
        case  coupon_code                                = "coupon_code"
        
        
        
        case  jobDone   ,  userImage   , userName, status, price   , completePercentages , address,  artistEmail     , artistImage    , artistLocation  , artistMobile , artistName, description, duration, id     
        
    }
    
    
}








struct Get_invoice_struct : Codable {
    
    
    var  ArtistName              = "";
    var  address                 = "";
    var  artistImage             = "";
    var  artist_amount           = "";
    var  artist_id               = "";
    var  booking_date            = "";
    var  booking_id              = "";
    var  categoryName            = "";
    var  category_amount         = "";
    var  commission_type         = "";
    var  coupon_code             = "";
    var  created_at              = "";
    var  currency_type           = "";
    var  final_amount            = "";
    var  flag                    = "";
    var  flat_type               = "";
    var  id                      = "";
    var  invoice_id              = "";
    var  payment_status          = "";
    var  payment_type            = "";
    var  referral_amount         = "";
    var  referral_percentage     = "";
    var  tax                     = "";
    var  to_referral_user_id     = "";
    var  total_amount            = "";
    var  updated_at              = "";
    var  userImage               = "";
    var  userName                = "";
    var  user_id                 = "";
    var  working_min             = "";
    
    var  discount_amount             = "";
    
    
    
    
    
    
    
    
    private enum CodingKeys: String, CodingKey
    {
        
        case  artist_amount = "artist_amount";
        case  artist_id = "artist_id";
        case  booking_date = "booking_date";
        case  booking_id = "booking_id";
        
        case  category_amount = "category_amount";
        case  commission_type = "commission_type";
        case  coupon_code = "coupon_code";
        case  created_at = "created_at";
        case  currency_type = "currency_type";
        case  final_amount = "final_amount";
        case  discount_amount = "discount_amount";
        
        case  flat_type = "flat_type"
        
        case  invoice_id = "invoice_id";
        case  payment_status = "payment_status";
        case  payment_type = "payment_type";
        case  referral_amount = "referral_amount";
        case  referral_percentage = "referral_percentage";
        
        case  to_referral_user_id = "to_referral_user_id";
        case  total_amount = "total_amount";
        case  updated_at = "updated_at";
        
        case  user_id = "user_id";
        case  working_min = "working_min";
        
        case  id , userImage , userName , tax, flag , categoryName ,  ArtistName , address, artistImage
        
    }
    
}




/* invoice =             {
 ArtistName = Tt;
 address = "";
 artistImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/1555584726.png";
 "artist_amount" = "22.5";
 "artist_id" = 744;
 "booking_date" = "2019-04-22";
 "booking_id" = 852;
 categoryName = "car washhh";
 "category_amount" = "2.5";
 "commission_type" = 1;
 "coupon_code" = "";
 "created_at" = 1555931556;
 "currency_type" = "$";
 "final_amount" = 25;
 flag = 1;
 "flat_type" = 1;
 id = 428;
 "invoice_id" = TEGGXC3WG8GB;
 "payment_status" = 1;
 "payment_type" = 1;
 "referral_amount" = 0;
 "referral_percentage" = 0;
 tax = 0;
 "to_referral_user_id" = 0;
 "total_amount" = 25;
 "updated_at" = 1555931556;
 userImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/image.png";
 userName = dipesh;
 "user_id" = 205;
 "working_min" = "0.28";
 }*/


/*
 {
 data =     (
 {
 address = "";
 artistEmail = "dip@gmail.com";
 artistImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/1555584726.png";
 artistLocation = "68 Ratan Lok Colony Near Kajariya Tiles Vijay Nagar Indore 452010, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India";
 artistMobile = 18484845845;
 artistName = Tt;
 "artist_commission_type" = 1;
 "artist_id" = 744;
 "ava_rating" = 0;
 "booking_date" = "2019-04-22";
 "booking_flag" = 4;
 "booking_time" = "06:01 pm";
 "booking_timestamp" = 1555956060;
 "booking_type" = 0;
 "category_name" = "car washhh";
 "category_price" = 10;
 "commission_type" = 1;
 completePercentages = 100;
 "created_at" = 1555936307;
 "currency_type" = "$";
 "decline_by" = "";
 "decline_reason" = "";
 description = "Hey, for this work artist will take $ 25 for this booking.";
 duration = "";
 "end_time" = 1555936490;
 "flat_type" = 1;
 id = 854;
 invoice =             {
 ArtistName = Tt;
 address = "";
 artistImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/1555584726.png";
 "artist_amount" = "22.5";
 "artist_id" = 744;
 "booking_date" = "2019-04-22";
 "booking_id" = 854;
 categoryName = "car washhh";
 "category_amount" = "2.5";
 "commission_type" = 1;
 "coupon_code" = "";
 "created_at" = 1555936490;
 "currency_type" = "$";
 "final_amount" = 25;
 flag = 0;
 "flat_type" = 1;
 id = 430;
 "invoice_id" = 2VHATVMDZWFV;
 "payment_status" = 2;
 "payment_type" = 2;
 "referral_amount" = 0;
 "referral_percentage" = 0;
 tax = 0;
 "to_referral_user_id" = 0;
 "total_amount" = 25;
 "updated_at" = 1555936490;
 userImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/image.png";
 userName = dipesh;
 "user_id" = 205;
 "working_min" = "1.85";
 };
 "invoice_id" = 2VHATVMDZWFV;
 jobDone = 4;
 "job_id" = 0;
 price = 25;
 reviews =             (
 {
 "artist_id" = 744;
 "booking_id" = 424;
 comment = "Hmmm ";
 "created_at" = 1555587029;
 id = 272;
 image = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/1555334323.png";
 name = a;
 rating = 3;
 status = 1;
 "user_id" = 614;
 },
 {
 "artist_id" = 744;
 "booking_id" = 852;
 comment = Bjjj;
 "created_at" = 1555936991;
 id = 275;
 image = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/image.png";
 name = dipesh;
 rating = 3;
 status = 1;
 "user_id" = 205;
 }
 );
 "service_id" = "";
 "start_time" = 1555936379;
 status = 1;
 "time_zone" = "GMT+05:30";
 "total_amount" = 25;
 "updated_at" = 1555936307;
 userImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/image.png";
 userName = dipesh;
 "user_id" = 205;
 "working_min" = 1;
 },
 {
 address = "";
 artistEmail = "dip@gmail.com";
 artistImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/1555584726.png";
 artistLocation = "68 Ratan Lok Colony Near Kajariya Tiles Vijay Nagar Indore 452010, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India";
 artistMobile = 18484845845;
 artistName = Tt;
 "artist_commission_type" = 1;
 "artist_id" = 744;
 "ava_rating" = 0;
 "booking_date" = "2019-04-22";
 "booking_flag" = 4;
 "booking_time" = "06:00 pm";
 "booking_timestamp" = 1555956000;
 "booking_type" = 0;
 "category_name" = "car washhh";
 "category_price" = 10;
 "commission_type" = 1;
 completePercentages = 100;
 "created_at" = 1555936212;
 "currency_type" = "$";
 "decline_by" = "";
 "decline_reason" = "";
 description = "Hey, for this work artist will take $ 25 for this booking.";
 duration = "";
 "end_time" = 1555936266;
 "flat_type" = 1;
 id = 853;
 invoice =             {
 ArtistName = Tt;
 address = "";
 artistImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/1555584726.png";
 "artist_amount" = "22.5";
 "artist_id" = 744;
 "booking_date" = "2019-04-22";
 "booking_id" = 853;
 categoryName = "car washhh";
 "category_amount" = "2.5";
 "commission_type" = 1;
 "coupon_code" = "";
 "created_at" = 1555936266;
 "currency_type" = "$";
 "final_amount" = 25;
 flag = 0;
 "flat_type" = 1;
 id = 429;
 "invoice_id" = GXR9S3CSTAP6;
 "payment_status" = 2;
 "payment_type" = 2;
 "referral_amount" = 0;
 "referral_percentage" = 0;
 tax = 0;
 "to_referral_user_id" = 0;
 "total_amount" = 25;
 "updated_at" = 1555936266;
 userImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/image.png";
 userName = dipesh;
 "user_id" = 205;
 "working_min" = "0.43";
 };
 "invoice_id" = GXR9S3CSTAP6;
 jobDone = 4;
 "job_id" = 0;
 price = 25;
 reviews =             (
 {
 "artist_id" = 744;
 "booking_id" = 424;
 comment = "Hmmm ";
 "created_at" = 1555587029;
 id = 272;
 image = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/1555334323.png";
 name = a;
 rating = 3;
 status = 1;
 "user_id" = 614;
 },
 {
 "artist_id" = 744;
 "booking_id" = 852;
 comment = Bjjj;
 "created_at" = 1555936991;
 id = 275;
 image = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/image.png";
 name = dipesh;
 rating = 3;
 status = 1;
 "user_id" = 205;
 }
 );
 "service_id" = "";
 "start_time" = 1555936240;
 status = 1;
 "time_zone" = "GMT+05:30";
 "total_amount" = 25;
 "updated_at" = 1555936212;
 userImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/image.png";
 userName = dipesh;
 "user_id" = 205;
 "working_min" = 0;
 },
 {
 address = "";
 artistEmail = "dip@gmail.com";
 artistImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/1555584726.png";
 artistLocation = "68 Ratan Lok Colony Near Kajariya Tiles Vijay Nagar Indore 452010, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India";
 artistMobile = 18484845845;
 artistName = Tt;
 "artist_commission_type" = 1;
 "artist_id" = 744;
 "ava_rating" = 0;
 "booking_date" = "2019-04-22";
 "booking_flag" = 4;
 "booking_time" = "04:42 pm";
 "booking_timestamp" = 1555951320;
 "booking_type" = 0;
 "category_name" = "car washhh";
 "category_price" = 10;
 "commission_type" = 1;
 completePercentages = 100;
 "created_at" = 1555931528;
 "currency_type" = "$";
 "decline_by" = "";
 "decline_reason" = "";
 description = "Hey, for this work artist will take $ 25 for this booking.";
 duration = "";
 "end_time" = 1555931556;
 "flat_type" = 1;
 id = 852;
 invoice =             {
 ArtistName = Tt;
 address = "";
 artistImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/1555584726.png";
 "artist_amount" = "22.5";
 "artist_id" = 744;
 "booking_date" = "2019-04-22";
 "booking_id" = 852;
 categoryName = "car washhh";
 "category_amount" = "2.5";
 "commission_type" = 1;
 "coupon_code" = "";
 "created_at" = 1555931556;
 "currency_type" = "$";
 "final_amount" = 25;
 flag = 1;
 "flat_type" = 1;
 id = 428;
 "invoice_id" = TEGGXC3WG8GB;
 "payment_status" = 1;
 "payment_type" = 1;
 "referral_amount" = 0;
 "referral_percentage" = 0;
 tax = 0;
 "to_referral_user_id" = 0;
 "total_amount" = 25;
 "updated_at" = 1555931556;
 userImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/image.png";
 userName = dipesh;
 "user_id" = 205;
 "working_min" = "0.28";
 };
 "invoice_id" = "";
 jobDone = 4;
 "job_id" = 0;
 price = 25;
 reviews =             (
 {
 "artist_id" = 744;
 "booking_id" = 424;
 comment = "Hmmm ";
 "created_at" = 1555587029;
 id = 272;
 image = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/1555334323.png";
 name = a;
 rating = 3;
 status = 1;
 "user_id" = 614;
 },
 {
 "artist_id" = 744;
 "booking_id" = 852;
 comment = Bjjj;
 "created_at" = 1555936991;
 id = 275;
 image = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/image.png";
 name = dipesh;
 rating = 3;
 status = 1;
 "user_id" = 205;
 }
 );
 "service_id" = "";
 "start_time" = 1555931539;
 status = 1;
 "time_zone" = "GMT+05:30";
 "total_amount" = 0;
 "updated_at" = 1555931528;
 userImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/image.png";
 userName = dipesh;
 "user_id" = 205;
 "working_min" = 0;
 }
 );
 message = "Get my current booking.";
 status = 1;
 }
 */


/*
 {
 address = "";
 artistEmail = "dip@gmail.com";
 artistImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/1555584726.png";
 artistLocation = "68 Ratan Lok Colony Near Kajariya Tiles Vijay Nagar Indore 452010, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India";
 artistMobile = 18484845845;
 artistName = Tt;
 "artist_commission_type" = 1;
 "artist_id" = 744;
 "ava_rating" = 0;
 "booking_date" = "2019-04-22";
 "booking_flag" = 4;
 "booking_time" = "04:42 pm";
 "booking_timestamp" = 1555951320;
 "booking_type" = 0;
 "category_name" = "car washhh";
 "category_price" = 10;
 "commission_type" = 1;
 completePercentages = 100;
 "created_at" = 1555931528;
 "currency_type" = "$";
 "decline_by" = "";
 "decline_reason" = "";
 description = "Hey, for this work artist will take $ 25 for this booking.";
 duration = "";
 "end_time" = 1555931556;
 "flat_type" = 1;
 id = 852;
 invoice =             ;
 "invoice_id" = "";
 jobDone = 4;
 "job_id" = 0;
 price = 25;
 reviews =             ;
 "service_id" = "";
 "start_time" = 1555931539;
 status = 1;
 "time_zone" = "GMT+05:30";
 "total_amount" = 0;
 "updated_at" = 1555931528;
 userImage = "http://phpstack-132936-677440.cloudwaysapps.com/assets/images/image.png";
 userName = dipesh;
 "user_id" = 205;
 "working_min" = 0;
 }
 */
