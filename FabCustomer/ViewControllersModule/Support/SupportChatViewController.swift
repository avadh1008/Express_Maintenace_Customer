//
//  SupportChatViewController.swift
//  FabCustomer
//
//  Created by Apple on 09/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit
//import SJSwiftSideMenuController

class SupportChatViewController: UIViewController , UITableViewDelegate , UITableViewDataSource  , UITextFieldDelegate {
    class func viewController() -> SupportChatViewController {
        return "Main".viewController("SupportChatViewController") as! SupportChatViewController
    }
    
   
    @IBOutlet weak var bottmView: UIView!
    
    var my_Ticket_Chat_Dic = My_Ticket_Chat_Struct()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Constant.loder_Color_D
        return refreshControl
    }()
   
    let globel_variable = GlobalVariables.sharedManager
    @IBOutlet weak var bottom_Constraint: NSLayoutConstraint!
    @IBOutlet weak var send_TF: UITextField!
    @IBOutlet weak var lblNotFound: UILabel!
    
    @IBOutlet weak var chatSupport_TableView: UITableView!
    //var chat_Array : NSArray = NSArray()
    var strApiFlag:String = ""
    var ticket_id = ""
    var user_id = ""
    var sender_name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image : UIImage = UIImage(named: "menu") as UIImage? {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
            //  SJSwiftSideMenuController .showRightMenuNavigationBarButton(image: image)
        }
        self.navigationbarSetUp()
        self.chatSupport_TableView.addSubview(self.refreshControl)
        
        self.send_TF.delegate = self
        self.navigationItem.title = sender_name.capitalized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        self.title = "Comment"
        
        chatSupport_TableView.dataSource = self
        chatSupport_TableView.delegate = self
        
        let left_nib = UINib(nibName: "Left_Support_TableVCell", bundle: nil)
        chatSupport_TableView.register(left_nib, forCellReuseIdentifier: "Left_Support_TableVCell")
        
        let right_nib = UINib(nibName: "Right_Support_TableVCell", bundle: nil)
        chatSupport_TableView.register(right_nib, forCellReuseIdentifier: "Right_Support_TableVCell")
        
        
        if ticket_id.isEmpty != true && user_id.isEmpty != true
        {
            self.get_Chat_Data(ticket_id: ticket_id, user_id: user_id)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(SupportChatViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SupportChatViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationbarSetUp()
        self.title = "Comments"
    }
    
    //MARK:- Reloade :-
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if ticket_id.isEmpty != true && user_id.isEmpty != true
        {
            self.get_Chat_Data(ticket_id: ticket_id, user_id: user_id)
        }
    }
    
    //Calls this function when the tap is recognized.
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    // KeyBoard will appear by this mathod.
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                bottom_Constraint.constant = keyboardSize.height/2 + 110
                
               
                
            } else {
                // no UIKeyboardFrameBeginUserInfoKey entry in userInfo
            }
        }
        
    }
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    // KeyBoard will Hidde by this mathod.
    @objc  func keyboardWillHide(_ notification:Notification) {
        
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            bottom_Constraint.constant = 0
            chatSupport_TableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            // self.chat_TableView.isScrollEnabled = true
            //bottom_Constraint.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    
    
    func get_Chat_Data( ticket_id:String , user_id:String  )
    {
        
        strApiFlag = ""
        var parameters : [String : String]  = [:]
        
        if ticket_id != ""
        {
            parameters["ticket_id"] = ticket_id
        }
        if user_id != ""
        {
            parameters["user_id"] = user_id
        }
        
        print(parameters)
        
       /* DPKWebOperation.operation_delegate = self
        //SHOW DPK Loader24.45454
        loader.showLoader()
        //Call WebService
        
        DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_getChatTicket)*/
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getChatTicket, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: My_Ticket_Chat_Struct.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            
            self.my_Ticket_Chat_Dic = modelVal!
            
            self.chatSupport_TableView.reloadData()
            self.refreshControl.endRefreshing()
            
            
            if self.my_Ticket_Chat_Dic.My_Ticket_Chat_Arr.count > 1
            {
                self.chatSupport_TableView.scrollToLastCall(animated: false)
            }
            
            loader.hideLoader()
            // self.artistTableView.reloadData()
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })
    }

    func send_Chat_Data( ticket_id:String , comment:String , user_id:String )
    {
        
        strApiFlag = "send"
        
        var parameters : [String : String]  = [:]
        
        if ticket_id != ""
        {
            parameters["ticket_id"] = ticket_id
        }
        if user_id != ""
        {
            parameters["user_id"] = user_id
        }
        if comment != ""
        {
            parameters["comment"] = comment
        }
       
        print(parameters)
        
        /*DPKWebOperation.operation_delegate = self
        //SHOW DPK Loader24.45454
        //loader.showLoader()
        //Call WebService
        
        DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_sendmsgTicket)*/
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_sendmsgTicket, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            
       
         
            
        
             self.get_Chat_Data(ticket_id: ticket_id, user_id: user_id)
            
            loader.hideLoader()
            
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            
            
            }
        })
        
        
    }
    
    //MARK:- Custom Method
    func navigationbarSetUp() {
        
        let image = UIImage(named: "Header_bar")
        self.navigationController?.navigationBar.setBackgroundImage(image,for: .default)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.setHidesBackButton(true, animated:false)
        
        //Bar Left Button
        let btnmenu = UIButton(type: .custom)
        btnmenu.setImage(#imageLiteral(resourceName: "back2"), for: .normal)
        btnmenu.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        btnmenu.addTarget(self, action: #selector(Chat_VCont.back_Action), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btnmenu)
        self.navigationItem.setLeftBarButtonItems([item1], animated: true)
        
        //Bar Right Button
        let button = UIButton(type: .custom)
        button.setImage(UIImage (named: "search"), for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 25.0, height: 25.0)
        //button.addTarget(target, action: nil, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        
        
        //self.navigationItem.rightBarButtonItems = [barButtonItem]
    }
    @objc func back_Action()
    {
        if let image : UIImage = UIImage(named: "menu") as UIImage? {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
            //  SJSwiftSideMenuController .showRightMenuNavigationBarButton(image: image)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- Send Action
    @IBAction func send_Action(_ sender: UIButton)
    {
        if self.send_TF.text?.isEmpty == true
        {
            //kTo_sendmsg
            
        }else
        {
            self.send_Chat_Data(ticket_id: ticket_id,comment:send_TF.text! , user_id: (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!)
            send_TF.text = ""
        }
        
    }
    //MARK:- Web Service Response Delegate
   /* @objc func callBackSuccessResponse(dictResponse: NSDictionary) {
        print(dictResponse)
        
        loader.hideLoader()
        if strApiFlag == "send"{
             self.get_Chat_Data(ticket_id: ticket_id, user_id: user_id)
        }
        else{
        if  dictResponse["status"] as! NSNumber == 1
        {
            if dictResponse["ticket_comment"] != nil
            {
                chat_Array = dictResponse["ticket_comment"] as! NSArray
                // chat_Array = chat_Array.reversed() as NSArray // This problem if check again is there the say to server
                
                chatSupport_TableView.reloadData()
                //  self.chat_TableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
                self.chatSupport_TableView.scrollToLastCall(animated: true)
             
                
            }
            
            if dictResponse["message"] != nil
            {
                let message : String =  (dictResponse["message"] as? String)!
                
                
                    
                    //Alert Message
                    // Alert.show(vc: self, titleStr: "Message", messageStr:"Booking Decline successfully.")
                
            }
            
        }
            
        }
        
        
    }*/
    
    
    @objc func callBackFailResponse(dictResponse: NSDictionary) {
        print(dictResponse)
        //SHOW DPK Loader
        loader.hideLoader()
        
        //Alert Message for API Fail
        Alert.show(vc: self, titleStr: "Message", messageStr: (dictResponse["message"] as! NSString) as String)
    }
    
   
    
}


extension SupportChatViewController
{
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.my_Ticket_Chat_Dic.My_Ticket_Chat_Arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if self.my_Ticket_Chat_Dic.My_Ticket_Chat_Arr.count > indexPath.row
        {
            let val_Dic  = self.my_Ticket_Chat_Dic.My_Ticket_Chat_Arr[indexPath.row]
            print(val_Dic)
            let message = val_Dic.comment
            
            
            let send_by = val_Dic.user_id
            
            let send_at = val_Dic.created_at
            
            let interval: TimeInterval? = Double( send_at )
            let date_get = Date(timeIntervalSince1970: interval!)
            let format_time = DateFormatter()
            format_time.dateFormat = "d MMM, yyyy HH:mm:ss"
            let date_Str_Com = format_time.string(from:date_get )
            print(date_Str_Com)
            if send_by.isEqual((SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!)
            {
                
                let left_cell:Left_Support_TableVCell = tableView.dequeueReusableCell(withIdentifier: "Left_Support_TableVCell", for: indexPath) as! Left_Support_TableVCell
                
                //cell.right_View.isHidden = true
                //left_cell.right_View.backgroundColor = UIColor.clear
                left_cell.left_Mess_Lab.text = (message as String)
                
                
                let formatter_Time = DateFormatter()
                formatter_Time.dateFormat = "h:mm a"
                let date_Str_Time = formatter_Time.string(from:date_get)
                print(date_Str_Time)
                left_cell.left_Date_Lab.text = "\(date_Str_Com)"+" "+"\(date_Str_Time)"
                if  NSCalendar.current.isDateInToday(date_get as! Date)
                {
                    
                    left_cell.left_Date_Lab.text = "Today,"+" "+"\(date_Str_Time)"
                }
                if  NSCalendar.current.isDateInYesterday(date_get as! Date)
                {
                    left_cell.left_Date_Lab.text = "Yesterday,"+" "+"\(date_Str_Time)"
                }
                
                return left_cell
            }
            else
            {
                let right_cell:Right_Support_TableVCell = tableView.dequeueReusableCell(withIdentifier: "Right_Support_TableVCell", for: indexPath) as! Right_Support_TableVCell
                
                right_cell.right_Mess_Lab.text = (message as String)
                right_cell.right_Mess_Lab.textColor = UIColor.white
                // right_cell.right_Mess_Lab.backgroundColor = UIColor(red: 230/255, green: 40/255, blue: 50/255, alpha: 1)
                
                let formatter_Time = DateFormatter()
                formatter_Time.dateFormat = "h:mm a"
                let date_Str_Time = formatter_Time.string(from:date_get)
                print(date_Str_Time)
                right_cell.right_Date_Lab.text = "\(date_Str_Com)"+" "+"\(date_Str_Time)"
                if  NSCalendar.current.isDateInToday(date_get )
                {
                    
                    right_cell.right_Date_Lab.text = "Today,"+" "+"\(date_Str_Time)"
                }
                if  NSCalendar.current.isDateInYesterday(date_get )
                {
                    right_cell.right_Date_Lab.text = "Yesterday,"+" "+"\(date_Str_Time)"
                }
                
                return right_cell
            }
        }
        

        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension;
    }
    
}
