//
//  SignupVC.swift
//  FabCustomer
//
//  Created by Samyotech on 15/02/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

import CountryPickerView


class SignupVC: UIViewController   {
    
    class func viewController() -> SignupVC {
        return "Main".viewController("SignupVC") as! SignupVC
    }
  
    @IBOutlet weak var emailTF : UITextField?{
        didSet{
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
            emailTF?.leftView = leftView
               emailTF?.leftViewMode = .always
            emailTF?.keyboardType = .emailAddress
        }
        
              
    }
    @IBOutlet weak var passTF : UITextField?{
        didSet{
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
            passTF?.leftView = leftView
               passTF?.leftViewMode = .always
            passTF?.textContentType = .password
            passTF?.isSecureTextEntry = true
        }
        
              
    }
    
    @IBOutlet weak var confirmPassTF : UITextField?{
        didSet{
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
            confirmPassTF?.leftView = leftView
               confirmPassTF?.leftViewMode = .always
            confirmPassTF?.textContentType = .password
            confirmPassTF?.isSecureTextEntry = true
        }
        
              
    }
    
    @IBOutlet weak var firstNameTF : UITextField?{
        didSet{
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
            firstNameTF?.leftView = leftView
               firstNameTF?.leftViewMode = .always
            firstNameTF?.textContentType = .username
        }
        
              
    }
    @IBOutlet weak var seondNameTF : UITextField?{
        didSet{
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
            seondNameTF?.leftView = leftView
               seondNameTF?.leftViewMode = .always
            seondNameTF?.textContentType = .username
        }
        
              
    }
    
    
    
    
    
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    let globel_variable = GlobalVariables.sharedManager
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    
    let mainVC = SJSwiftSideMenuController()
    
   
    override func viewWillAppear(_ animated: Bool) {
         
        super.viewWillAppear(animated)
         
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.navigationController == nil   {
            
        }
        else  {
            globel_variable.glo_Navi_Cotro = self.navigationController
        }
         
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
      
    
    
    //MARK:- Show login page
    @IBAction func Signin(_ sender: Any) {
        print("Signin")
        
       
        let LoginVC:LoginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
          
        
        self.navigationController?.pushViewController(LoginVC, animated: true)
        //self.performSegue(withIdentifier: "SIGNIN", sender: nil)
    }
    
    //MARK:- Register New USer
      @IBAction func signUpnMathod(_ sender: Any) {
        
        self.hideKeyboardWhenTappedAround()
        print("Register new user")
        Signup()
        
    }
    
     
    
   
    //API CALL REGISTER USER /ARTIST:-
    func Signup() {
        
         self.view.endEditing(true)
        
        
        guard let firstNameTF =   firstNameTF?.text else {
            return
        }
        
        guard let seondNameTF =   seondNameTF?.text else {
                   return
               }
        
        
        guard let emailTF =   emailTF?.text else {
            return
        }
        guard let passTF =   passTF?.text else {
            return
        }
        guard let confirmPassTF =   confirmPassTF?.text else {
            return
        }
        
        
        
        
        
        
        if firstNameTF.isEmpty == true {
            
            
            Alert.showMiddleToast(message: Alert.kEmpty_Name, view_VC: self)
                     
                   return;
                   
               }
        else  if seondNameTF.isEmpty == true {
                   
             Alert.showMiddleToast(message: Alert.kEmpty_LasName, view_VC: self)
                   return;
                   
               }
         
        else if emailTF .isEmpty == true {
            
             Alert.showMiddleToast(message: Alert.Email_msg, view_VC: self)
            return;
            
        } else   if self.isValidEmail(testStr:( emailTF )) == false
        {
             Alert.showMiddleToast(message: Alert.Email_not_Vaild_msg, view_VC: self)
            
           
            return;
            
        }  else if  passTF .isEmpty == true {
             Alert.showMiddleToast(message: Alert.kEmpty_Password, view_VC: self)
             
           
            return;
            
        }  else if  confirmPassTF.isEmpty == true   {
             Alert.showMiddleToast(message: Alert.kEmpty_Confirm_Password , view_VC: self)
                     
                  
                   return;
                   
               }
        
        else if  confirmPassTF  !=   passTF   {
             Alert.showMiddleToast(message: Alert.kPassword_ConfirmPassword_NotMatch, view_VC: self)
              
           
            return;
            
        }
       
       
        
        
        let parameters : [String : String] = ["name": firstNameTF ,"last_name": seondNameTF ,"email_id": emailTF ,"password": passTF ,"role":"2","device_id":GlobalVariables.sharedManager.strDeviceToken! , "device_token":GlobalVariables.sharedManager.strFBDeviceToken! , "device_type":"ios" ]
         
        print(parameters)
         
        
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_SignUp, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            
                GlobalVariables.sharedManager.get_Status = modelVal!
                
                
            Alert.alert_PopMathod(vc: self, title: Alert.successMsg, message_Str: GlobalVariables.sharedManager.get_Status.message, action_Title: ["Ok"], action_Style: [.default], action: [
                {
                    ok in
                    let nextVC : LoginVC = LoginVC.viewController()
                    self.navigationController?.pushViewController(nextVC, animated: true)
                    
                }])
            
           // Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })
       
        
    }
   
}
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
