//
//  Add_Money_VCont.swift
//  FabArtist
//
//  Created by apple on 03/11/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class Add_Money_VCont: UIViewController {
    
    class func viewController() -> Add_Money_VCont {
        return "Main".viewController("Add_Money_VCont") as! Add_Money_VCont
    }

    let left_B = UIButton()
    let right_B = UIButton()
    var money_Str = 0
    
    var txn_id  = ""
    var  order_id = ""
    
    @IBOutlet weak var wallet_balnce : UILabel!
    let  globel_Var = GlobalVariables.sharedManager
    @IBOutlet weak var amnt_TF : HoshiTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        amnt_TF.delegate = self
        if let image : UIImage = UIImage(named: "menu")  {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
            //  SJSwiftSideMenuController .showRightMenuNavigationBarButton(image: image)
        }
        amnt_TF.keyboardType = .numberPad
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        create_Navigation_Bar_Mathod()
        wallet_Update()
        amnt_TF.text = ""
        money_Str = 0
    }
    var my_Wallet_dic : Get_My_Wallet_Struct?
    
    func wallet_Update()
    {
        
       
        if SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id != nil
        {
            let parameters : [String : String] = ["user_id":(SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!]
            Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getWallet, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_My_Wallet_Struct.self  , completion : {(success, modelVal) -> Void in if success
            {
                
                self.my_Wallet_dic = modelVal!
                if let Cty = self.my_Wallet_dic?.my_Wallet_Data?.currency_type , let amont = self.my_Wallet_dic?.my_Wallet_Data?.amount
                {
                    self.wallet_balnce.text = Cty + " " + amont
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
    
    func create_Navigation_Bar_Mathod()
    {
        left_B.addTarget(self, action: #selector(self.left_Mathod_Action(_:)), for: .touchUpInside)
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "back2"), left_title_Str: nil, right_B_Img:nil, right_title_Str: nil, title_Str: "Add Money", hidden_Nav: false, left_Button: left_B , right_Button: nil)
        
    }
   
    @IBAction func left_Mathod_Action( _ sender : UIButton!)
    {
        if let image : UIImage = UIImage(named: "menu")
        {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
            
        }
        navigationController?.popViewController(animated: false)
    }
    
    @IBAction func add_Money_Action( _ sender : UIButton!)
    {
        if sender.tag == 1
        {
            money_Str = 1000
        }
        else if sender.tag == 2
        {
            money_Str = 1500
        }
        else if  sender.tag == 3
        {
            money_Str = 2000
        }
       
        if amnt_TF.text!.isEmpty == false
        {
           
          amnt_TF.text = String( money_Str + conv_Str_Int_Mathod(str_In_V: amnt_TF.text!))
        }
        else
        {
            amnt_TF.text = String( money_Str )
        }
        
        
    }
    
    func validateData() -> Bool {
        
        
        guard !amnt_TF.text!.isEmpty else {
            
            Alert.show(vc: self, titleStr: Alert.msg, messageStr: Alert.amount_msg)
            return false
        }

        return true
        
    }
    
    @IBAction func add_Action( _ sender : UIButton!)
    {
        add_Mathod(api_key: Constant.kTo_addMoney)
    }
    
    //
    func add_Mathod( api_key : String!   ) // , type : String!
    {
        
        txn_id = randomString(length: 8)
        order_id = randomString(length: 8)
        guard validateData() else { return }
        
      
        
        /*let pay_WVC : Pay_WebViewCont  = self.storyboard?.instantiateViewController(withIdentifier: "Pay_WebViewCont") as! Pay_WebViewCont
        pay_WVC.checkIndex = 2
        pay_WVC.walletCheck = 1
        pay_WVC.amount_Str = amnt_TF.text!
      //  pay_WVC.finished_Booking_Dic = self.finished_Booking_Dic
     self.navigationController?.pushViewController(pay_WVC , animated: true)
        */
        if let nextVC : PayViewOptionViewController = PayViewOptionViewController.viewController()
        {
            nextVC.checkIndex  = 3
            nextVC.navTag = 1
            nextVC.walletCheck  = 1
            nextVC.amount_Str  = amnt_TF.text!
            app_delegate.navi_obj = self.navigationController
            
            self.navigationController?.present(nextVC, animated: true);
        }
        
        
        
       
        
    }

    
    
}

extension Add_Money_VCont : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        
        money_Str = conv_Str_Int_Mathod(str_In_V: textField.text!)
        return true
    }
}
