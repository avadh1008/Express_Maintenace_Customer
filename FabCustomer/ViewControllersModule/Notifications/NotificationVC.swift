////
////  NotificationVC.swift
////  FabArtist
////
////  Created by Samyotech on 03/03/18.
////  Copyright © 2018 Samyotech. All rights reserved.

import UIKit
//import SJSwiftSideMenuController

class NotificationVC: UIViewController  {
    
    class func viewController() -> NotificationVC {
        return "Main".viewController("NotificationVC") as! NotificationVC
    }
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    @IBOutlet weak var tblnotification : UITableView!
   
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(NotificationVC.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    var notifications_Dic = my_notifications_Struct()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.get_Notfication_Data()
        self.tblnotification.addSubview(self.refreshControl)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        self.get_Notfication_Data()
        refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationbarSetUp()
    }
    
    func get_Notfication_Data()
    {
        
      /*  DPKWebOperation.operation_delegate = self
        //SHOW DPK Loader
        loader.showLoader()
        //Call WebService
        DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_getNotifications)
        
        */
        
       /* Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getNotifications, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            loader.hideLoader()
           
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })*/
       
        
        guard let usid = SignUpDataClass.shareMngr.signUpData?.SignUdata?.user_id  else {
            return
        }
        
        let parameters : [String : String] = ["user_id": usid]
        
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getNotifications, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: my_notifications_Struct.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            self.notifications_Dic = modelVal!
            self.tblnotification.reloadData()
            self.refreshControl.endRefreshing()
            loader.hideLoader()
            
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            self.tblnotification.reloadData()
            self.refreshControl.endRefreshing()
            loader.hideLoader()
            }
        })
        
        
    }
    
    func navigationbarSetUp() {
        //set naviggation backgroun image
           self.navigationController?.setNavigationBarHidden(false, animated: false)
        let image = UIImage(named: "Header_bar")
        self.navigationController?.navigationBar.setBackgroundImage(image,for: .default)
        
        
        navigationItem.title = defaultLocalizer.stringForKey(key: "Notifications")
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
    }
    
    
}



extension NotificationVC : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notifications_Dic.my_notifications_Arr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:NotificationCell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        if self.notifications_Dic.my_notifications_Arr.count > indexPath.row
        {
            let val_Dic  =  self.notifications_Dic.my_notifications_Arr[indexPath.row]
            
            cell.lbldiscriptions.text = val_Dic.msg
            cell.lbldiscount.text = val_Dic.title
            
            if let dateStr = val_Dic.created_at
            {
                
                cell.lblday.text = timeStamp_Str_Mathod(timeSt: dateStr)
                /*let interval: TimeInterval? = Double( dateStr )
                let date_get = Date(timeIntervalSince1970: interval!)
                let format_time = DateFormatter()
                format_time.dateFormat = "yyyy-MM-dd"
                let date_Str_Com = format_time.string(from:date_get )
                print(date_Str_Com)
                let formatter_Time = DateFormatter()
                formatter_Time.dateFormat = "h:mm a"
                let date_Str_Time = formatter_Time.string(from:date_get)
                print(date_Str_Time)
                cell.lbltime.text = "\(date_Str_Com)"+" "+"\(date_Str_Time)"
                if  NSCalendar.current.isDateInToday(date_get )
                {
                    cell.lblday.text = "Today"+" "+"\(date_Str_Time)"
                }
                if  NSCalendar.current.isDateInYesterday(date_get)
                {
                    cell.lblday.text = "Yesterday"+" "+"\(date_Str_Time)"
                }
                */
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tblnotification.estimatedRowHeight = 150
        tblnotification.rowHeight = UITableView.automaticDimension
        return  tblnotification.rowHeight
    }
}
