//
//  ServicesBookViewController.swift
//  FabCustomer
//
//  Created by AmitSharma on 10/07/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit

class ServicesBookViewController: UIViewController {
    class func viewController() -> ServicesBookViewController {
        return "Main".viewController("ServicesBookViewController") as! ServicesBookViewController
    }
   
    @IBOutlet weak var serViceCollectionV     :   UICollectionView!
    var select_products : Products?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serViceCollectionV.delegate  = self
        serViceCollectionV.dataSource  = self
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationbarSetUp()
    }
    
    //MARK:- Custom Method
    func navigationbarSetUp() {
        if let image : UIImage = UIImage(named: "menu") {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
        }
        let image = UIImage(named: "Header_bar")
        self.navigationController?.navigationBar.setBackgroundImage(image,for: .default)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.setHidesBackButton(false, animated:false)
        self.title = "Services"
        //Bar Left Button
        let btnmenu = UIButton(type: .custom)
        btnmenu.setImage(UIImage(named: "back2"), for: .normal)
        btnmenu.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        btnmenu.addTarget(self, action: #selector(self.back_Action), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btnmenu)
        self.navigationItem.setLeftBarButtonItems([item1], animated: true)
    }
    
    @objc func back_Action()
    {
        if let image : UIImage = UIImage(named: "menu") {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmBook_Mathod(_ sender: UIButton!) {
        if self.select_products == nil
        {
            Alert.showMiddleToast(message: "Please select services", view_VC: self)
        }
        else
        {
            let nextVC : BookingInfoViewController = BookingInfoViewController.viewController()
            nextVC.indexdCheck = 1
            nextVC.select_products  =  select_products
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        
    }
    
    /*func bookArtist(){
        
        if self.select_products?.id == ""
        {
            
        }
        else
        {
            
            let parameters : [String : String] = ["user_id":  GlobalVariables.sharedManager.user_id ,"artist_id":(app_delegate.tap_collectionVC?.artistDis.data.user_id!)!  ,"date_string": self.select_products!.created_at! ,"timezone": "timeZOne".timeZone ,"price": (self.select_products!.price!) ]
            
            print(parameters)

            loader.showLoader()
            
            Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_book_artist, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
            {
                
                GlobalVariables.sharedManager.get_Stutas = modelVal!
                print(modelVal!)
                loader.hideLoader()
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Stutas.message, view_VC: self)
                self.navigationController?.popViewController(animated: true)
            }
            else
            {
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Stutas.message, view_VC: self)
                loader.hideLoader()
                
                }
            })
        }
       
        
    }
*/
    

}
// MARK: - Collection Mathod delegate
extension ServicesBookViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  app_delegate.tap_collectionVC?.artistDis.data.products?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : ServiceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCollectionViewCell" ,for: indexPath) as! ServiceCollectionViewCell
    
        if let dic = app_delegate.tap_collectionVC?.artistDis.data.products?[indexPath.row]
        {
            
            cell.amontLabel.text = dic.currency_type!  +  dic.price!
            cell.typeImgView.sd_setImage(with: URL(string: dic.product_image!), placeholderImage: UIImage(named: "imagePLaceHolder"))
            cell.typeLabel.text = dic.product_name
            cell.checkButton.tag = indexPath.row
            cell.checkButton.addTarget(self, action: #selector(self.selectMathodAction(_:)), for: .touchUpInside)
            
            if self.select_products?.id == dic.id
            {
                   cell.checkIMGView.image = UIImage(named: "checkFilled")
            }
            else
            {
                cell.checkIMGView.image = UIImage(named: "checkEmpty")
            }
            
        }
        
        
        return cell
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        let size = (collectionView.bounds.width/2)-3
        return CGSize(width: size , height: size)// Set your item size here
        
    }
    
    @IBAction func selectMathodAction(_ sender : UIButton!)
    {
        if let dic = app_delegate.tap_collectionVC?.artistDis.data.products?[sender.tag]
        {
            if self.select_products?.id == dic.id
            {
                self.select_products =  Products()
                serViceCollectionV.reloadData()
                
            }
            else
            {
                self.select_products =  dic
                serViceCollectionV.reloadData()
            }
            
        }
        
     
    }
  
    
    
    //MARK: - Uploade Images mathod
    func delete_Images_Mathod(  api_key : String! , media_id :  String! )
    {
        
      
    }
}
