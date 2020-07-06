////
////  DiscountVC.swift
////  FabCustomer
////
////  Created by Samyotech on 02/03/18.
////  Copyright © 2018 Samyotech. All rights reserved.
////
//

//
//  DiscountVC.swift
//  FabCustomer
//
//  Created by Samyotech on 02/03/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit


class DiscountVC: UIViewController,UITableViewDelegate,UITableViewDataSource,InvitefriendDelegates  {
    
    @IBOutlet weak var tbldiscount: UITableView!
    let globel_variable = GlobalVariables.sharedManager
    //var discount_Dict : NSDictionary = NSDictionary()

    var discount_Dict : My_referral_code_Sturct?
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.get_GetRefrelCode_user()
        tbldiscount.dataSource = self
        tbldiscount.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        self.navigationbarSetUp()
    }
    @IBAction func get_GetRefrelCode_user()
    {
       
        let parameters : [String : String] = ["user_id" :globel_variable.user_id]
        print(parameters)
        
      
        loader.showLoader()
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getMyReferralCode, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr :  nil, with: My_referral_code_Sturct.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            self.discount_Dict = modelVal!
            
            self.tbldiscount.reloadData()
            
            loader.hideLoader()
        }
        else
        {
            loader.hideLoader()
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            
            }
        })
        
    }
    
    func navigationbarSetUp() {
        //set naviggation backgroun image
        let image = UIImage(named: "Header_bar")
        self.navigationController?.navigationBar.setBackgroundImage(image,for: .default)
        navigationItem.title = "Get Offer"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }

    
    //Invite Friends discound code:-
    func Signupnewuser(cell: DiscountVCButtonCell) {
        print("Invite friend")

        let shareString = "Hello, this is my Referral Code!"+"\((discount_Dict?.my_referral_code?.code)!)"
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [shareString], applicationActivities: nil);
        let currentViewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        currentViewController.present(activityViewController, animated: true, completion: nil);
 
    }
  
    

    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        } else
        {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell:DiscountVCCell = tableView.dequeueReusableCell(withIdentifier: "DiscountVCCell", for: indexPath) as! DiscountVCCell
            
            cell.lbldiscription.text = discount_Dict?.my_referral_code?.description
            cell.lblcode.text = discount_Dict?.my_referral_code?.code
            
            return cell
        }
        else {
            
            let cell:DiscountVCButtonCell = tableView.dequeueReusableCell(withIdentifier: "DiscountVCButtonCell", for: indexPath) as! DiscountVCButtonCell
            
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            tbldiscount.estimatedRowHeight = 168
            tbldiscount.rowHeight = UITableView.automaticDimension
            return  tbldiscount.rowHeight
            
            //  return 168
        }
        else{
            return 60
        }
    }
   /* //MARK:- Web Service Response Delegate
    @objc func callBackSuccessResponse(dictResponse: NSDictionary) {
        print(dictResponse)
        
        if  dictResponse["status"] as! NSNumber == 1
        {
            if dictResponse["my_referral_code"] != nil
            {
                
                discount_Dict = dictResponse["my_referral_code"] as! NSDictionary
                tbldiscount.reloadData()
            }
        }
        else
        {
        }
        
        //SHOW DPK Loader
        loader.hideLoader()
        
    }
    
    @objc func callBackFailResponse(dictResponse: NSDictionary) {
        print(dictResponse)
        //SHOW DPK Loader
        loader.hideLoader()
        
        //Alert Message for API Fail
        Alert.show(vc: self, titleStr: "Message", messageStr: (dictResponse["message"] as! NSString) as String)
    }*/
}




