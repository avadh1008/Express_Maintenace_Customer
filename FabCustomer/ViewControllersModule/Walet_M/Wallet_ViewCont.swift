//
//  Wallet_ViewCont.swift
//  FabArtist
//
//  Created by apple on 02/11/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit
import Parchment
class Wallet_ViewCont: UIViewController {
    
    class func viewController() -> Wallet_ViewCont {
        return "Main".viewController("Wallet_ViewCont") as! Wallet_ViewCont
    }

    let left_B = UIButton()
    let right_B = UIButton()
    
    var add_Pager_Bol : Bool = false
    
    var pagingViewController = FixedPagingViewController(viewControllers:[])
    
    fileprivate let cities = [
        "All",
        "Debit",
        "Credit"]
    
    let  globel_Var = GlobalVariables.sharedManager
    
    @IBOutlet weak var menu_View : UIView!
    
    var my_Wallet_dic : Get_My_Wallet_Struct?
    
    @IBOutlet weak var wallet_balnce : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.Slider_Mathod()
       /* if globel_Var.guest_Type_Arr.count  > 0
        {
            self.Slider_Mathod()
        }
        else
        {
           // get_Mathod_Type(api_key: Constant.W_getGuestType)
            
        }*/

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        create_Navigation_Bar_Mathod()
        
        /*get_My_Wallet(api_key: Constant.kTo_getWallet, completion: { (success) in
            if success
            {
                
                self.wallet_balnce.text = self.globel_Var.my_Wallet_dic.currency_type + " " + self.globel_Var.my_Wallet_dic.amount
                
            }
            else
            {
                
                
            }
        })*/
        
        if SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id != nil
        {
            let parameters : [String : String] = ["user_id":(SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!]
            Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getWallet, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_My_Wallet_Struct.self  , completion : {(success, modelVal) -> Void in if success
            {
                
                self.my_Wallet_dic = modelVal!
                if let Cty = self.my_Wallet_dic?.my_Wallet_Data?.currency_type , let amont = self.my_Wallet_dic?.my_Wallet_Data?.amount
                {
                    self.wallet_balnce.text = Cty + " " + amont
                }
                loader.hideLoader()
                
            }
            else
            {
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                loader.hideLoader()
                
                }
            })
            
        }
        
        
        //get_Mathod_Type(api_key: Constant.W_getGuestType)
    }
    
    func create_Navigation_Bar_Mathod()
    {
        left_B.addTarget(self, action: #selector(self.left_Mathod_Action(_:)), for: .touchUpInside)
         Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "menu"), left_title_Str: nil, right_B_Img:nil, right_title_Str: nil, title_Str: "Wallet", hidden_Nav: false, left_Button: left_B , right_Button: nil)
        
    }
    //To_Create_Slider_Mathod
    func Slider_Mathod()
    {
        let firstViewController = Wallet_Money_ListVCont.viewController()
        
        pagingViewController = FixedPagingViewController(viewControllers: [
            firstViewController,
            firstViewController, firstViewController
            ])
        //self.menu_View
        //if globel_Var.guest_Type_Arr.count  > 0
        //{
            Set_Slider_Bar.sharedInstance.create_Slider_Mathod(vc: self, view_To_Show: self.menu_View, pagingViewController: pagingViewController)
            pagingViewController.dataSource = self
            add_Pager_Bol = true
        //}
        
    }
    //getGuestType //

    // MARK:- Image Option
    @IBAction func right_Mathod_Action(_ sender: UIButton!) {
        
      
    }
    
    // MARK:- add money
    @IBAction func add_Mony_Mathod_Action(_ sender: UIButton!) {
        
       let add_VC = Add_Money_VCont.viewController()
        self.navigationController?.pushViewController(add_VC, animated: true)
        
        
    }
    
    
    
    @IBAction func left_Mathod_Action( _ sender : UIButton!)
    {
        if let image : UIImage = UIImage(named: "menu")
        {
        SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
            
        }
        
        /*self.navigationController?.popViewController(animated: true)*/
        
    }

    

}

extension Wallet_ViewCont: PagingViewControllerDataSource {
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        let dic = cities[index]
        return PagingIndexItem(index: index, title: dic) as! T
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
        let dic = cities[index]
        return Wallet_Money_ListVCont(title: dic)
    }
    
    func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int {
        return cities.count
    }
    
}
