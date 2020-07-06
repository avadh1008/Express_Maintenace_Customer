//
//  GlobalVariables.swift
//  JobPortal
//
//  Created by samyotech on 12/08/17.
//  Copyright © 2017 samyotech. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation


//http://164.132.170.155/apidetail/

class GlobalVariables{

    // These are the properties you can store in your singleton
   
    
    //DeveciToken DeviceId
    ///DipeshCreate
    public var get_Status = Get_Stutas()
    
   public var all_job_Arr = [Get_all_job]()
    public var all_Caegory_Arr = [Get_All_Caegory]()
    public var applied_job_by_id_Arr = [Get_applied_job_by_id_Struct]()
    public var all_Artists_Arr = [Get_All_Artists_Struct]()
    public var getSingle_Incoice_Struct = Get_Single_Invoice()

    
    public var coupon_Status   = CouponVal_stutas()
    
    //public var guest_Type_Arr = [Get_Guest_Type_Struct]()
   // public var mony_Arr = [Get_Mony_his_Struct]
    
  //  public var my_Wallet_dic = Get_My_Wallet_Struct()
    
    public var glo_Navi_Cotro : UINavigationController? = nil
    
    public var glo_Navi_Obj        : UINavigationController!
    
     //public var currentLocation : CLLocation!
    
    public var strDeviceToken :String?      = String()
    public var strFBDeviceToken :String?         = String()
    public var strDeviceID :String?         = String()
    public var location_to_Edit :String?         = String()
    public var cateGory_dictionary = NSDictionary()
    public var user_Role = "2"
    /*
    public var user_Image = String()
    */
    
    /*
       public var user_Country = String()
       public var user_City = String()
       public var user_Addresss = String()
    */
  /*  public var user_Office_add = String()
    public var user_add = String()
    public var user_Gender = String()
    public var user_Mobile = String()*/
    //  user login dictionary
   // public var user_Login_dictionary : NSMutableDictionary!
   // public var userPayment_dictionary : NSMutableDictionary!
    //public var show_array_LatLong :  NSArray = NSArray()
    
    var currentLocation : CLLocation!
   
    
    public var user_id    :String             = ""
 
    
    
    
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
            // create viewController code...
            
        }
        
        return Static.instance
    }
   
    
 
    
   //For Side Menu
    var arrMenuImageAndTitle: NSMutableArray = NSMutableArray()

    //For Home Dashboard
    var dictHomeDashboard: NSMutableDictionary = NSMutableDictionary()


    


    //MARK: - SideMenu
}

