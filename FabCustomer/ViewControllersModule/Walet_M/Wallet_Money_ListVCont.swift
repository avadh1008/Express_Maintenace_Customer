//
//  Wallet_Money_ListVCont.swift
//  FabArtist
//
//  Created by apple on 02/11/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit
import CoreLocation
import Parchment

class Wallet_Money_ListVCont: UIViewController {
    
    class func viewController() -> Wallet_Money_ListVCont {
        return "Main".viewController("Wallet_Money_ListVCont") as! Wallet_Money_ListVCont
    }

    var alert_Str :String!
        var guest_type = ""
        
        var emty_View : UIView  =   UIView()
        var emty_Img_View : UIImageView  =   UIImageView()
        var emty_Img_label : UILabel  =   UILabel()
        var guest_List_TableV : UITableView  =   UITableView()
        let  globel_Var = GlobalVariables.sharedManager
        
    var mony_Arr : Get_Mony_his_Struct?
    
        lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                #selector(self.handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            refreshControl.tintColor = UIColor.white
            return refreshControl
        }()
        
        init(title: String) {
            super.init(nibName: nil, bundle: nil)
            self.title = title
            
            let label = UILabel(frame: .zero)
            label.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.thin)
            label.textColor = UIColor(red: 95/255, green: 102/255, blue: 108/255, alpha: 1)
            label.text = title
            label.sizeToFit()
            
            //view.addSubview(label)
            //view.constrainCentered(label)
            //view.backgroundColor = .white
        }
        
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
        }
        
        
        
        
        let left_B = UIButton()
        let right_B = UIButton()
        var title_Str : String!
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            guest_List_TableV.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height-100)
            
            Register_Nib_With_Delegate.sharedInstance.register_Mathod(vc: self , tableV_Name: guest_List_TableV, cell_Identity:"Money_Wlet_TableVCell")
            
            emty_View_add_Mathod()
            
            self.view.backgroundColor =  UIColor.clear
            self.view.addSubview(guest_List_TableV)
            
            guest_List_TableV.separatorStyle =  .none
            guest_List_TableV.backgroundColor =  UIColor.clear
            
            self.guest_List_TableV.addSubview(self.refreshControl)
            
        }
        
        func emty_View_add_Mathod()
        {
            emty_View.frame = CGRect(x: 20 , y:(self.view.frame.height/2)-200, width: self.view.frame.width - 40, height:200.0)
            //emty_View.center =  self.view.center
            
            
            emty_Img_View.image = UIImage(named: "Not_C_D_Img")
           
            
            emty_Img_label.textColor = UIColor.blue
            
            
            
            
            emty_Img_View.image = UIImage(named: "menu")
            emty_Img_View.frame = CGRect(x: (emty_View.frame.width/2)-30, y: 20.0, width: 60, height:60)
            
            emty_Img_label.frame = CGRect(x: 10, y: emty_Img_View.frame.height+20, width: emty_View.frame.width-20, height:60)
            
            emty_Img_label.text = alert_Str
            emty_Img_label.textAlignment = .center
            emty_Img_label.numberOfLines = 0
            emty_Img_label.textColor = UIColor.white
            
            emty_View.backgroundColor =  UIColor.clear
            self.view.addSubview(emty_View)
            self.emty_View.addSubview(emty_Img_View)
            self.emty_View.addSubview(emty_Img_label)
        }
        
        override func viewWillAppear(_ animated: Bool)
        {
            
            super.viewWillAppear(animated)
            self.create_Navigation_Bar_Mathod()
            self.view.backgroundColor = UIColor.clear//Constant.App_BG_Color
            //self.view.backgroundColor =  Constant.App_BG_Color
            
            
            if title! == "All"
            {
                
                alert_Str = "No Transaction"
                guest_type = "2"
               // globel_Var.guset_type_ind = 0
                self.get_Mathod(api_key: Constant.kTo_getWalletHistory, type: guest_type)
            }
            else if title! == "Debit"
            {
                alert_Str = "No Debit Transaction"
                guest_type = "1"
               // globel_Var.guset_type_ind = 1
                self.get_Mathod(api_key: Constant.kTo_getWalletHistory, type: guest_type)
            }
            else if title! == "Credit"
            {
               
                alert_Str = "No Credit Transaction"
                guest_type = "0"
               // globel_Var.guset_type_ind = 2
                self.get_Mathod(api_key: Constant.kTo_getWalletHistory, type: guest_type)
            }
            emty_Img_label.text = alert_Str
        }
    
        func create_Navigation_Bar_Mathod()
        {
            left_B.addTarget(self, action: #selector(self.left_Mathod_Action(_:)), for: .touchUpInside)
            right_B.addTarget(self, action: #selector(self.right_Mathod_Action(_:)), for: .touchUpInside)
            Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:nil, left_title_Str: nil, right_B_Img:nil, right_title_Str: nil, title_Str: "Wallet", hidden_Nav: false, left_Button: left_B , right_Button: right_B)
            
        }
        
        
        @IBAction func right_Mathod_Action(_ sender : UIButton!)
        {
            
            let transition:CATransition = CATransition()
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromRight
            Set_Navigation_Bar_Class.sharedInstance.next_VC_Animation_Move(vc: self, next_VC_Str: "Add_Guest_ViewCont", transition_T:transition )
            // Add_Guest_ViewCont
        }
        
        @IBAction func left_Mathod_Action( _ sender : UIButton!)
        {
            if let image : UIImage = UIImage(named: "menu")
            {
                SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
                
            }
        }
        
        //MARK:- Reloade :-
        @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
           get_Mathod(api_key: Constant.kTo_getWalletHistory, type: guest_type)
        }
        // MARK:-
        func get_Mathod( api_key : String! , type : String!  ) // , type : String!
        {
            
           
            
            var  parameters : [String : String] = ["user_id":globel_Var.user_id]
            
            if guest_type != "2"
            {
                parameters["status"] = guest_type
            }
            
            print(parameters)
            
            loader.showLoader()
            Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: api_key, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr :  nil, with: Get_Mony_his_Struct.self  , completion : {(success, modelVal) -> Void in if success
            {
                
                 
                self.refreshControl.endRefreshing()
                 self.mony_Arr = modelVal!
                self.emty_View.isHidden = true
                
                loader.hideLoader()
                loader.hideLoader()
                self.guest_List_TableV.reloadData()
            }
            else
            {
                loader.hideLoader()
                self.mony_Arr?.mony_his_Arr!.removeAll()
                self.guest_List_TableV.reloadData()
                self.refreshControl.endRefreshing()
                
                self.emty_View.isHidden = false
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                self.guest_List_TableV.reloadData()
                
                }
            })
            
        }
        
        
    }
    extension Wallet_Money_ListVCont : UITableViewDataSource , UITableViewDelegate
    {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            
            return self.mony_Arr?.mony_his_Arr?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell : Money_Wlet_TableVCell = tableView.dequeueReusableCell(withIdentifier: "Money_Wlet_TableVCell", for: indexPath) as! Money_Wlet_TableVCell
            
            if let dic  = self.mony_Arr?.mony_his_Arr?[indexPath.row]
            {
                
                
                self.emty_View.isHidden = true
                
                cell.Amont_Label
                    .text = dic.amount
                cell.by_Label.text = dic.description
                cell.date_Label.text  = timeStamp_Str_Mathod(timeSt: dic.created_at )
                
                if dic.status == "0" //credit
                {
                    if let img = UIImage(named: "rupee_redit")
                    {
                        cell.left_ImgV.image = img
                        
                    }
                    cell.Amont_Label.textColor = UIColor.darkGray
                    cell.Amont_Label.text = "+"+dic.amount
                    
                }
                else if dic.status == "1" // debit
                {
                    cell.left_ImgV.image =  UIImage(named: "rupee_debit")
                    cell.Amont_Label.textColor = UIColor.green
                    cell.Amont_Label.text = "-"+dic.amount
                }
                
            }
           
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            guest_List_TableV.estimatedRowHeight = 150
            guest_List_TableV.rowHeight = UITableView.automaticDimension
            return guest_List_TableV.rowHeight
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            
            
            
        }
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            let myView_Fo = UIView()
            myView_Fo.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100 )
            myView_Fo.backgroundColor = UIColor.clear
            
            return myView_Fo
        }
        
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            
            return 200
        }
        
        
        @IBAction func delete_Mathod_Action(_ sender : UIButton!)
        {
           /* //W_removeEvent
            
            let dic = globel_Var.guest_Arr[sender.tag]
            print(dic)
            
            let alert = UIAlertController(title: Alert.W_msg, message: Alert.k_delete_guest, preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
                self.delete_Mathod(api_key: Constant.W_removeGuest, media_V_str: nil, vid_url: nil, media_Img_str: nil, ima_Ob: nil, guest_id: dic.id)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            
            // Add the actions
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: nil)
            
            */
        }
        
        //W_removeGuest
        func delete_Mathod(  api_key : String! , media_V_str : String? , vid_url : URL? , media_Img_str : String? , ima_Ob : UIImage? , guest_id : String! )
        {
           
        }
        
        
        @IBAction func edit_Mathod_Action( _ sender : UIButton!)
        {
            
            /*let Add_Guest_VC : Add_Guest_ViewCont  = StoryBoard.instantiateViewController(withIdentifier: "Add_Guest_ViewCont") as! Add_Guest_ViewCont
            Add_Guest_VC.add_OR_edit_Bol =  true
            Add_Guest_VC.index_Val =  sender.tag
            
            self.present(Add_Guest_VC, animated: true)*/
            
            
        }
        
        
}
