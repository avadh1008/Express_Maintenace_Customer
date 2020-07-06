//
//  Constant.swift
//  JobPortal
//
//  Created by samyotech on 12/08/17.
//  Copyright © 2017 samyotech. All rights reserved.
//

import UIKit
var  montserratRegular = ""
             
          var   montserratLight = ""
                  var         montserratMedium = ""


class Constant: NSObject {
    
    
    static let kBase_Url  = "http://phpstack-132936-852279.cloudwaysapps.com/Webservice/"
    
    static let payment_BaseUrl = "http://phpstack-132936-852279.cloudwaysapps.com/"
    
    //1. login,signup,forget:-------------------------
    static let kTo_SignUp               =   "SignUp"
    static let kTo_signIn               =   "signIn"
    static let kTo_send_otp             =   "send_otp"
    static let USER_ROLL                =   "2"
    static let kTo_getAllCaegory        =   "getAllCaegory"
    static let kTo_getAllArtists        =   "getAllArtists"
    static let kTo_getArtistByid        =   "getArtistByid"
    static let kTo_artistPrsonalInfo    =   "artistPrsonalInfo"
    static let kTo_addQualification     =   "addQualification"
    static let kTo_getSkillsByCategory  =   "getSkillsByCategory"
    //MARK: - Payemnt api
    
    static let kTo_book_appointment         =   "book_appointment"
    static let kTo_getAppointment           =   "getAppointment"
    static let kTo_getNearestArtist         =   "getNearestArtist"
    static let kTo_checkCoupon              =  "checkCoupon"
    static let kTo_makePayment              =  "makePayment"
    static let kTo_editPersonalInfo         =  "editPersonalInfo"
    static let kTo_getMyCurrentBooking      =  "getMyCurrentBooking"
    static let kTo_booking_operation        =  "booking_operation"
    static let kTo_getMyInvoice             =  "getMyInvoice"
    static let kTo_decline_booking          =  "decline_booking"
    static let kTo_book_artist              =  "book_artist"
    
    
    
    
    static let GETHOMEDATA              =  "getHomeData"
    
    
    static let kTo_getMyCurrentBookingUser  =  "getMyCurrentBookingUser"
    //MARK: - buy product , add , get in cart , remove from cart
    static let kTo_addTocart                    =   "addTocart"
    static let kTo_getMyCart                    =   "getMyCart"
    static let kTo_updateCartQuantity           =   "updateCartQuantity"
    static let kTo_remove_product_cart          =   "remove_product_cart"
    static let kTo_addGallery                   =   "addGallery"
    static let kTo_addProduct                   =   "addProduct"
    static let kTo_getMyReferralCode            =   "getMyReferralCode"
    static let kTo_appointment_operation        =   "appointment_operation"
    static let kTo_edit_appointment             =   "edit_appointment"
    static let kTo_getLocationArtist            =   "getLocationArtist"
    //MARK: - Chat
    static let kTo_getChatHistoryForArtist  =   "getChatHistoryForArtist"
    static let kTo_getChat                  =   "getChat"
    static let kTo_sendmsg                  =   "sendmsg"
    static let kTo_getChatHistoryForUser    =   "getChatHistoryForUser"
    static let kTo_getNotifications         =   "getNotifications"
    static let kTo_getMyTicket              =   "getMyTicket"
    static let kTo_generateTicket           =   "generateTicket"
    static let kTo_addRating                =   "addRating"
    static let kToupdateLocation            =   "updateLocation"
    static let kTo_deleteProfileImage       =   "deleteProfileImage"
    static let kTo_forgotPassword           =   "forgotPassword"
    static let kTo_getChatTicket            =   "getTicketComments"
    static let kTo_sendmsgTicket            =   "addTicketComments"
    static let kTo_all_job_user             =   "get_all_job_user"
    static let kTo_post_job                 =   "post_job"
    static let kTo_applied_job_by_id        =   "get_applied_job_by_id"
    static let kTo_deletejob                =   "deletejob"
    static let kTo_job_status_user          =   "job_status_user"
    
    static let kTo_add_favorites        =       "add_favorites"
    static let kTo_remove_favorites     =       "remove_favorites"
    static let kTo_jobComplete          =       "jobComplete"
    static let kTo_edit_post_job        =       "edit_post_job"
    static let kTo_SinglegetInvoice     =       "getJobInvoice"
    static let kTo_getWallet            =       "getWallet"
    static let kTo_addMoney             =       "addMoney"
    static let kTo_getWalletHistory     =       "getWalletHistory"
    static let POST_JOB_NEW     =       "post_job_new"
    
    
    
    
    // GLOBLE COLOR DEFINE
    static let line_Color: UIColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 240.0/255.0, alpha: 1.0)
    
    static let kColor_Placeholder: UIColor = .white
    static let kColor_Placeholder_Password: UIColor = .lightGray
    static let loder_Color_D: UIColor = UIColor(hex: "000000").withAlphaComponent(0.5)
    static let header_Color: UIColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
    
    static let kColor_Combo: UIColor = UIColor(red: 36.0/255.0, green: 121.0/255.0, blue: 165.0/255.0, alpha: 1.0)
    
    static let kColor_NonCompliant: UIColor = UIColor(red: 190.0/255.0, green: 15.0/255.0, blue: 52.0/255.0, alpha: 1.0)
    
    static let kColor_Compliant: UIColor = UIColor(red: 87.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let Feb_red : UIColor =  UIColor.red
    static let Feb_green : UIColor =  UIColor.green
    static let Feb_yello : UIColor =  UIColor.blue
    static let KcolorYoga: UIColor = UIColor(red: 205/255.0, green: 192/255.0, blue: 0.0/255.0, alpha: 1.0)
    
    static let Ubeaut_Red_Color : UIColor =  UIColor(hexString: "#E6232D")
    static let Feb_Bas_Col : UIColor = UIColor(red: 0/255, green: 107/255, blue: 212/255, alpha: 1)
    
    
    
    
    //MARK:- Space between String Charactor
    static func attributedTextTitle(string:String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(3.0), range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }
    
}
