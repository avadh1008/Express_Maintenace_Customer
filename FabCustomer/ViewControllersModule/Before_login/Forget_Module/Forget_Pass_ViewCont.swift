//
//  Forget_Pass_ViewCont.swift
//  FabCustomer
//
//  Created by Apple on 09/05/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit
class Forget_Pass_ViewCont: UIViewController  , UITextFieldDelegate{
    
    class func viewController() -> Forget_Pass_ViewCont {
        return "Main".viewController("Forget_Pass_ViewCont") as! Forget_Pass_ViewCont
    }
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    
    let globel_variable = GlobalVariables.sharedManager
    @IBOutlet weak var Email_TF: HATextField!
    @IBOutlet weak var submit_Button_Out :  UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Email_TF.delegate = self
        Email_TF.layer.cornerRadius = 23
        Email_TF.clipsToBounds = true
        submit_Button_Out.layer.cornerRadius = 23
        submit_Button_Out.clipsToBounds = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Forget_Pass_ViewCont.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    //Hide Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when   'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)    {
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        create_Navigation_Bar_Mathod()
      
        
    }
    
    
    let left_B = UIButton()
    let right_B = UIButton()
    
    func create_Navigation_Bar_Mathod()
    {
        left_B.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "back2"), left_title_Str: nil, right_B_Img:nil, right_title_Str: nil, title_Str: "Forgot Password", hidden_Nav: false, left_Button: left_B , right_Button: nil)
        
    }
    @IBAction func backAction(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true )
      
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
    
    @IBAction func backLLogin(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
        
     
    }
    
    
    @IBAction func Forget_Submit_Action(_ sender: UIButton)
    {
        if Email_TF.text?.isEmpty == true
        {
            Alert.show(vc: self, titleStr: Alert.kTitle, messageStr:Alert.kInvalid_Email )
        }
            
        else    if self.isValidEmail(testStr: Email_TF.text!) == false
        {
            //login api calling
            Alert.show(vc: self, titleStr: "Message", messageStr: defaultLocalizer.stringForKey(key: "Please Enter Valid Email Id  "))
            //self.performSegue(withIdentifier: "Home", sender: nil)
            return
            
        }
        else
        {
            let parameters : [String : String] = ["email_id" : Email_TF.text!  ]
            
            
            loader.showLoader()
            Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_forgotPassword, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr :  nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
            {
                
                GlobalVariables.sharedManager.get_Status = modelVal!
                loader.hideLoader()
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                self.navigationController?.popViewController(animated: true )
                
                loader.hideLoader()
            }
            else
            {
                loader.hideLoader()
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                
                }
            })
            
            
         
        }
        
    }
    
  
    
}
