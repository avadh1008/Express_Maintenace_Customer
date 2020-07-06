//
//  ServiceGallryCollectionViewCell.swift
//  FabArtist
//
//  Created by AmitSharma on 14/06/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit

protocol deleteServiceGalleryDelegate {
    func serviceMathod(cell : ServiceGallryCollectionViewCell )
    func galleryMathod(cell : ServiceGallryCollectionViewCell )
    
    
    func service_add_Mathod(cell : ServiceGallryCollectionViewCell )
    func gallery_add_Mathod(cell : ServiceGallryCollectionViewCell )
}

class ServiceGallryCollectionViewCell: UICollectionViewCell {

    
    var slectdInd : Int?
    @IBOutlet weak var serviceGallry_CollectionView : UICollectionView!
    
    var deleteServiceGalleryDelegate : deleteServiceGalleryDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        app_delegate.serviceCollection = serviceGallry_CollectionView
        
        
        let nib3 = UINib(nibName: "ServiceGalleryCollectionView_Cell_Cell" , bundle: nil)
        serviceGallry_CollectionView.register(nib3, forCellWithReuseIdentifier: "ServiceGalleryCollectionView_Cell_Cell")
        
        serviceGallry_CollectionView.dataSource = self
        serviceGallry_CollectionView.delegate = self
    }

    
    
}

extension ServiceGallryCollectionViewCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    
    /*func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
     
     if let cell = cell as? Info_CollectionViewCell
     {
     self.menu_CollectionView_height.constant = collectionView.contentSize.height //cell.infoTableView.frame.height //...contentSize.height
     }
     }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
       /* if app_delegate.tap_collectionVC?.selectedInd == 1
        {
            
            return 0 //app_delegate.tap_collectionVC?.artistDis.data.products?.count ?? 0 + 1
        }
        else if  app_delegate.tap_collectionVC?.selectedInd == 2
        {
          */
             return app_delegate.tap_collectionVC?.artistDis.data.gallery?.count ?? 0
        //}
        
       // return  0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : ServiceGalleryCollectionView_Cell_Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceGalleryCollectionView_Cell_Cell", for: indexPath) as! ServiceGalleryCollectionView_Cell_Cell
       
            cell.blueView.isHidden = true
        
        
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteMathodAction(_:)), for: .touchUpInside)
            
            
            
           /* if app_delegate.tap_collectionVC?.selectedInd == 1
            {
                if let dic = app_delegate.tap_collectionVC?.artistDis.data.products?[indexPath.row]
                {
                    cell.typeImgView.sd_setImage(with: URL(string: dic.product_image ?? ""), placeholderImage: UIImage(named: "image_gallery"))
                    cell.typeLabel.text = dic.product_name
                    if let currency = dic.currency_type
                    {
                        if let price = dic.price
                        {
                            cell.amontLabel.text = currency + price
                        }
                    }
                    cell.backView.isHidden =  false
                    
                }
            }
            else if  app_delegate.tap_collectionVC?.selectedInd == 2
            {*/
                if let dic = app_delegate.tap_collectionVC?.artistDis.data.gallery?[indexPath.row]
                {
                    cell.typeImgView.sd_setImage(with: URL(string: dic.image ?? ""), placeholderImage: UIImage(named: "image_gallery"))
                    cell.amontLabel.text = ""
                    cell.typeLabel.text = ""
                    cell.backView.isHidden =  true
                }
            //}

        
        
            
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return CGSize(width: collectionView.bounds.width/2, height: collectionView.bounds.width/2)// Set your item size here
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if indexPath.row  == 0 {
            /*if app_delegate.tap_collectionVC?.selectedInd == 1
            {
                deleteServiceGalleryDelegate?.service_add_Mathod(cell: self)
            }
            else if  app_delegate.tap_collectionVC?.selectedInd == 2
            {*/
                deleteServiceGalleryDelegate?.gallery_add_Mathod(cell: self)
            //}
        }
        
    }
    
    @IBAction func deleteMathodAction(_ sender : UIButton!)
    {
        slectdInd = sender.tag
        
       /* if app_delegate.tap_collectionVC?.selectedInd == 1
        {
           deleteServiceGalleryDelegate?.serviceMathod(cell: self)
        }
        else if  app_delegate.tap_collectionVC?.selectedInd == 2
        {*/
            //deleteServiceGalleryDelegate?.galleryMathod(cell: self)
        //}
    }
    
    @IBAction func addMathodAction(_ sender : UIButton!)
    {
        
    }
    
}

extension ServiceGallryCollectionViewCell    : UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = scrollView.contentOffset.y
        
        print(y)
        if y <= -1
        {
            app_delegate.serviceCollection?.isScrollEnabled = false
            //app_delegate.tap_collectionVC?.artistTableView.scrollToTop(animated: true)
        }
        
        if y >= 150
        {
            app_delegate.tap_collectionVC?.artistTableView.scrollToLastCall(animated: true)
        }
    }
}
