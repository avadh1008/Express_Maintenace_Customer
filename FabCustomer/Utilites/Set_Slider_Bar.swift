//
//  TableViesfwCell.swift
//  WEDDING_APP
//
//  Created by Samyotech on 03/09/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit
import Parchment

struct Set_Slider_Bar
{
    static let sharedInstance = Set_Slider_Bar()
    
    // Mathod To craete slider of guest type
    func create_Slider_Mathod( vc: UIViewController , view_To_Show : UIView , pagingViewController : FixedPagingViewController)
    {
         pagingViewController.menuItemSize  = .sizeToFit(minWidth: 80, height: 60)
        
        pagingViewController.view.backgroundColor = UIColor.clear//Constant.Wall_Boder_Color_D
        //pagingViewController.menuBackgroundColor
        pagingViewController.selectedBackgroundColor = Constant.header_Color //Constant.Wall_Boder_Color_D
        pagingViewController.menuBackgroundColor = Constant.header_Color
        pagingViewController.backgroundColor = Constant.header_Color
        //pagingViewController.menuItemSize = .fixed(width: 100, height: 58)
        pagingViewController.selectedTextColor = UIColor.white//Constant.label_Color_Orange
        pagingViewController.textColor = UIColor.black
        //pagingViewController.font.withSize(25)
        
        pagingViewController.borderColor = UIColor.clear//Constant.Wall_Boder_Color_D
        pagingViewController.indicatorColor =  UIColor.blue//Constant.View_Color_Orange
        
        pagingViewController.removeFromParent()
        vc.addChild(pagingViewController)
        pagingViewController.view.removeFromSuperview()
        view_To_Show.addSubview(pagingViewController.view)
        view_To_Show.constrainToEdges(pagingViewController.view)

       /* pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingViewController.view.topAnchor.constraint(equalTo: vc.view.topAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
            pagingViewController.view.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor),
            ])
        */
        pagingViewController.didMove(toParent: vc)
    }
    
}
