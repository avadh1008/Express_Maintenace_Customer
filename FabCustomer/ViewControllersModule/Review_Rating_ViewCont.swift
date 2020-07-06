//
//  Review_Rating_ViewCont.swift
//  BeeBeeClean
//
//  Created by AmitSharma on 29/03/19.
//  Copyright © 2019 AmitSharma. All rights reserved.
//

import UIKit

class Review_Rating_ViewCont: UIViewController {
    
    class func viewController() -> Review_Rating_ViewCont {
        return "Main".viewController("Review_Rating_ViewCont") as! Review_Rating_ViewCont
    }

    @IBOutlet weak var rating_VIew: FloatRatingView!
     let  globel_Var = GlobalVariables.sharedManager
    var finished_Booking_Dic  = Get_invoice_struct()
    
   // var current_booking = [Get_current_booking_Data_Struct]()
    
    
     @IBOutlet weak var comnt_TV: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        rating_VIew.type = .halfRatings
        
        
        //Constant.addRating
        // Do any additional setup after loading the view.
        create_Navigation_Bar_Mathod()
    }
    
    func create_Navigation_Bar_Mathod()
    {
        
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "menu_Img"), left_title_Str: nil, right_B_Img:nil, right_title_Str: nil, title_Str: "Rating", hidden_Nav: false, left_Button: nil , right_Button: nil)
        
        
        
    }
    
    
    @IBAction func reviewSubmit_Action( _ sender : UIButton!)
    {
        
        if comnt_TV.text.isEmpty == true
        {
            Alert.showMiddleToast(message: Alert.des_Msg, view_VC: self)
        }
        
        let dic = finished_Booking_Dic
        
        let ret_Val =  String(rating_VIew.rating)
        
        
        let parameters : [String : String] = ["user_id":GlobalVariables.sharedManager.user_id  , "booking_id":dic.id, "comment" : comnt_TV.text! , "rating":ret_Val , "artist_id":dic.artist_id]
        loader.showLoader()
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_addRating, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            
             
             Alert.showMiddleToast(message: modelVal?.message, view_VC: self)
           let myBooking_Home : BookingViewController  = BookingViewController.viewController()
            
           self.navigationController?.pushViewController(myBooking_Home, animated: true)
            loader.hideLoader()
            
        }
        else
        {
            
            Alert.showMiddleToast(message: self.globel_Var.get_Status.message, view_VC: self)
           
            loader.hideLoader()
            }
        })
        
     
    }
    
    
    
    @IBAction func cancel_Action( _ sender : UIButton!)
    {
        let myBooking_Home : BookingViewController  = BookingViewController.viewController()
        
        self.navigationController?.pushViewController(myBooking_Home, animated: true)
    }
    
    
    
}
