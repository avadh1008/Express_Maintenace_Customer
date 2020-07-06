//
//  Chating_Home_VContr.swift
//  Ubeaut
//
//  Created by Samyotech on 02/04/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit
import Alamofire

class Chating_Home_VContr: UIViewController , UITableViewDelegate , UITableViewDataSource   {
    
    class func viewController() -> Chating_Home_VContr {
        return "Main".viewController("Chating_Home_VContr") as! Chating_Home_VContr
    }
    
    let search_By_Predicate  =  "artistName"
    
    
    var my_chat_history : Chat_Struct?
    var history_Chat_Dic : Chat_Struct?
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblNoDataFOund: UILabel!
    var count_rev  =  0
    //var //main_Array : NSMutableArray =  NSMutableArray()
    
  //  var date_sec_Arr : NSMutableArray = NSMutableArray()
    var date_com : Date? = nil
    var data_Count = 0
    
    //var chat_history : NSArray = NSArray()
    let globel_variable = GlobalVariables.sharedManager
    @IBOutlet weak var chating_TableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(Chating_Home_VContr.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    var main_Array_Search_Array :  NSArray = NSArray()
    var search_Bol : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
          searchBar.placeholder = "Search By UserName"
           self.chating_TableView.addSubview(self.refreshControl)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // register cell
        let nib = UINib(nibName: "Chat_Home_TableVCell", bundle: nil)
        chating_TableView.register(nib, forCellReuseIdentifier: "Chat_Home_TableVCell")
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        lblNoDataFOund.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.get_Chating_Data(artist_id: (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!)
        
        
        super.viewWillAppear(animated)
       
        self.navigationItem.title = "Chat"
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(Chating_Home_VContr.UpdateChatHome(notfication:)),
                                       name: NSNotification.Name(rawValue: "UpdateChat"),
                                       object: nil)
        
        self.navigationbarSetUp()
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        self.get_Chating_Data(artist_id: (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!)
        // self.tblhistory.reloadData()
        refreshControl.endRefreshing()
    }

    
    //MARK:- Custom Method
    func navigationbarSetUp() {
        
        let image = UIImage(named: "Header_bar")
        self.navigationController?.navigationBar.setBackgroundImage(image,for: .default)
       
        navigationItem.title = defaultLocalizer.stringForKey(key: "Chats")
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.setHidesBackButton(true, animated:false)
        
    }
    @objc func UpdateChatHome(notfication: NSNotification) {
        // print(notfication.userInfo)
        self.get_Chating_DataNoti(artist_id: (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!)
    }
    func get_Chating_DataNoti( artist_id:String  )
    {
        
        var parameters : [String : String]  = ["user_id":  (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!]
        
        if artist_id != ""
        {
            parameters["user_id"] = artist_id
        }
        
        print(parameters)
        
       // DPKWebOperation.operation_delegate = self
        //SHOW DPK Loader24.45454
      //  loader.showLoader()
        //Call WebService
        
      //  DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_getChatHistoryForArtist)
        loader.showLoader()
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getChatHistoryForUser, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Chat_Struct.self  , completion : {(success, modelVal) -> Void in if success
        {
            self.my_chat_history = modelVal!
            
            self.history_Chat_Dic = modelVal!
            self.chating_TableView.dataSource = self
            self.chating_TableView.delegate = self
            self.chating_TableView.reloadData()
            loader.hideLoader()
            
        }
        else
        {
            loader.hideLoader()
            
            
            }
        })
    }
    
    func get_Chating_Data( artist_id:String  )
    {
        
        var parameters : [String : String]  = ["user_id":  (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!]
        
        if artist_id != ""
        {
            parameters["user_id"] = artist_id
        }
        
        print(parameters)
        
       
        
        loader.showLoader()
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getChatHistoryForUser, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Chat_Struct.self  , completion : {(success, modelVal) -> Void in if success
        {
            self.my_chat_history = modelVal!
            self.history_Chat_Dic = modelVal!
            self.chating_TableView.dataSource = self
            self.chating_TableView.delegate = self
            self.chating_TableView.reloadData()
            loader.hideLoader()
            
        }
        else
        {
            
            self.my_chat_history?.my_chat!.removeAll()
            self.history_Chat_Dic?.my_chat!.removeAll()
            self.chating_TableView.reloadData()
            loader.hideLoader()
            
            
            }
        })
    }
    /*
     //MARK:- Web Service Response Delegate
    @objc func callBackSuccessResponse(dictResponse: NSDictionary) {
        print(dictResponse)
        lblNoDataFOund.isHidden = true
          chating_TableView.isHidden = false
         searchBar.isHidden = false
        loader.hideLoader()
        
        if  dictResponse["status"] as! NSNumber == 1
        {
            if dictResponse["my_chat"] != nil
            {
                self.chat_history = dictResponse["my_chat"] as! NSArray
                main_Array = self.chat_history.mutableCopy() as! NSMutableArray
                
                chating_TableView.dataSource = self
                chating_TableView.delegate = self
                chating_TableView.reloadData()
                loader.hideLoader()
            }
            
            
            
            loader.hideLoader()
        }
            
        else
        {
            
            loader.hideLoader()
            Alert.show(vc: self, titleStr: "Message", messageStr: (dictResponse["message"] as! NSString) as String)
        }
        
        
    }
    
    
    @objc func callBackFailResponse(dictResponse: NSDictionary) {
        print(dictResponse)
        //SHOW DPK Loader
        loader.hideLoader()
        searchBar.isHidden = true
        chating_TableView.isHidden = true
        //Alert Message for API Fail
        //Alert.show(vc: self, titleStr: "Message", messageStr: (dictResponse["message"] as! NSString) as String)
         lblNoDataFOund.isHidden = false
    }
    */
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return my_chat_history?.my_chat?.count ?? 0
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:Chat_Home_TableVCell = tableView.dequeueReusableCell(withIdentifier: "Chat_Home_TableVCell", for: indexPath) as! Chat_Home_TableVCell
        
        if let val_dic = my_chat_history?.my_chat?[indexPath.row]
            
        {
            
            
            print(val_dic)
            if  let image_url = val_dic.artistImage{
                cell.chat_Home_ImageView.sd_setImage(with: URL(string: image_url ), placeholderImage: UIImage(named: "profile-dummy"))
            }
            
            cell.name_Label.text = val_dic.artistName?.capitalized
            cell.dec_Label.text = val_dic.message
            
            
            if let dateStr = NSString( utf8String: val_dic.date ?? "0" )
            {
                let interval: TimeInterval? = dateStr.doubleValue
                let date_get = Date(timeIntervalSince1970: interval!)
                let format = DateFormatter()
                format.dateFormat = "d MMM, yyyy"
                //        let date_Str_Com = dateFormatter.string(from:date_S as! Date)
                //        print(date_Str_Com)
                let formatter_Time = DateFormatter()
                formatter_Time.dateFormat = "h:mm a"
                let date_Str_Time = formatter_Time.string(from:date_get)
                print(date_Str_Time)
                
                
                cell.data_Label.text = date_Str_Time
                
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d MMM, yyyy"
                let dateString = dateFormatter.string(from:date_get )
                print(dateString)
                cell.lblDay.text = dateString
                
                if  NSCalendar.current.isDateInToday(date_get)
                {
                    cell.lblDay.text = "Today"
                }
                if  NSCalendar.current.isDateInYesterday(date_get)
                {
                    cell.lblDay.text = "Yesterday"
                }
                
            }
            
        }
            
            
        
        /*else
        {
            
                let val_dic = my_chat_history.my_chat_history_Arr[indexPath.row]
                
                    
                    print(val_dic)
                    let image_url = val_dic.userImage
                    cell.chat_Home_ImageView.sd_setImage(with: URL(string: image_url as String), placeholderImage: UIImage(named: "profile-dummy"))
                    
                    let dateStr = val_dic.date
                    let interval: TimeInterval? = dateStr.doubleValue
                    let date_get = Date(timeIntervalSince1970: interval!)
                    let format = DateFormatter()
                    format.dateFormat = "d MMM, yyyy"
                    //        let date_Str_Com = dateFormatter.string(from:date_S as! Date)
                    //        print(date_Str_Com)
                    let formatter_Time = DateFormatter()
                    formatter_Time.dateFormat = "h:mm a"
                    let date_Str_Time = formatter_Time.string(from:date_get)
                    print(date_Str_Time)
                    
                    cell.name_Label.text = val_dic.userName.capitalized
                    cell.data_Label.text = date_Str_Time
                    cell.dec_Label.text = (val_dic["message"] as! String)
                    
                    
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "d MMM, yyyy"
                    let dateString = dateFormatter.string(from:date_get )
                    print(dateString)
                    cell.lblDay.text = dateString
                    
                    if  NSCalendar.current.isDateInToday(date_get)
                    {
                        cell.lblDay.text = "Today"
                    }
                    if  NSCalendar.current.isDateInYesterday(date_get)
                    {
                        cell.lblDay.text = "Yesterday"
                    }
                    
           
        }*/
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if let val_dic = my_chat_history?.my_chat?[indexPath.row]
        {
            let ch_VC:Chat_VCont = Chat_VCont.viewController()
            if let arid = val_dic.artist_id , let usid = val_dic.user_id
            {
                ch_VC.artist_id = arid
                ch_VC.user_id = usid
                ch_VC.sender_name = val_dic.artistName ?? ""
            }
            
            self.navigationController?.pushViewController(ch_VC, animated: false)
        }
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
extension Chating_Home_VContr  : UISearchBarDelegate
{
    
    // MARK: - SEARCH BAR This method updates filteredData based on the text in the Search Box
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
        
        if searchText.count == 0
        {
            self.my_chat_history?.my_chat = self.history_Chat_Dic?.my_chat
            
            DispatchQueue.main.async {
                self.chating_TableView.reloadData()
            }
        }
        else if searchText.count >= 1
        {
            print(searchText.count)
            let predicate=NSPredicate(format: "SELF."+"\(search_By_Predicate)"+" CONTAINS[cd] %@", searchText)
            
            print(predicate)
            
            
            
            self.my_chat_history?.my_chat = self.history_Chat_Dic?.my_chat?.filter({( Obj : My_chat) -> Bool in
                
                
                return Obj.artistName!.lowercased().contains(searchText.lowercased())  ;
            })
            
            DispatchQueue.main.async {
                self.chating_TableView.reloadData()
            }
            
            
        }
        
        
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        // searchBar.text = ""
        searchBar.resignFirstResponder()
        
        // load_Table_Search()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        load_Table_Search()
    }
    
    /*func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
     {
     
     }*/
    
    
    
    func load_Table_Search()
    {
        self.my_chat_history?.my_chat = self.history_Chat_Dic?.my_chat
        DispatchQueue.main.async {
            self.chating_TableView.reloadData()
        }
    }
    
 /*
    // MARK: - TableView Delegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        self.search_Bol = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.search_Bol = false
        self.get_Chating_Data(artist_id: (SignUpDataClass.shareMngr.signUpData?.sign_data!.user_id)!)
        
    }
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        search_Bol = true
        print(searchText)
        // let predicate=NSPredicate(format: "SELF.artistName CONTAINS[cd] %@", searchText)
        // history_Search_Array = data_dic.mutableCopy() as! NSMutableDictionary
        //getAppoinment_Search_Array  = getAppoinment.filtered(using: predicate) as NSArray
        
        var resultPredicate : NSPredicate = NSPredicate(format: "SELF.userName CONTAINS[cd] %@", searchText)
        //var recipes : NSArray = NSArray()
        main_Array_Search_Array = main_Array.filtered(using: resultPredicate) as NSArray
        
        
        chating_TableView.reloadData()
    }
    */
}
