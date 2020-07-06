//
//  info_TableViewCell.swift
//  FabArtist
//
//  Created by AmitSharma on 13/06/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit


class info_TableViewCell: UITableViewCell {

   
    @IBOutlet weak var menu_CollectionView : UICollectionView!
    
    
    var artist_TableV : UITableView!
    
   // var tap_collectionV : UICollectionView!
    
    @IBOutlet weak var menu_CollectionView_Height : NSLayoutConstraint!
    
    //var viewHi = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let nib = UINib(nibName: "Info_CollectionViewCell" , bundle: nil)
        menu_CollectionView.register(nib, forCellWithReuseIdentifier: "Info_CollectionViewCell")
        
        let nib2 = UINib(nibName: "ServiceGallryCollectionViewCell" , bundle: nil)
        menu_CollectionView.register(nib2, forCellWithReuseIdentifier: "ServiceGallryCollectionViewCell")
        let nib3 = UINib(nibName: "WorkPreviewCollectionViewCell" , bundle: nil)
        menu_CollectionView.register(nib3, forCellWithReuseIdentifier: "WorkPreviewCollectionViewCell")
        menu_CollectionView.dataSource = self
        menu_CollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
extension info_TableViewCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(indexPath.row)
        if indexPath.row == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Info_CollectionViewCell", for: indexPath) as!  Info_CollectionViewCell
            
            
            cell.delegate = app_delegate.tap_collectionVC
            cell.delegate1 = app_delegate.tap_collectionVC
            
            if let avrageRat  = app_delegate.tap_collectionVC?.artistDis.data.ava_rating
            {
                if let prsentage = app_delegate.tap_collectionVC?.artistDis.data.completePercentages
                {
                    cell.persentaegComLabel.text = String( prsentage) + "% Completion "
                    cell.ratingLabel.text = "( \( avrageRat)/5 ) "
                    
                    let desimal_Str = String(format:"%.1f", Double(avrageRat))
                 
                    cell.ratingView.type = .halfRatings
                    cell.ratingView.rating = Double(desimal_Str)!
                }
                if let  currency_type = app_delegate.tap_collectionVC?.artistDis.data.currency_type
                {
                    if let  price = app_delegate.tap_collectionVC?.artistDis.data.price
                    {
                        cell.rateLabel.text =  " Rate \( currency_type) \(price )/hr  "
                    }
                }
                if let val = app_delegate.tap_collectionVC?.artistDis.data.completion_rate
                {
                    cell.job_comeletedLabel.text = val + " Jobs Completed "
                }
            }
            if let payMent = app_delegate.tap_collectionVC?.artistDis.data.artist_commission_type
            {
               // cell.load_Switch( switch_Obj : cell.online_Off_Sell )
                if payMent == "0"
                {
                   // cell.online_Off_Sell.isSelected  = true
                    // cell.online_Off_Sell.titles = ["" , "Hourly Rate"]
                }
                else
                {
                 //   cell.online_Off_Sell.isSelected  = false
                    //cell.online_Off_Sell.titles = ["Fixed Rate" , ""]
                }
            }
            if let about_us = app_delegate.tap_collectionVC?.artistDis.data.about_us
            {
                cell.aboutLabel.text = about_us
            }
            if let name = app_delegate.tap_collectionVC?.artistDis.data.name
            {

                cell.nameTF  .text = name
 
            }
            if let location = app_delegate.tap_collectionVC?.artistDis.data.location
            {
            cell.addressLabel.text = location
            }
           
            
            
          
           // cell.Info_TableView.reloadData()
            cell.qualificationTableV.reloadData()
            
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceGallryCollectionViewCell", for: indexPath) as!  ServiceGallryCollectionViewCell
            
            cell.serviceGallry_CollectionView.reloadData()
            cell.deleteServiceGalleryDelegate = app_delegate.tap_collectionVC
            
            return cell
        }
        else  if indexPath.row == 2
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkPreviewCollectionViewCell", for: indexPath) as!  WorkPreviewCollectionViewCell
            
            cell.workPreView_CollectionV.reloadData()
            
            
            return cell
            
        }
        else if indexPath.row == 3
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkPreviewCollectionViewCell", for: indexPath) as!  WorkPreviewCollectionViewCell
            
            cell.workPreView_CollectionV.reloadData()
            
            
            return cell
            
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkPreviewCollectionViewCell", for: indexPath) as!  WorkPreviewCollectionViewCell
            
            //cell.workPreView_CollectionV.reloadData()
            
            
            return cell
        }
        
      
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        
        if  app_delegate.tap_collectionVC != nil
        {
            app_delegate.tap_collectionVC?.selectedInd = indexPath.row
            app_delegate.tap_collectionVC?.tabCollectionView.reloadData()
        }
        
        if indexPath.row == 1 ||  indexPath.row == 2
        {
            if let cell = cell as?  ServiceGallryCollectionViewCell
            {
                cell.serviceGallry_CollectionView.reloadData()
            }
            
        }
        else
        {
            if let cell = cell as? WorkPreviewCollectionViewCell
            {
                cell.workPreView_CollectionV.reloadData()
                
            }
            
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let ind = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
        if  app_delegate.tap_collectionVC != nil
        {
            app_delegate.tap_collectionVC?.selectedInd = ind
            app_delegate.tap_collectionVC?.tabCollectionView.reloadData()
        }
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let ind = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
        if  app_delegate.tap_collectionVC != nil
        {
            app_delegate.tap_collectionVC?.selectedInd = ind
            app_delegate.tap_collectionVC?.tabCollectionView.reloadData()
        }
    }
    
    // MARK: - UIScrollViewDelegate
    //  extension Splase_Slider_ViewCont {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //gallery_CollectionView.animateVisibleCells()
    }
    //}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       /* if indexPath.row == 0
        {*/
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)// Set your item size here
/*
        }
        else
        {
           // menu_CollectionView_Height.constant = viewHi.bounds.height
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            return CGSize(width: collectionView.bounds.width, height: viewHi.bounds.height)// Set your item size here

            
        }*/
        
    }
    
}




