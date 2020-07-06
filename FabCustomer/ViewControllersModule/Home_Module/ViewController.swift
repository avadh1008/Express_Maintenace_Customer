//
//  DashViewController.swift
//  FabCustomer
//
//  Created by Apple on 01/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit
import DropDown


class ViewController: UIViewController {
    
    class func viewController() -> ViewController {
        return "Main".viewController("ViewController") as! ViewController
    }
    
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    let globel_variable = GlobalVariables.sharedManager
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var viewFream: UIView!
    
    var cat_id = ""
    var cat_Str = ""
    var user_lat = ""
    var user_long = ""
    var segmentTag = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        LocationManager.shared.requestLocationAtOnce()
        create_Navigation_Bar_Mathod(ind: 1)
        segmentControl.selectedSegmentIndex = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let nextVc : CategoryNewViewController = CategoryNewViewController.viewController()
        nextVc.cat_id =  cat_id
        
        add(nextVc, frame: self.viewFream.frame)
        
    }
    
    
    
    let left_B = UIButton()
    var right_B = UIButton()
    func create_Navigation_Bar_Mathod(ind : Int )
    {
        
         
        
        if let image : UIImage = UIImage(named: "menu")
        {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
        }
        
        if ind == 0{
            
            
                  left_B.addTarget(self, action: #selector(self.left_Mathod_Action(_:)), for: .touchUpInside)
                  right_B = UIButton()
                  Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "menu"), left_title_Str: nil, right_B_Img:UIImage(named: ""), right_title_Str: nil, title_Str: "Home", hidden_Nav: false, left_Button: left_B , right_Button: right_B)
            
        } else {
            
                  left_B.addTarget(self, action: #selector(self.left_Mathod_Action(_:)), for: .touchUpInside)
                  right_B.addTarget(self, action: #selector(right_Mathod_Action(_:)), for: .touchUpInside)
                  Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "menu"), left_title_Str: nil, right_B_Img:UIImage(named: "cart"), right_title_Str: nil, title_Str: "Home", hidden_Nav: false, left_Button: left_B , right_Button: right_B)
        }
      
        
    }
    
    let cateVc  = CategoryNewViewController.viewController()
    
    @IBAction func right_Mathod_Action( _ sender : UIButton!)
    {
        
        if segmentTag == 1 {
            
            
            cateVc.openSelectionType()
            
            segmentTag = 1
             cateVc.cat_id =  cat_id
             add(cateVc, frame: self.viewFream.frame)
            
            
            /* if let  nextVc  =  po.nextVc {
            nextVc.dataTag = 1
                self.navigationController?.present(nextVc,animated: true  )
            }*/
            
        }  else {
             cateVc.openSelectionType2()
        }
        
    }
    @IBAction func left_Mathod_Action( _ sender : UIButton!)
    {
        if let image : UIImage = UIImage(named: "menu")
        {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
        }
        SJSwiftSideMenuController.toggleLeftSideMenu()
    }
    
    
    // left menu toggle
    @IBAction func toggleLeftSideMenutapped(_ sender: AnyObject) {
        SJSwiftSideMenuController.toggleLeftSideMenu()
    }
    @IBAction func segmentDidChanged(_ sender: UISegmentedControl) {
        // print(sender.titles[sender.selectedIndex])
        
        print(sender.selectedSegmentIndex)
        
        switch sender.selectedSegmentIndex
        {
        case 0:
            create_Navigation_Bar_Mathod(ind: 1)
           
            segmentTag = 1
            cateVc.cat_id =  cat_id
            add(cateVc, frame: self.viewFream.frame)
            
        case 1:
            
            create_Navigation_Bar_Mathod(ind: 0)
            let po  = MapNewViewController.viewController()
            segmentTag = 2
            po.cat_id =  cat_id
            add(po, frame: self.viewFream.frame)
            
            
        default:
            break;
        }
        
    }
    
    
}
