//
//  dsf asdfadsfCollectio fsdnViewCell.swift
//  
//
//  Created by Samyotech on 13/06/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

struct Set_Navigation_Bar_Class
{
    static let sharedInstance = Set_Navigation_Bar_Class()

    func navigation_bar_Set_Up( vc: UIViewController  , left_B_Img : UIImage! ,left_title_Str : String? , right_B_Img : UIImage! , right_title_Str : String? , title_Str : String! , hidden_Nav : Bool , left_Button : UIButton? , right_Button : UIButton? )
    {
        
        vc.navigationController?.isNavigationBarHidden = false
        vc.navigationController?.navigationBar.backItem?.title = ""
        vc.navigationItem.setHidesBackButton(true, animated:false)
       
        let titleLabel = UILabel()
     
        titleLabel.text = title_Str
        titleLabel.font =  UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.sizeToFit()
        titleLabel.textColor =  UIColor.white
        titleLabel.backgroundColor =  UIColor.clear
        
        titleLabel.sizeToFit()
        vc.navigationItem.titleView = titleLabel
        //vc.navigationController?.navigationBar.barTintColor = Constant.button_Purpule_color
        
        let image = UIImage(named: "Header_bar")
        vc.navigationController?.navigationBar.setBackgroundImage(image,for: .default)
     
        if left_Button ==  nil
        {
            
        }
        else
        {
            
            
            left_Button?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            if left_title_Str != nil
            {
                left_Button?.setImage( nil  , for: .normal)
                left_Button?.setTitle(left_title_Str, for: .normal)
                
            }
            else
            {
                left_Button?.setTitle("", for: .normal)
                left_Button?.setImage( left_B_Img  , for: .normal)
            }
            
            
            let item1 = UIBarButtonItem(customView: left_Button!)
            
            vc.navigationItem.setLeftBarButtonItems([item1], animated: true)
            
        }
        if right_Button == nil
        {
            
        }
        else
        {
            right_Button?.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
            
            if right_title_Str != nil
            {
                right_Button?.setImage( nil  , for: .normal)
                right_Button?.setTitle(right_title_Str, for: .normal)
                
            }
            else
            {
                right_Button?.setTitle("", for: .normal)
                right_Button?.setImage( right_B_Img  , for: .normal)
                
            }
            
            let barButtonItem2 = UIBarButtonItem(customView: right_Button!)
            vc.navigationItem.rightBarButtonItems = [ barButtonItem2]
        }
        
        vc.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
      
        vc.navigationController?.setNavigationBarHidden(hidden_Nav, animated: false)
        
        
        //vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
     
        vc.navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: .clear)
       
        vc.navigationController?.navigationBar.isTranslucent = false
       
        
      if titleLabel.text?.isEmpty == true
      {
        vc.navigationController?.navigationBar.shadowImage = UIImage()
        
        }
    }
    
    
    
    // Navigate Mathod ;-
    
    /*func next_Move_VC( vc: UIViewController , next_VC_Str : String! )
    {
        let next_VC   = vc.storyboard?.instantiateViewController(withIdentifier: next_VC_Str)
        
        let transition:CATransition = CATransition()
        
        transition.duration = 0.7
        
    
        transition.type = kCATransitionMoveIn
        
        transition.subtype = kCATransitionFromLeft
        
        let vc_st =  String(describing: type(of: vc))
        
        if vc_st == next_VC_Str
        {
            
        }
        else
        {
            vc.navigationController!.view.layer.add(transition, forKey: kCATransition)
            vc.navigationController?.pushViewController(next_VC!, animated: false)
        }
        
    }*/
    
    func next_VC_Animation_Move( vc: UIViewController , next_VC_Str : String! , transition_T:CATransition )
    {
        let next_VC   = vc.storyboard?.instantiateViewController(withIdentifier: next_VC_Str)
        
        transition_T.duration = 0.7
       
     
        let vc_st =  String(describing: type(of: vc))
        
        if vc_st == next_VC_Str
        {
            
        }
        else if vc.navigationController != nil
        {
            vc.navigationController!.view.layer.add(transition_T, forKey: kCATransition)
            vc.navigationController?.pushViewController(next_VC!, animated: false)
        }
        /*else
        {
           
           vc.naviGateFunc(Next_VC:next_VC_Str)
            
            
        }*/
        
        
    }

    
}
extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
