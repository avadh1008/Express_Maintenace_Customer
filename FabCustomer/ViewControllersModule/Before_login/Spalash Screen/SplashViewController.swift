//
//  SplashViewController.swift
//  Pixel eCommerce
//
//  Created by samyotech on 11/11/17.
//  Copyright © 2017 samyotech. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    
    
    class func viewController() -> SplashViewController {
        return "Main".viewController("SplashViewController") as! SplashViewController
    }
    
    var count = 0
    let globel_variable = GlobalVariables.sharedManager
    @IBOutlet weak var lblDesription: UILabel!
    @IBOutlet weak var lblHeaderName: UILabel!
    @IBOutlet weak var imgCollection: UIImageView!
    
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    @IBOutlet weak var backGroundImgV : UIImageView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    @IBOutlet weak var btnsignup: UIButton!
    
    @IBOutlet weak var btnsignin: UIButton!
    @IBOutlet var collectionWalkingView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auto_Login()
        
        
        
    }
    
    func auto_Login()
    {
        
        Revoke_Service_Class.sharedInstance.get_Data_NsUser_Default(vc: self,completion : { (success) -> Void in
            if success
            {
                loader.hideLoader()
                
                
                
                loader.hideLoader()
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                
                
                let mainVC = SJSwiftSideMenuController()
                
                let sideVC_L : MenuViewController = MenuViewController.viewController()
                
                let rootVC = self.storyBoard.instantiateViewController(withIdentifier: "ViewController") as UIViewController
                //JobMainVIewControllerViewController
                //is_profile
                //Job_Select_On_Map_VCon
                SJSwiftSideMenuController.setUpNavigation(rootController: rootVC, leftMenuController: sideVC_L,  leftMenuType: .SlideOver, rightMenuType: .SlideView)
                
                SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
                
                SJSwiftSideMenuController.enableDimbackground = true
                SJSwiftSideMenuController.leftMenuWidth = self.view.frame.width-70
                //=======================================
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                appDelegate.window?.rootViewController = mainVC
                appDelegate.window?.makeKeyAndVisible()
                
                
                
            }
            else
            {
                loader.hideLoader()
                
            }
        })
    }
    
    func updateSplashMathod()
    {
        //Add SwipeGesture Left
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        //Add SwipeGesture Right
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        
        backGroundImgV.image =   UIImage(named: "Wc1")
        self.imgCollection.image = UIImage(named: "Wc1name")!
        self.lblHeaderName.text = defaultLocalizer.stringForKey(key:"Search your nearby Make-up Artist and Hair Stylish.")
        self.lblDesription.text = defaultLocalizer.stringForKey(key:"Get your best service from us")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSplashMathod()
        auto_Login()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        btnsignup.layer.cornerRadius = 20
        btnsignup.clipsToBounds = true
        btnsignin.layer.cornerRadius = 20
        btnsignin.clipsToBounds = true
        
        btnsignin.layer.borderWidth = 5 / UIScreen.main.nativeScale
        btnsignin.layer.borderColor = UIColor.white.cgColor
        //        btnsignup.layer.borderWidth = 5 / UIScreen.main.nativeScale
        //        btnsignup.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    
    
    //MARK: - Handle Gesture
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            
            if count > 0 {
                count -= 1
                print(count)
            }
            print("Swipe Right")
        }
            
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            
            if count < 2 {
                count += 1
                print(count)
                
                var a = 0
                var b = 0
                if IOS_Device.kIphone_5 || IOS_Device.kIphone_4s {
                    a = 40
                    b = 35
                }else if IOS_Device.kIphone_6 {
                    a = 45
                    b = 40
                }else if IOS_Device.kIphone_X {
                    a = 25
                    b = 10
                }else {
                    a = 50
                    b = 45
                }
                
                //Animation for Next Button
                if self.count == 2 {
                    //    self.centerHBtn.constant = -414
                    self.view.layoutIfNeeded()
                    UIView.animate(withDuration: 0.8, animations: {
                        //    self.centerHBtn.constant = CGFloat(a)
                        self.view.layoutIfNeeded()
                    }, completion: { (is_compleate) in
                        UIView.animate(withDuration: 0.3, animations: {
                            //       self.centerHBtn.constant = CGFloat(b)
                            self.view.layoutIfNeeded()
                        }, completion: { (is_compleate) in})
                    })
                    
                }
            }
            print("Swipe Left")
        }
        
        
        //[.curveEaseIn, .autoreverse]
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveLinear, .curveEaseIn], animations: {
            if self.count == 0 {
                self.view.backgroundColor = UIColor.init(red: 253.0/255.0, green: 147.0/255.0, blue: 52.0/255.0, alpha: 1.0)
                self.lblHeaderName.text = self.defaultLocalizer.stringForKey(key:"Search your nearby \n Make-up Artist \n and Hair Stylish.")
                self.lblDesription.text = self.defaultLocalizer.stringForKey(key:"Get your best service from us")
                self.backGroundImgV.image =    UIImage(named: "Wc1")!
                
            }else if self.count == 1 {
                if self.count == 1 {
                    UIView.animate(withDuration: 0.5, animations: {
                        //   self.centerHBtn.constant = -414
                        self.view.layoutIfNeeded()
                    }, completion: { (is_compleate) in})
                }
                self.view.backgroundColor = UIColor.init(red: 253.0/255.0, green: 147.0/255.0, blue: 52.0/255.0, alpha: 1.0)
                self.lblHeaderName.text = self.defaultLocalizer.stringForKey(key:"Make yourself more beautiful more than you think.")
                self.lblDesription.text = self.defaultLocalizer.stringForKey(key:"Get your best service from us")
                self.backGroundImgV.image =   UIImage(named: "Wc2")!
            }else {
                self.view.backgroundColor = UIColor.init(red: 253.0/255.0, green: 147.0/255.0, blue: 52.0/255.0, alpha: 1.0)
                self.lblHeaderName.text = self.defaultLocalizer.stringForKey(key:"Hire the best Photographer & create your moment.")
                self.lblDesription.text = self.defaultLocalizer.stringForKey(key:"Get your best service from us")
                self.backGroundImgV.image =   UIImage(named: "Wc3")!
            }
            self.pageControl.currentPage = self.count
        }, completion:{ (is_compleate) in})
        
    }
    
    @IBAction func Signup(_ sender: Any) {
        print("Signup")
        
        let signVC = SignupVC.viewController()
        self.navigationController?.pushViewController(signVC, animated: true)
        
        
    }
    @IBAction func Signin(_ sender: Any) {
        print("Signin")
        
        let logVc = LoginVC.viewController()
        self.navigationController?.pushViewController(logVc, animated: true)
    }
}

