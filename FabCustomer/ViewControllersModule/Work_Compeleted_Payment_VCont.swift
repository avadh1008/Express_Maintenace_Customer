//
//  Work_Compeleted_Payment_VCont.swift
//  BeeBeeClean
//
//  Created by AmitSharma on 26/03/19.
//  Copyright © 2019 AmitSharma. All rights reserved.
//

import UIKit

class Work_Compeleted_Payment_VCont: UIViewController {
    class func viewController() -> Work_Compeleted_Payment_VCont {
        return "Main".viewController("Work_Compeleted_Payment_VCont") as! Work_Compeleted_Payment_VCont
    }
    
    /// payment view ofter completed worked
    // --------------payment view Outlet --------------------
    // ------------Book Now Outlet----------//
    
    var finished_Booking_Dic  = Get_invoice_struct()
    var discountAmount = "0"
    
    @IBOutlet weak var payment_view             : UIView!
    @IBOutlet weak var applyCode_Button         : UIButton!
    @IBOutlet weak var online_payment_Button    : UIButton!
    @IBOutlet weak var cash_Payment_Button      : UIButton!
    @IBOutlet weak var payByWallet_Button       : UIButton!
    
    @IBOutlet weak var wallet_Label    : UILabel!
    var totalAmount_Str = ""
    @IBOutlet weak var totalAmount_Label    : UILabel!
    @IBOutlet weak var code_TF : UITextField!
    @IBOutlet weak var address_Label : UILabel!
    @IBOutlet weak var name_Label : UILabel!
    @IBOutlet weak var car_Name_Label : UILabel!
    @IBOutlet weak var prifile_ImgV : UIImageView!
    // var my_wallet_dic = my_wallet_Struct()
    //  var my_Wallet_dic : Get_My_Wallet_Struct?
    
    
    var coupon_code = ""
    // ------------Outlet----------//
    
    
    let left_B = UIButton()
    let right_B = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Header_bar
        if let image : UIImage = UIImage(named: "menu")  {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
            //  SJSwiftSideMenuController .showRightMenuNavigationBarButton(image: image)
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        create_Navigation_Bar_Mathod()
        load_data()
        
        waletMathod()
        wallUpdate_Mathod(api_key: Constant.kTo_getWallet)
        
    }
    func load_data()
    {
        
        
        applyCode_Button.addTarget(self, action: #selector(self.appleCode_Payment_Action(_:)), for: .touchUpInside)
        online_payment_Button.addTarget(self, action: #selector(self.online_Payment_Action(_:)), for: .touchUpInside)
        payByWallet_Button.addTarget(self, action: #selector(self.payWallet_Payment_Action(_:)), for: .touchUpInside)
        cash_Payment_Button.addTarget(self, action: #selector(self.cash_Payment_Action(_:)), for: .touchUpInside)
        
        totalAmount_Str = finished_Booking_Dic.total_amount
        totalAmount_Label.text  = finished_Booking_Dic.currency_type +  finished_Booking_Dic.total_amount
        address_Label.text      =  finished_Booking_Dic.address
        name_Label.text         =  finished_Booking_Dic.ArtistName
        car_Name_Label.text     =  finished_Booking_Dic.categoryName
        
        
        prifile_ImgV.sd_setImage(with: URL(string: finished_Booking_Dic.artistImage  ), placeholderImage:UIImage(named: "profile") )
        
        
    }
    
    
    
    func create_Navigation_Bar_Mathod()
    {
        
        left_B.addTarget(self, action: #selector(self.left_Mathod_Action(_:)), for: .touchUpInside)
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "back2"), left_title_Str: nil, right_B_Img:nil, right_title_Str: nil, title_Str: "Payment", hidden_Nav: false, left_Button: left_B , right_Button: nil)
        
    }
    
    @IBAction func left_Mathod_Action( _ sender : UIButton!)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    //MARK:- DropDown : get data for drop down if there so handle condtion
    func wallUpdate_Mathod(api_key : String!)
    {
        
        let parameters : [String : String] = ["user_id":GlobalVariables.sharedManager.user_id]
        
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: api_key, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_My_Wallet_Struct.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            self.my_Wallet_dic = modelVal!
            loader.hideLoader()
            
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            
            
            loader.hideLoader()
            }
        })
        
        
    }
    var my_Wallet_dic : Get_My_Wallet_Struct?
    
    func waletMathod()
    {
        
        
        if SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id != nil
        {
            let parameters : [String : String] = ["user_id":(SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!]
            Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getWallet, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_My_Wallet_Struct.self  , completion : {(success, modelVal) -> Void in if success
            {
                
                self.my_Wallet_dic = modelVal!
                if let Cty = self.my_Wallet_dic?.my_Wallet_Data?.currency_type , let amont = self.my_Wallet_dic?.my_Wallet_Data?.amount
                {
                    self.wallet_Label.text = "Your Wallet " + Cty + " " + amont
                }
                loader.hideLoader()
                // self.artistTableView.reloadData()
            }
            else
            {
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                loader.hideLoader()
                
                }
            })
            
        }
        
    }
    
    
    
    @IBAction func appleCodeCancel_Payment_Action( _ sender : UIButton!)
    {
        self.applyCode_Button.setTitle("APPLE CODE", for: .normal)
        
        self.applyCode_Button.removeTarget(self, action: #selector(self.appleCodeCancel_Payment_Action(_:)), for: .touchUpInside)
        self.applyCode_Button.addTarget(self, action: #selector(self.appleCode_Payment_Action(_:)), for: .touchUpInside)
        self.coupon_code = ""
        
    }
    
    @IBAction func appleCode_Payment_Action( _ sender : UIButton!)
    {
        
        
        
        if code_TF.text?.isEmpty == true
        {
            self.view.endEditing(true)
            Alert.showMiddleToast(message: "Please enter code", view_VC: self)
            return;
        }
        
        
        
        checkCoupon_Request(  api_key : Constant.kTo_checkCoupon, cupCode: code_TF.text!)
    }
    
    func checkCoupon_Request(  api_key : String!  , cupCode : String!   )
    {
        
        let parameters : [String : String] = ["user_id":GlobalVariables.sharedManager.user_id , "invoice_id":finished_Booking_Dic.invoice_id,  "coupon_code":cupCode]
        
        print(parameters)
        
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: api_key, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: CouponVal_stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            self.coupon_code = self.code_TF.text!
             GlobalVariables.sharedManager.coupon_Status = modelVal!
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.coupon_Status.message, view_VC: self)
            self.totalAmount_Str = String( GlobalVariables.sharedManager.coupon_Status.final_amount )
            self.totalAmount_Label.text =  String( GlobalVariables.sharedManager.coupon_Status.final_amount )
            self.totalAmount_Label.text  = self.finished_Booking_Dic.currency_type + self.totalAmount_Label.text!
            self.discountAmount = GlobalVariables.sharedManager.coupon_Status.discount_amount
            self.applyCode_Button.setTitle("Cancel", for: .normal)
            self.applyCode_Button.removeTarget(self, action: #selector(self.appleCode_Payment_Action(_:)), for: .touchUpInside)
            
            self.applyCode_Button.addTarget(self, action: #selector(self.appleCodeCancel_Payment_Action(_:)), for: .touchUpInside)
            
            loader.hideLoader()
            
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })
        
        
    }
    
    
    @IBAction func online_Payment_Action( _ sender : UIButton!)
    {
        
        
         let nextVC  = PayViewOptionViewController.viewController()
        
            finished_Booking_Dic.coupon_code = self.coupon_code
            nextVC.otherUserId = finished_Booking_Dic.artist_id
            nextVC.invoiceId = finished_Booking_Dic.invoice_id
            nextVC.checkIndex  = 2
            nextVC.walletCheck  = 0
            nextVC.finished_Booking_Dic = finished_Booking_Dic
            nextVC.amount_Str  = self.totalAmount_Str
            app_delegate.navi_obj = self.navigationController
            self.navigationController?.present(nextVC, animated: true);
        
         
        
    }
    
    @IBAction func payWallet_Payment_Action( _ sender : UIButton!)
    {
        
        let amountVal  = self.double_Convert_Mathod(dobStr: my_Wallet_dic?.my_Wallet_Data?.amount)
        
        
        let payAmountVal = self.double_Convert_Mathod(dobStr: totalAmount_Str)
        
        if amountVal! > payAmountVal!
        {
            Alert.alert_PopMathod(vc: self, title: Alert.msg, message_Str: Alert.msgcwallet_payment, action_Title: ["Ok" , "Cancel"], action_Style: [.default,.cancel] , action: [
                
                { Ok in
                    print("Ok")
                    self.payment_Request(  api_key : Constant.kTo_makePayment, payment_type: "2")
                },
                { Cancel in
                    print("Cancel")
                    
                }
                ]
                
                
            )
        }
        else
        {
            Alert.show(vc: self, titleStr: Alert.msg, messageStr: Alert.msgsufficientamount )
        }
        
        
        
        
    }
    
    @IBAction func cash_Payment_Action( _ sender : UIButton!)
    {
        
        
        Alert.alert_PopMathod(vc: self, title: Alert.msg, message_Str: Alert.msgCash_payment, action_Title: ["Ok" , "Cancel"], action_Style: [.default,.cancel] , action: [
            
            { Ok in
                print("Ok")
                self.payment_Request(  api_key : Constant.kTo_makePayment, payment_type: "1")
                
            },
            { Cancel in
                print("Cancel")
                
            }
            ]
            
            
        )
        
        
        
        //
        
    }
    
    //1. Cash 0. Online 2. Wallet
    //MARK:-getMyTicket
    func payment_Request(  api_key : String! , payment_type : String!   )
    {
        
        
        var parameters : [String : String] = ["user_id":GlobalVariables.sharedManager.user_id , "invoice_id":finished_Booking_Dic.invoice_id, "final_amount":totalAmount_Str, "payment_type":payment_type , "payment_status":"1","discount_amount":discountAmount] //, "coupon_code":""
        
        if self.coupon_code != ""
        {
            parameters["coupon_code"] = self.coupon_code
        }
        
        print(parameters)
        
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: api_key, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            GlobalVariables.sharedManager.get_Status = modelVal!
            
            loader.hideLoader()
            Alert.alert_PopMathod(vc: self, title: Alert.msg, message_Str: GlobalVariables.sharedManager.get_Status.message, action_Title: ["Ok" ], action_Style: [.default] , action: [
                
                { Ok in
                    print("Ok")
                    let review_Rating_ViewC : Review_Rating_ViewCont  =  Review_Rating_ViewCont.viewController()
                    review_Rating_ViewC.finished_Booking_Dic = self.finished_Booking_Dic
                    self.navigationController?.pushViewController(review_Rating_ViewC, animated: true)
                }
                ]
            )
            
            
            
            
            loader.hideLoader()
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            
            }
        })
        
    }
    
}
