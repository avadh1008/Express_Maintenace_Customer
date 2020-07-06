//
//  WorkPreviewCollectionViewCell.swift
//  FabArtist
//
//  Created by AmitSharma on 14/06/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit

class WorkPreviewCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet weak var workPreView_TableView : UITableView!
    
    
    @IBOutlet weak var workPreView_CollectionV : UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        app_delegate.workreviCollection = workPreView_CollectionV
        
       /* let nib = UINib(nibName: "WorkPreviewTableViewCell_Cell" , bundle: nil)
        workPreView_TableView.register(nib, forCellReuseIdentifier: "WorkPreviewTableViewCell_Cell")
        workPreView_TableView.delegate = self
        workPreView_TableView.dataSource = self*/
        
        let nib3 = UINib(nibName: "WorkPrivewCollectionViewCell_Cell" , bundle: nil)
        workPreView_CollectionV.register(nib3, forCellWithReuseIdentifier: "WorkPrivewCollectionViewCell_Cell")
        
        workPreView_CollectionV.dataSource = self
        workPreView_CollectionV.delegate = self
    }

}
extension WorkPreviewCollectionViewCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    
    /*func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
     
     if let cell = cell as? Info_CollectionViewCell
     {
     self.menu_CollectionView_height.constant = collectionView.contentSize.height //cell.infoTableView.frame.height //...contentSize.height
     }
     }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         if  app_delegate.tap_collectionVC?.selectedInd == 3
        {
            return app_delegate.tap_collectionVC?.artistDis.data.reviews?.count ?? 0
        }
        else // app_delegate.tap_collectionVC?.selectedInd == 2
        {
            return app_delegate.tap_collectionVC?.artistDis.data.artist_booking?.count ?? 0
        }
        
        
     //   return 1
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell : WorkPrivewCollectionViewCell_Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkPrivewCollectionViewCell_Cell", for: indexPath) as! WorkPrivewCollectionViewCell_Cell
        

         if  app_delegate.tap_collectionVC?.selectedInd == 3
        {
            if app_delegate.tap_collectionVC?.artistDis.data.reviews?.count ?? 0 > indexPath.row
            {
                if let dic = app_delegate.tap_collectionVC?.artistDis.data.reviews?[indexPath.row]
                {
                    
                    
                    cell.review_User_Image.sd_setImage(with: URL(string: dic.image ?? ""), placeholderImage: UIImage(named: "profile-dummy"))
                    
                    let desimal_Str = String(format:"%.1f", Double(dic.rating ?? "")!)
                    
                    cell.name_Label.text = dic.name
                     cell.Review_cat_Label.text = "Review By"
                    cell.review_Rating_View.rating = Double(desimal_Str)!
                    cell.rating_Label.text = "(" + "\(desimal_Str)" + "/5)"
                    cell.review_Dec_Label.text = dic.comment
                    if let date = dic.created_at
                    {
                        let updated_Str = (date as NSString)
                        
                        let interval: TimeInterval? = updated_Str.doubleValue
                        let date_get = Date(timeIntervalSince1970: interval!)
                        
                        cell.day_Ago_Label.text =  " "+"\(date_get.getElapsedInterval()) ago"
                    }
                    
                }
            }
            
            
        }
        else //if app_delegate.tap_collectionVC?.selectedInd == 2
        {
            if app_delegate.tap_collectionVC?.artistDis.data.artist_booking?.count ?? 0 > indexPath.row
            {
                if let dic = app_delegate.tap_collectionVC?.artistDis.data.artist_booking?[indexPath.row]
                {
                    
                    cell.review_User_Image.sd_setImage(with: URL(string: dic.userImage ?? ""), placeholderImage: UIImage(named: "profile-dummy"))
                    let desimal_Str = String(format:"%.1f", Double(dic.rating ?? "")! )
                    cell.name_Label.text = dic.username
                    cell.Review_cat_Label.text = "Job Done For"
                    cell.review_Rating_View.rating = Double(desimal_Str)!
                    cell.rating_Label.text = "(" + "\(desimal_Str)" + "/5)"
                    cell.review_Dec_Label.text = ""
                    if let curnsy = dic.currency_type
                    {
                        if  let price =  dic.price
                        {
                            cell.day_Ago_Label.text =  " \(curnsy) "+"\(price)"
                        }
                    }
                    
                }
            }
            
        }
       return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        
        let approximateWidthOfContent = collectionView.bounds.width
        let size = CGSize(width: approximateWidthOfContent, height: 100)
        if  app_delegate.tap_collectionVC?.selectedInd == 3
        {
            if let dic = app_delegate.tap_collectionVC?.artistDis.data.reviews?[indexPath.row]
            {
                
                let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
                let estimatedFrame = NSString(string: dic.comment ?? "").boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                return CGSize(width: collectionView.bounds.width, height: estimatedFrame.height + 60)
                
            }
        }
       
        else// if app_delegate.tap_collectionVC?.selectedInd == 2
        {
            if let dic = app_delegate.tap_collectionVC?.artistDis.data.artist_booking?[indexPath.row]
            {
                
                // x is the width of the logo in the left
                
                
                //1000 is the large arbitrary values which should be taken in case of very high amount of content
                
                let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
                let estimatedFrame = NSString(string: dic.username ?? "").boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                return CGSize(width: collectionView.bounds.width, height: estimatedFrame.height + 55)
                
            }
        }
        
        
        
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return CGSize(width: collectionView.bounds.width, height: 100)// Set your item size here
    
    }
    
    
    
}

extension WorkPreviewCollectionViewCell    : UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = scrollView.contentOffset.y
        
        print(y)
        if y <= -1
        {
            app_delegate.workreviCollection?.isScrollEnabled = false
            
            //app_delegate.tap_collectionVC?.artistTableView.scrollToTop(animated: true)
        }
        
        if y >= 150
        {
            app_delegate.tap_collectionVC?.artistTableView.scrollToLastCall(animated: true)
        }
    }
}

/*extension WorkPreviewCollectionViewCell : UITableViewDataSource , UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 500
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkPreviewTableViewCell_Cell", for: indexPath) as! WorkPreviewTableViewCell_Cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight  = UITableView.automaticDimension
        return tableView.rowHeight
    }
}*/

