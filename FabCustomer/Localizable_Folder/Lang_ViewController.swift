//
//  Lang_ViewController.swift
//  FabArtist
//
//  Created by apple on 18/10/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class Lang_ViewController: UIViewController {
    
    class func viewController() -> Lang_ViewController {
        return "Main".viewController("Lang_ViewController") as! Lang_ViewController
    }
    
    @IBOutlet weak var A_lang_B : UIButton!
    @IBOutlet weak var E_lang_B : UIButton!
    @IBOutlet weak var lang_Label : UILabel!
    
    let  global_Ver = GlobalVariables.sharedManager
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    override func viewDidLoad() {
        super.viewDidLoad()
        
        E_lang_B.tag = 1
        A_lang_B.tag = 2
        refresh_Lang()
        create_Navigation_Bar_Mathod()
    }
    
    func navigationbarSetUp() {
        //set naviggation backgroun image
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let image = UIImage(named: "Header_bar")
        self.navigationController?.navigationBar.setBackgroundImage(image,for: .default)
        navigationItem.title = defaultLocalizer.stringForKey(key: "LANGUAGE")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
       
    
        
    }
    
    
    
    let left_B = UIButton()
    let right_B = UIButton()
    func create_Navigation_Bar_Mathod()
    {
        if let image : UIImage = UIImage(named: "menu")
        {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
        }
        
        left_B.addTarget(self, action: #selector(self.left_Mathod_Action(_:)), for: .touchUpInside)
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "back2"), left_title_Str: nil, right_B_Img:nil, right_title_Str: nil, title_Str: "Language", hidden_Nav: false, left_Button: left_B , right_Button: nil)
        
    }
    
    @IBAction func left_Mathod_Action( _ sender : UIButton!)
    {
        if let image : UIImage = UIImage(named: "menu")
        {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
        }
       let backVc = ProfileSettingViewController.viewController()
        self.navigationController?.pushViewController(backVc, animated: false)
        
    }
    
    
    @IBAction func language_Selection_Action(_ sender : UIButton!)
    {
        if sender.tag == 1
        {
            
            defaultLocalizer.setSelectedLanguage(lang: "en")
        }
        else if sender.tag == 2
        {
            
            defaultLocalizer.setSelectedLanguage(lang: "ar")
        }
        refresh_Lang()
       
        
    }
    
    func refresh_Lang()
    {
        navigationItem.title = defaultLocalizer.stringForKey(key: "LANGUAGE")
        
        lang_Label.text! = defaultLocalizer.stringForKey(key: "LANGUAGE")
        A_lang_B.setTitle(defaultLocalizer.stringForKey(key: "Arabic"), for: .normal)
    }

    
    
}

