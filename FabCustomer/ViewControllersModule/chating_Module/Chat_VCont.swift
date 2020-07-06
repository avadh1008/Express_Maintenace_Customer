//
//  Chat_VCont.swift
//  Ubeaut
//
//  Created by Samyotech on 02/04/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

import AVFoundation

//import SJSwiftSideMenuController

class Chat_VCont: UIViewController {
    
    class func viewController() -> Chat_VCont {
        return "Main".viewController("Chat_VCont") as! Chat_VCont
    }
    
    @IBOutlet weak var bottmView: UIView!
    
    var chatDic : Chat_Struct?
    
    @IBOutlet weak var imageHideButton: UIButton!
    
    @IBOutlet weak var imageView: UIView!
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var bottom_Constraint: NSLayoutConstraint!
    @IBOutlet weak var send_TF: UITextField!
    var picker:UIImagePickerController?=UIImagePickerController()
    
    @IBOutlet weak var chat_TableView: UITableView!
    let globel_variable = GlobalVariables.sharedManager
    //var chat_Array : NSArray = NSArray()
    var chatType:String = ""
    var artist_id = ""
    var user_id = ""
    var sender_name = ""
    var strApiFlag:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Add Observer
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(self.UpdateChat(notfication:)),
                                       name: NSNotification.Name(rawValue: "UpdateChat"),
                                       object: nil)
        
        
        
        self.send_TF.delegate = self
        self.navigationItem.title = sender_name.capitalized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        chat_TableView.dataSource = self
        chat_TableView.delegate = self
        
        let left_nib = UINib(nibName: "Left_Chat_TableVCell", bundle: nil)
        chat_TableView.register(left_nib, forCellReuseIdentifier: "Left_Chat_TableVCell")
        
        let right_nib = UINib(nibName: "Right_Chat_TableVCell", bundle: nil)
        chat_TableView.register(right_nib, forCellReuseIdentifier: "Right_Chat_TableVCell")
        
        
        if artist_id.isEmpty != true && user_id.isEmpty != true
        {
            self.get_Chat_Data(artist_id: artist_id, user_id: user_id)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Chat_VCont.dismissKeyboard))
        view.addGestureRecognizer(tap)
        imageView.isHidden  = true
       self.title = sender_name
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    
        create_Navigation_Bar_Mathod(str: self.title ?? "")
        
    }
    
    let left_B = UIButton()
    let right_B = UIButton()
    func create_Navigation_Bar_Mathod(str: String)
    {
        if let image : UIImage = UIImage(named: "menu")
        {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
            
        }
        
        left_B.addTarget(self, action: #selector(self.left_Mathod_Action(_:)), for: .touchUpInside)
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "back2"), left_title_Str: nil, right_B_Img:nil, right_title_Str: nil, title_Str: str, hidden_Nav: false, left_Button: left_B , right_Button: nil)
        
    }
    
    @IBAction func left_Mathod_Action( _ sender : UIButton!)
    {
        
        self.view.endEditing(true)
        if let image : UIImage = UIImage(named: "menu")
        {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
            
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @objc func UpdateChat(notfication: NSNotification) {
  
        self.load_chatData()
    }
    
    func load_chatData(){
        
        strApiFlag = "getChatData"

        
        var parameters : [String : String]  = [:]
        
        if artist_id != ""
        {
            parameters["artist_id"] = artist_id
        }
        if user_id != ""
        {
            parameters["user_id"] = user_id
        }
        
        print(parameters)
        
        
        loader.showLoader()
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getChat, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Chat_Struct.self  , completion : {(success, modelVal) -> Void in if success
        {
           
            self.chatDic = modelVal!
           // Alert.showMiddleToast(message: self.chatDic?.message, view_VC: self)
            loader.hideLoader()
          //  self.chat_TableView.reloadData()
            DispatchQueue.main.async
                {
                    self.chat_TableView.reloadData()
                    if self.chatDic?.my_chat?.count ?? 0 > 1
                    {
                        self.chat_TableView.scrollToLastCall(animated: false)
                    }
            }
        }
        else
        {
            self.chatDic?.my_chat?.removeAll()
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            self.chat_TableView.reloadData()
            }
        })
       
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
                
               
                
            }
            else
            {
                // no UIKeyboardFrameBeginUserInfoKey entry in userInfo
            }
        }
        else
        {
            // no userInfo dictionary in notification
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
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            bottom_Constraint.constant = 0
            chat_TableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            // self.chat_TableView.isScrollEnabled = true
            //bottom_Constraint.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    
    func get_Chat_Data( artist_id:String , user_id:String  )
    {
        
        strApiFlag = "getChatData"
        var parameters : [String : String]  = [:]
        
        if artist_id != ""
        {
            parameters["artist_id"] = artist_id
        }
        if user_id != ""
        {
            parameters["user_id"] = user_id
        }
        
        print(parameters)
        
        
        loader.showLoader()
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getChat, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Chat_Struct.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            self.chatDic = modelVal!
            
            loader.hideLoader()
            //self.chat_TableView.reloadData()
            DispatchQueue.main.async
                {
                   
                    self.chat_TableView.reloadData()
                    if self.chatDic?.my_chat?.count ?? 0 > 1
                    {
                        self.chat_TableView.scrollToLastCall(animated: false)
                    }
            }
        }
        else
        {
            self.chatDic?.my_chat?.removeAll()
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            self.chat_TableView.reloadData()
            }
        })
    
        
    }
    func send_Chat_Data( artist_id:String , user_id:String , message:String , send_by:String , sender_name:String   )
    {
        
        strApiFlag = "send"
        var parameters : [String : String]  = [:]
        
      
        if chatType == "2"{
            if artist_id != ""
            {
                parameters["artist_id"] = artist_id
            }
            if user_id != ""
            {
                parameters["user_id"] = user_id
            }
            if message != ""
            {
                parameters["message"] = message
            }
            if send_by != ""
            {
                parameters["send_by"] = send_by
            }
            if sender_name != ""
            {
                parameters["sender_name"] = sender_name
            }
            if chatType != ""
            {
                parameters["chat_type"] = "2"
            }
            
            
            loader.showLoader()
            Revoke_Service_Class.sharedInstance.createMultiPartReqest2(vc: self, dictPram: parameters, methodName: Constant.kTo_sendmsg, img_pram: "image", imageUpload_Arr: [selectImage.image!] , media_pram: nil  , video_url_Up_Arr : nil, with: Chat_Struct.self  , completion : {(success, modelVal) -> Void in if success
            {
                
                self.imageView.isHidden = true
                
                self.chatDic = modelVal!
           
                loader.hideLoader()
           
                DispatchQueue.main.async
                    {
                        
                        
                        self.chat_TableView.reloadData()
                      
                        if self.chatDic?.my_chat?.count ?? 0 > 1
                        {
                            self.chat_TableView.scrollToLastCall(animated: false)
                        }
                }
            }
            else
            {
                self.chatDic?.my_chat?.removeAll()
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                loader.hideLoader()
                self.chat_TableView.reloadData()
                }
            })

        }else{
            if artist_id != ""
            {
                parameters["artist_id"] = artist_id
            }
            if user_id != ""
            {
                parameters["user_id"] = user_id
            }
            if message != ""
            {
                parameters["message"] = message
            }
            if send_by != ""
            {
                parameters["send_by"] = send_by
            }
            if sender_name != ""
            {
                parameters["sender_name"] = sender_name
            }
            if chatType == ""
            {
                parameters["chat_type"] = "1"
            }
        
            
            loader.showLoader()
            Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_sendmsg, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Chat_Struct.self  , completion : {(success, modelVal) -> Void in if success
            {
                
                self.chatDic = modelVal!
                loader.hideLoader()
              
                DispatchQueue.main.async
                    {
                       
                        
                        self.chat_TableView.reloadData()
                        if self.chatDic?.my_chat?.count ?? 0 > 1
                        {
                            self.chat_TableView.scrollToLastCall(animated: false)
                        }
                }
            }
            else
            {
                self.chatDic?.my_chat?.removeAll()
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                loader.hideLoader()
                self.chat_TableView.reloadData()
                }
            })
            
            
        }
        print(parameters)
    
    }
    
    @IBAction func closeIMage(_ sender: Any) {
        imageView.isHidden = true
        selectImage = nil
    }
    
    @objc func back_Action()
    {
        
        self.view.endEditing(true)
        if let image : UIImage = UIImage(named: "menu") {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool:true)
        }
        navigationController?.popViewController(animated: false)
    }
   
    
    //MARK:- Send Action
    @IBAction func send_Action(_ sender: UIButton)
    {
        if self.send_TF.text?.isEmpty == true
        {
       
        }else
        {
            
            self.send_Chat_Data(artist_id: artist_id, user_id: user_id, message:send_TF.text! , send_by: (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!, sender_name: (SignUpDataClass.shareMngr.signUpData?.SignUdata!.name)!)
            send_TF.text = ""
        }
        
    }
  
    
  
    
  
    @IBAction func btnIMageAction(_ sender: Any) {
        // self.popupcamrea()
        
        
        ImageAction.instance.cropFigureType = 1
        ImageAction.instance.cornerRadiousType = 0
        ImageAction.instance.showFullActionSheet(on: self){ (image) in
            
            if let image = image{
               
                self.imageView.isHidden = false
                self.chatType = "2"
                self.selectImage.image = image
            }
            
            
        }
    }
    
  
}

extension Chat_VCont :  UITextFieldDelegate
{
    
}

extension Chat_VCont : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatDic?.my_chat?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        
        if let val_Dic  = self.chatDic?.my_chat?[indexPath.row]
        {
            
            
            print(val_Dic)
            let message         = val_Dic.message
            
            let send_at         = val_Dic.send_at
            let send_by         = val_Dic.send_by
            
            let chat_type = val_Dic.chat_type
            
            let interval: TimeInterval? = Double( send_at! )
            let date_get = Date(timeIntervalSince1970: interval!)
            let format_time = DateFormatter()
            format_time.dateFormat = "d MMM, yyyy"
            let date_Str_Com = format_time.string(from:date_get )
            print(date_Str_Com)
            if (send_by?.isEqual((SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!))!
            {
                
               if  let left_cell = cell as? Right_Chat_TableVCell
                {
                    
                    //cell.right_View.isHidden = true
                    //left_cell.right_View.backgroundColor = UIColor.clear
                    left_cell.right_Mess_Lab.text = message
                    
                 
                    
                    let formatter_Time = DateFormatter()
                    formatter_Time.dateFormat = "h:mm a"
                    let date_Str_Time = formatter_Time.string(from:date_get)
                    print(date_Str_Time)
                    
                    left_cell.right_Date_Lab.text = "\(date_Str_Com)"+" "+"\(date_Str_Time)"
                    
                    if  NSCalendar.current.isDateInToday(date_get)
                    {
                        
                        left_cell.right_Date_Lab.text = "Today,"+" "+"\(date_Str_Time)"
                    }
                    if  NSCalendar.current.isDateInYesterday(date_get )
                    {
                        left_cell.right_Date_Lab.text = "Yesterday,"+" "+"\(date_Str_Time)"
                    }
                    if chat_type == "1"{
                        left_cell.imageRightHeight.constant = 0
                    }else if chat_type == "2"{ //text and image
                        left_cell.imageRightHeight.constant = 90
                        left_cell.imageRight.sd_setImage(with: URL(string: val_Dic.image ?? ""  ), placeholderImage: UIImage(named: "sideProfile"))
                        
                    }
                    
                    
                }
                
               
                
            }
            else
            {
                
                if  let right_cell = cell as? Left_Chat_TableVCell
                {
                    
                    right_cell.left_Mess_Lab.text = message
                    right_cell.left_Mess_Lab.textColor = UIColor.white
                    // right_cell.right_Mess_Lab.backgroundColor = UIColor(red: 230/255, green: 40/255, blue: 50/255, alpha: 1)
                  
                    
                    
                    let formatter_Time = DateFormatter()
                    formatter_Time.dateFormat = "h:mm a"
                    let date_Str_Time = formatter_Time.string(from:date_get)
                    print(date_Str_Time)
                    right_cell.left_Date_Lab.text = "\(date_Str_Com)"+" "+"\(date_Str_Time)"
                    if  NSCalendar.current.isDateInToday(date_get )
                    {
                        
                        right_cell.left_Date_Lab.text = "Today"+" "+"\(date_Str_Time)"
                    }
                    if  NSCalendar.current.isDateInYesterday(date_get )
                    {
                        right_cell.left_Date_Lab.text = "Yesterday"+" "+"\(date_Str_Time)"
                    }
                    if val_Dic.chat_type == "1"{
                        right_cell.imageLeftHeight.constant = 0
                    }else if val_Dic.chat_type == "2"{ //text and image
                        right_cell.imageLeftHeight.constant = 90
                        right_cell.imageLeft.sd_setImage(with: URL(string: val_Dic.image ?? "" ), placeholderImage: UIImage(named: "sideProfile"))
                        
                    }
                    
                  
                }
              
                
            }
            
            
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       
        
        if let val_Dic  = self.chatDic?.my_chat?[indexPath.row]
        {
            print(val_Dic)
            let message         = val_Dic.message
            
            let send_at         = val_Dic.send_at
            let send_by         = val_Dic.send_by
            
            let chat_type = val_Dic.chat_type
            
            let interval: TimeInterval? = Double( send_at! )
            let date_get = Date(timeIntervalSince1970: interval!)
            let format_time = DateFormatter()
            format_time.dateFormat = "d MMM, yyyy"
            let date_Str_Com = format_time.string(from:date_get )
            print(date_Str_Com)
            
            
            if (val_Dic.send_by?.isEqual((SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!))!
            {
                
                let left_cell:Right_Chat_TableVCell = tableView.dequeueReusableCell(withIdentifier: "Right_Chat_TableVCell", for: indexPath) as! Right_Chat_TableVCell
                
                
                left_cell.delegate = self
                //cell.right_View.isHidden = true
                //left_cell.right_View.backgroundColor = UIColor.clear
                left_cell.right_Mess_Lab.text = message
                
            
                
                let formatter_Time = DateFormatter()
                formatter_Time.dateFormat = "h:mm a"
                let date_Str_Time = formatter_Time.string(from:date_get)
                print(date_Str_Time)
                
                left_cell.right_Date_Lab.text = "\(date_Str_Com)"+" "+"\(date_Str_Time)"
                
                if  NSCalendar.current.isDateInToday(date_get)
                {
                    
                    left_cell.right_Date_Lab.text = "Today,"+" "+"\(date_Str_Time)"
                }
                if  NSCalendar.current.isDateInYesterday(date_get )
                {
                    left_cell.right_Date_Lab.text = "Yesterday,"+" "+"\(date_Str_Time)"
                }
                if chat_type == "1"{
                    left_cell.imageRightHeight.constant = 0
                }else if chat_type == "2"{ //text and image
                    left_cell.imageRightHeight.constant = 90
                    left_cell.imageRight.sd_setImage(with: URL(string: val_Dic.image ?? ""  ), placeholderImage: UIImage(named: "sideProfile"))
                    
                }
                
                
                return left_cell
                
            }
            else
            {
                let right_cell:Left_Chat_TableVCell = tableView.dequeueReusableCell(withIdentifier: "Left_Chat_TableVCell", for: indexPath) as! Left_Chat_TableVCell
                
                right_cell.delegate = self
                right_cell.left_Mess_Lab.text = message
                right_cell.left_Mess_Lab.textColor = UIColor.white
              
                let formatter_Time = DateFormatter()
                formatter_Time.dateFormat = "h:mm a"
                let date_Str_Time = formatter_Time.string(from:date_get)
                print(date_Str_Time)
                right_cell.left_Date_Lab.text = "\(date_Str_Com)"+" "+"\(date_Str_Time)"
                if  NSCalendar.current.isDateInToday(date_get )
                {
                    
                    right_cell.left_Date_Lab.text = "Today"+" "+"\(date_Str_Time)"
                }
                if  NSCalendar.current.isDateInYesterday(date_get )
                {
                    right_cell.left_Date_Lab.text = "Yesterday"+" "+"\(date_Str_Time)"
                }
                if val_Dic.chat_type == "1"{
                    right_cell.imageLeftHeight.constant = 0
                }else if val_Dic.chat_type == "2"{ //text and image
                    right_cell.imageLeftHeight.constant = 90
                    right_cell.imageLeft.sd_setImage(with: URL(string: val_Dic.image ?? "" ), placeholderImage: UIImage(named: "sideProfile"))
                    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       /* if let val_Dic  = self.chatDic?.my_chat?[indexPath.row]
        {
            if (val_Dic.send_by?.isEqual((SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!))!
            {
                if let cell = tableView.cellForRow(at: indexPath) as? Right_Chat_TableVCell
                {
                    let configuration = ImageViewerConfiguration { config in
                        config.imageView = cell.imageRight
                    }
                    present(ImageViewerController(configuration: configuration), animated: true)
                }
            }
            else
            {
                if let cell = tableView.cellForRow(at: indexPath) as? Left_Chat_TableVCell
                {
                    let configuration = ImageViewerConfiguration { config in
                        config.imageView = cell.imageLeft
                    }
                    
                    present(ImageViewerController(configuration: configuration), animated: true)
                    
                }
            }
            
        }*/
    }
}

extension Chat_VCont : rightCellDelegate
{
    func openImageAction(cell: Right_Chat_TableVCell) {
        
            let configuration = ImageViewerConfiguration { config in
                config.imageView = cell.imageRight
            }
            
            present(ImageViewerController(configuration: configuration), animated: true)
        
    }
    
    
}

extension Chat_VCont : leftCellDelegate
{
    func openImageAction(cell: Left_Chat_TableVCell) {
        
            let configuration = ImageViewerConfiguration { config in
                config.imageView = cell.imageLeft
            }
            
            present(ImageViewerController(configuration: configuration), animated: true)
            
        
    }
    
    
}

/*
extension Chat_VCont: PKCCropDelegate{
    
    func pkcCropImage(_ image: UIImage?, originalImage: UIImage?) {
 
    }
    
    //If crop is canceled
    func pkcCropCancel(_ viewController: PKCCropViewController) {
        viewController.navigationController?.popViewController(animated: true)
        imageSelected.isHidden = true
        btnCloseImage.isHidden = true
    }
    
    //Successful crop
    func pkcCropComplete(_ viewController: PKCCropViewController) {
        if viewController.tag == 0{
            viewController.navigationController?.popViewController(animated: true)
        }else{
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}
extension Chat_VCont :  UITextFieldDelegate,UIPopoverControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate
 {
 func popupcamrea()
 {
 let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
 
 let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)
 {
 UIAlertAction in
 self.openCamera()
 
 }
 let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertAction.Style.default)
 {
 UIAlertAction in
 self.openGallary()
 }
 let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
 {
 UIAlertAction in
 }
 
 
 picker?.delegate = self
 alert.addAction(cameraAction)
 alert.addAction(gallaryAction)
 alert.addAction(cancelAction)
 
 self.present(alert, animated: true, completion: nil)
 
 }
 
 func openCamera()
 {
 if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
 {
 picker!.sourceType = UIImagePickerController.SourceType.camera
 self .present(picker!, animated: true, completion: nil)
 }
 else
 {
 openGallary()
 }
 }
 func openGallary()
 {
 picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
 
 self.present(picker!, animated: true, completion: nil)
 
 }
 
 
 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 
 
 
 if let image = info[.originalImage] as? UIImage{
 
 PKCCropHelper.shared.degressBeforeImage = image//UIImage(named: "pkc_crop_rotate_left.png")
 PKCCropHelper.shared.degressAfterImage = image//UIImage(named: "pkc_crop_rotate_right.png")
 
 DispatchQueue.main.async {
 PKCCropHelper.shared.isNavigationBarShow = false
 let cropVC = PKCCropViewController(image)//UIImage(named: "image.jpeg")!)
 cropVC.delegate = self
 self.navigationController?.pushViewController(cropVC, animated: true)
 picker.dismiss(animated: true, completion: nil)
 }
 
 }
 
 
 }
 
 func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
 {
 picker.dismiss(animated: true, completion: nil)
 
 }
 
 }*/
