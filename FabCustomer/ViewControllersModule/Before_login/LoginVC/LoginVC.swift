////
////  LoginVC.swift
////  FabCustomer
////
////  Created by Samyotech on 15/02/18.
////  Copyright © 2018 Samyotech. All rights reserved.


import UIKit

/*enum UserDefaultsKeys : String {
 case isLoggedIn
 case userID
 }*/
class LoginVC: UIViewController  {
    
    class func viewController() -> LoginVC {
        return "Main".viewController("LoginVC") as! LoginVC
    }
    
    @IBOutlet weak var emailTF : UITextField!{
        didSet{
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
            emailTF.leftView = leftView
               emailTF.leftViewMode = .always
            emailTF.textContentType = .emailAddress
        }
        
              
    }
    @IBOutlet weak var passTF : UITextField!{
        didSet{
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0))
            passTF.leftView = leftView
               passTF.leftViewMode = .always
            passTF.textContentType = .password
            passTF.isSecureTextEntry = true
        }
        
              
    }
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    var user_Emid = ""
    var user_Pass = ""
    // Testing login id and pass
   // let user_email_Hard = "a@gmail.com"
  ///  let user_pass_Hard = "123456"
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    
    let mainVC = SJSwiftSideMenuController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    
    //MARK:- Show Signup page
    @IBAction func Signup(_ sender: Any) {
        print("Signup")
        
        
        user_Emid = ""
        user_Pass = ""
        
        let transition = CATransition()
        let SignupVC:SignupVC = storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.moveIn;
        transition.subtype = CATransitionSubtype.fromRight;
        navigationController?.view.layer.add(transition, forKey: CATransitionSubtype.fromTop.rawValue)
        
        self.navigationController?.pushViewController(SignupVC, animated: true)
        
    }
    
    
    @IBAction  func loginUser(_ sender :  UIButton) {
        
        self.hideKeyboardWhenTappedAround()
        
        Login()
    }
    
    @IBAction  func forgetpassword(_ sender :  UIButton)
    {
     
        let rootVC = storyBoard.instantiateViewController(withIdentifier: "Forget_Pass_ViewCont") as! Forget_Pass_ViewCont
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.moveIn;
        transition.subtype = CATransitionSubtype.fromRight;
        navigationController?.view.layer.add(transition, forKey: CATransitionSubtype.fromTop.rawValue)
        self.navigationController?.pushViewController(rootVC, animated: true)
        
        
    }
     
    
    //API CALL REGISTER USER /ARTIST:-
    func Login()
    {
        
        guard let user_email =  emailTF?.text else {return }
        guard let user_pass =  passTF?.text  else {return }
        
        
        
        
        
        if user_email .isEmpty == true {
            
             Alert.showMiddleToast(message: Alert.Email_msg, view_VC: self)
            return;
            
        } else   if self.isValidEmail(testStr:( user_email )) == false
        {
             Alert.showMiddleToast(message: Alert.Email_not_Vaild_msg, view_VC: self)
            
           
            return;
            
        }  else if  user_pass .isEmpty == true {
             Alert.showMiddleToast(message: Alert.kEmpty_Password, view_VC: self)
             
           
            return;
            
        }
        else
        {
            
            let parameters : [String : String] = ["email_id": user_email ,"password": user_pass,"device_id":GlobalVariables.sharedManager.strDeviceToken! , "device_token":GlobalVariables.sharedManager.strFBDeviceToken! , "device_type":"ios" ,"role":"2"]
            
            print(parameters)
            loader.showLoader()
           
            Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_signIn, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_SignUp_Struct.self  , completion : {(success, modelVal) -> Void in if success
            {
                do
                {
                    
                    
                    SignUpDataClass.shareMngr.signUpData =  modelVal
                    if let useID = SignUpDataClass.shareMngr.signUpData?.SignUdata?.user_id
                    {
                        GlobalVariables.sharedManager.user_id = useID
                        Revoke_Service_Class.sharedInstance.save_Data_NsUser_Default(vc: self, dic_Data:  try (modelVal).asDictionary() as NSDictionary)
                        loader.hideLoader()
                        Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                        
                        loader.hideLoader()
                        
                        
                        
                        let sideVC_L : MenuViewController = MenuViewController.viewController()
                        
                        let rootVC = self.storyBoard.instantiateViewController(withIdentifier: "ViewController") as UIViewController
                        
                        SJSwiftSideMenuController.setUpNavigation(rootController: rootVC, leftMenuController: sideVC_L,  leftMenuType: .SlideOver, rightMenuType: .SlideView)
                        
                        SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
                        
                        SJSwiftSideMenuController.enableDimbackground = true
                        SJSwiftSideMenuController.leftMenuWidth = self.view.frame.width-70
                        //=======================================
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = self.mainVC
                        appDelegate.window?.makeKeyAndVisible()
                    }
                }
                catch
                {
                    print(error)
                }
                
            }
            else
            {
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                loader.hideLoader()
                
                }
            })
            
            
        }
    }
    
   
}



