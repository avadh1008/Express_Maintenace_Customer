//
//  Drop_Down_Class.swift
//  PetStand
//
//  Created by Samyotech on 31/05/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import DropDown
enum Drop_Connection_Result {
    case success(String , Int )
    case failure(Error)
    
}

struct Drop_Down_Class {
    
    
    static let sharedInstance = Drop_Down_Class()
    
    
    
    
    func setupChooseDropDown(vc: UIViewController , dropDown : DropDown! , drop_Header : UIView!  , arrayOfDrop :  NSArray, completion: @escaping (Drop_Connection_Result) -> ()) {
        dropDown.anchorView = drop_Header
        
        dropDown.bottomOffset = CGPoint(x: 0, y: drop_Header.bounds.height)

        dropDown.dataSource.removeAll()
      //  dropDown.dataSource.append("- Select Job Categories -")
        for (index, element) in arrayOfDrop.enumerated()
        {
            
            dropDown.dataSource.append(element as! String)
            
        }
        
        
        // Action triggered on selection
        
        dropDown.selectionAction = { [weak vc ] (index, item) in
           print(item)
            completion(.success(item, index))
            
        }
    }
    
    // MARK: -  Drop down Mathod
    func customizeDropDown(dropDowns: [DropDown]) {
        let appearance = DropDown.appearance()
        
        appearance.cellHeight = 40
        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        appearance.selectionBackgroundColor = UIColor(red: 0.6494, green: 0.8155, blue: 1.0, alpha: 0.2)
        //        appearance.separatorColor = UIColor(white: 0.7, alpha: 0.8)
        appearance.cornerRadius = 10
        appearance.shadowColor = UIColor(white: 0.6, alpha: 1)
        appearance.shadowOpacity = 0.9
        appearance.shadowRadius = 25
        appearance.animationduration = 0.25
        appearance.textColor = .black
        //        appearance.textFont = UIFont(name: "Georgia", size: 14)
        
        dropDowns.forEach {
            /*** FOR CUSTOM CELLS ***/
            $0.cellNib = UINib(nibName: "MyCell", bundle: nil)
            
            $0.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                guard let cell = cell as? MyCell else { return }
                
                // Setup your custom UI components
                //cell.suffixLabel.text = "Suffix \(index)"
            }
            /*** ---------------- ***/
        }
    }
    
    
    
}
