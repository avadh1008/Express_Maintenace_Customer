//
//  f dfas dfas df.swift
//  
//
//  Created by Samyotech on 13/06/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

struct Register_Nib_With_Delegate
{
    static let sharedInstance = Register_Nib_With_Delegate()
   
 
    // Register nib class fot tableview only and with delegate
    func register_Mathod( vc: UIViewController ,  tableV_Name : UITableView! , cell_Identity : String! )
    {
        if tableV_Name != nil
        {
            let nib = UINib(nibName: cell_Identity , bundle: nil)
            tableV_Name.register(nib, forCellReuseIdentifier: cell_Identity)
            
            tableV_Name.dataSource = vc as? UITableViewDataSource //vc.self as? UITableViewDataSource
            tableV_Name.delegate = vc as? UITableViewDelegate
        }
        
    }
    // Register nib class fot Collection only and with delegate
    func register_Collection_Mathod( vc: UIViewController ,  collectionV_Name : UICollectionView! , Coll_cell_Iden : String! )
    {
        if collectionV_Name != nil
        {
            /*gallery_CollectionView.register(UINib(nibName: "Image_Gallery_CollVCell", bundle: nil), forCellWithReuseIdentifier: "Image_Gallery_CollVCell")
             
             gallery_CollectionView.delegate = self
             gallery_CollectionView.dataSource = self*/
            let nib = UINib(nibName: Coll_cell_Iden , bundle: nil)
            collectionV_Name.register(nib, forCellWithReuseIdentifier: Coll_cell_Iden)
            
            collectionV_Name.dataSource = vc as? UICollectionViewDataSource
            collectionV_Name.delegate = vc as? UICollectionViewDelegate
        }
        
    }
}


