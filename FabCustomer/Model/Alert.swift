//
//  Alert.swift
//  Pixel eCommerce
//
//  Created by samyotech on 13/11/17.
//  Copyright © 2017 samyotech. All rights reserved.
//

import UIKit

class Alert: NSObject {
    //MARK:- Response Messages
    
    static let msg_finish_booking =  "Are you sure to finish this this booking"
    static let msgCash_payment         =    "Are you sure want to do Cash payment?"
    static let msgcwallet_payment         =    "Are you sure want to do wallet payment?"
    static let msgsufficientamount         =    "Oops its seem that your wallet amount is insufficient for total pay amount"
    
    static let kMob_N_Valid  =    "Opps! Mobile number should be digit 6-14."
    static let msg         =    "Message"
      static let des_Msg         =    "Enter Description"
    static let Sign_Out_msg         =    "Are you sure want to SignOut?"
    static let Network_Error_msg   =    "Oops! It seem that your device not connected to the internet."
    static let Name_msg                =    "Please enter user name."
    static let Email_msg           =    "Please enter email id."
    static let Pass_msg        =    "Please enter password."
    static let Con_pass_msg      =    "Please enter confirm password."
    static let Try_agn_msg         =    "Please try again after some time."
    static let Pass_not_macth         =  "Oops! it's seem that confirm password and password does not match."
    static let Email_not_Vaild_msg           =    "Please enter valid email id."
    static let amount_msg           =    "Please enter amount."
    
    
    static let kmsg                                 =    "FabArtist"
    static let kTitle                                 =    "FabArtist"
    static let kNetConnectionTitle                    =    "No Internet Connection"
    static let kNetwork_Error                         =    "Make sure your device is connected to the internet."
    static let kServer_Error                          =    "Server error, please try again later."
    
    //App Message
    static let kEmpty_Email                           =    "Please enter your email."
    static let kInvalid_Email                         =    "Please enter valid email address."
    static let kEmpty_num                        =    "Please enter mobile number."
    static let kEmpty_Password                        =    "Please enter your password."
    static let kEmpty_Old_Password                    =    "Please enter your old password."
    static let kEmpty_New_Password                    =    "Please enter your new password."
    static let kEmpty_Confirm_Password                =    "Please enter your confirm Password."
    
    static let kPassword_Limit                        =    "Password must be greater than or equal to 6 characters."
    static let kPassword_ConfirmPassword_NotMatch     =    "Password and confirm password should be same."
    static let kNewPassword_ConfirmPassword_NotMatch  =    "New password and confirm password should be same."
    //"Your password has been changed successfully."
    //"Applied seeker not found."
    
    static let kEmpty_Name                            =    "Please enter your name."
    static let kEmpty_LasName                            =    "Please enter your last name."
     static let kEmpty_gender                            =    "Please select gender."
    static let kEmpty_Mobile                          =    "Please enter your mobile number."
    static let kEmpty_Current_Address                 =    "Please enter your current address."
    static let kLocation_Not_Select                   =    "Please select preferd location."
    static let kJobType_Not_Select                    =    "Please select job type."
    static let kQualification_Not_Select              =    "Please select qualification."
    static let kYearOfPassing_Not_Select              =    "Please select your year of passing"
    static let kEmpty_Percentage                      =    "Please enter your percentage."
    static let kAreaOfSector_Not_Select               =    "Please select area of sector."
    static let kEmpty_Organization_Location           =    "Please enter organization location."
    static let kEmpty_Organization_Address            =    "Please enter organization address."
    static let kEmpty_Organization_Description        =    "Please enter organization description."
    static let kDesignation_Not_Select                =    "Please select designation."
    static let kJobLocation_Not_Select                =    "Please select job location."
    static let kSpecialization_Not_Select             =    "Please select specialization."
    static let kExprience_Not_Select                  =    "Please select experience."
    static let kEmpty_NoVacancies                     =    "Please enter number of vacancies."
    static let kEmpty_Skills                          =    "Please enter skills required."
    static let kLastDateApplication_Not_Select        =    "Please select last date of application."
    static let kHiringProcess_Not_Select              =    "Please select hiring process."
    
    static let kProfile_Not_Update                    =    "Please update your profile before posting a job."
    
    static let kSign_Out                              =    "Are you sure want to sign out?"
    static let k_Job_Delete                              =    "Are you sure, do you want to Delete this job?"
    static let k_Job_confirm                              =    "Are you sure, do you want to Confirm this job?"
    static let k_Job_Reject                              =    "Are you sure, do you want to Reject this job?"
    static let k_Job_complete                              =    "Are you sure, do you want to Reject this job?"
    static let kGuestLogin_Leave                      =    "Before appling this job, you have to login first. Are you sure to login?"
    static let kConfirm_Job_Apply                     =    "Are you sure to apply this job ?"
    static let kDelete_Job                            =    "Are you sure, do you want to delete this job ?"
    static let k_email_validation            = "Your account has been create successfully, surely you will get the link by email."
    static let k_Job_Complete                              =    "Are you sure, do you want to Complete this job?"
    static let successMsg = "Congratulations"
    static let cancel_Booking = "Are you sure do you want to cancel booking."
    static let accept_booking = "Are you sure do you want to accept booking."
    static let decline_booking = "Are you sure do you want to decline booking."
    static let reject_booking = "Are you sure do you want to reject booking."
    static let start_booking = "Are you sure do you want to start booking."

    static let appDelegate = UIApplication.shared.delegate
    
    
    static let ACCOUNT_NUM         =    "Oops! Please enter Account number."
    static let COUNTRY_MES         =    "Oops! Please enter country."
    static let CITY_MES         =    "Oops! Please enter city."
    static let address_MES         =    "Oops! Please select address."
    static let IBAN_NUM         =    "Oops! Please enter IBAN number."
    static let bank_Name_NUM         =    "Oops! Please enter bank Name."
    static let account_holder_NUM         =    "Oops! Please enter account holder Name."
    
    
    //MARK:- Alert
    static func show(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            //execute some code when this option is selected
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func showH( titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            //execute some code when this option is selected
        }))
        //vc.present(alert, animated: true, completion: nil)
        
        
        appDelegate?.window??.rootViewController?.present(alert, animated: true, completion: { })
    }
    
    static func showH(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            //execute some code when this option is selected
        }))
        //vc.present(alert, animated: true, completion: nil)
        
       
        appDelegate?.window??.rootViewController?.present(alert, animated: true, completion: { })
    }
    static  func alert_PopMathod(vc: UIViewController, title:String!,message_Str : String! , action_Title:[String?] , action_Style:[UIAlertAction.Style] , action:[((UIAlertAction)->Void)])
    {
        DispatchQueue.main.async {

            let alert = UIAlertController(title: title, message: message_Str, preferredStyle: .alert)
            for (index , title ) in action_Title.enumerated()
            {
                let action = UIAlertAction(title: title, style: action_Style[index], handler: action[index])
                alert.addAction(action)
            }
            appDelegate?.window??.rootViewController?.present(alert, animated: false, completion: nil);
        }
    }
    
    static func showToast(message : String! , view_VC : UIViewController) {
        
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 14.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        
        toastLabel.numberOfLines = 0
        var  wid_str = toastLabel.intrinsicContentSize.width
        
        if wid_str > view_VC.view.frame.size.width
        {
            wid_str = view_VC.view.frame.width // - 30
            
            toastLabel.frame =   CGRect(x: 15 , y: view_VC.view.frame.size.height-150, width: wid_str-30, height: 90)
        }
        else
        {
            toastLabel.frame =   CGRect(x: (view_VC.view.frame.size.width/2 - wid_str/2)-15, y: view_VC.view.frame.size.height-150, width: wid_str+30, height: 55)
        }
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        
        
        
        view_VC.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    static func showMiddleToast(message : String! , view_VC : UIViewController) {
        
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 14.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        
        toastLabel.numberOfLines = 0
        var  wid_str = toastLabel.intrinsicContentSize.width
        
        if wid_str > view_VC.view.frame.size.width
        {
            wid_str = view_VC.view.frame.width // - 30
            
            toastLabel.frame =   CGRect(x: 15 , y: view_VC.view.frame.size.height/2, width: wid_str-30, height: 90)
        }
        else
        {
            toastLabel.frame =   CGRect(x: (view_VC.view.frame.size.width/2 - wid_str/2)-15, y: view_VC.view.frame.size.height/2, width: wid_str+30, height: 55)
        }
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        
        
        
        appDelegate?.window??.rootViewController?.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
