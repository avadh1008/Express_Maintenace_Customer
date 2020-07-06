//
//  Applied_VCont.swift
//  FabCustomer
//
//  Created by Samyotech on 25/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit


class Applied_VCont: UIViewController {
    
    class func viewController() -> Applied_VCont {
        return "Main".viewController("Applied_VCont") as! Applied_VCont
    }
    
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    @IBOutlet weak var imageArts: UIImageView!
    @IBOutlet weak var lblArtistNamer: UILabel!
    @IBOutlet weak var lblCat1: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var labelInvocieId: UILabel!
    
    var job_id : String!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewIno: CustomView!
    @IBOutlet weak var searchBarApplied: UISearchBar!
    @IBOutlet weak var total_applied_TableV  : UITableView!
    @IBOutlet weak var noJob_Label  : UILabel!
    let left_B = UIButton()
    let right_B = UIButton()
    var getTitle:String = " "
    let globel_var  =  GlobalVariables.sharedManager
    var search_By_Predicate  =  ""
    var val_Appliedjob_Arr = [Get_applied_job_by_id_Struct]() //   val_Breed_Arr
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationMathod()
        searchBarApplied.placeholder = defaultLocalizer.stringForKey(key:"Search By Job Id")
          search_By_Predicate = "title"
        let image : UIImage = UIImage(named: "menu")!
        SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
        
        total_applied_TableV.addSubview(refreshControl)
        
        Register_Nib_With_Delegate.sharedInstance.register_Mathod(vc: self, tableV_Name: total_applied_TableV, cell_Identity: "Applied_TableVCell")
        
        

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Applied_VCont.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        viewIno.isHidden = true
        viewBack.isHidden = true
        
        self.globel_var.applied_job_by_id_Arr.removeAll()
        get_applied_job_by_id(api_Key: Constant.kTo_applied_job_by_id)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        create_Navigation_Bar_Mathod()
        
    }
    @objc override func dismissKeyboard() {
        view.endEditing(true)
        viewIno.isHidden = true
        viewBack.isHidden = true
    }
    func create_Navigation_Bar_Mathod()
    {
        if let image : UIImage = UIImage(named: "menu") {
        SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
        }
        
        left_B.addTarget(self, action: #selector(self.back_Mathod_Action(_:)), for: .touchUpInside)
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img: #imageLiteral(resourceName: "back2"), left_title_Str: nil, right_B_Img: nil, right_title_Str: defaultLocalizer.stringForKey(key: ""), title_Str: defaultLocalizer.stringForKey(key: "Jobs"), hidden_Nav: false, left_Button: left_B, right_Button: nil )
        
    }
    
    
    
    @IBAction func right_Mathod_Action( _ sender : UIButton!)
    {
      
    }
    @IBAction func back_Mathod_Action( _ sender : UIButton!)
    {
        let image : UIImage = UIImage(named: "menu")!
        SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
        self.navigationController?.popViewController(animated: true)
    }
    

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        get_applied_job_by_id(api_Key: Constant.kTo_applied_job_by_id)
    }
   
    func get_applied_job_by_id(api_Key : String!)
    {
        // artist_id  ///  get_all_job
        
        let parameters : [String : String] = ["job_id" : job_id ]
        
        Revoke_Service_Class.sharedInstance.get_applied_job_by_id_Request(vc: self, dictPram: parameters, methodName: api_Key) { (success) in
            if success
            {
                print(self.globel_var.applied_job_by_id_Arr.count)
                if self.globel_var.applied_job_by_id_Arr.count > 0
                {
                       self.noJob_Label.isHidden = true
                       self.val_Appliedjob_Arr = self.globel_var.applied_job_by_id_Arr
                    self.searchBarApplied.isHidden = false
                }
                else
                {
                    self.noJob_Label.isHidden = false
                    self.searchBarApplied.isHidden = true
                }
                print(self.globel_var.applied_job_by_id_Arr)
                self.refreshControl.endRefreshing()
                self.total_applied_TableV.reloadData()
            }
            else
            {
                self.refreshControl.endRefreshing()
                self.globel_var.applied_job_by_id_Arr.removeAll()
                self.noJob_Label.isHidden = false
                self.searchBarApplied.isHidden = true
                self.total_applied_TableV.reloadData()
            }
        }
        
    }
    
    //MARK: - reject or GetInTouch or Complete Mathod : - 0-
    func update_job_Mathod(api_Key : String! , aj_id: String! , status_Val : String!, job_id : String! )
    {
        // artist_id  ///  get_all_job
        
        let parameters : [String : String] = ["aj_id" : aj_id ,"status":status_Val ,"job_id":job_id ]
       
        Revoke_Service_Class.sharedInstance.Update_Mathod_Request(vc: self, dictPram: parameters, methodName: api_Key) { (success) in
            if success
            {
                self.get_applied_job_by_id(api_Key: Constant.kTo_applied_job_by_id)
            }
            else
            {
                
            }
        }
        
    }
    //MARK: - Reject
    @objc func reject_Mathod_Action(_ Sender : UIButton!)
    {
        
        
        let alert = UIAlertController(title: Alert.kmsg, message: Alert.k_Job_Reject, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            // logout
            let dic =  self.globel_var.applied_job_by_id_Arr[Sender.tag]
            self.update_job_Mathod(api_Key: Constant.kTo_job_status_user, aj_id: dic.aj_id, status_Val: "3", job_id: dic.job_id)
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    //MARK: - Confirm
    @objc func confirm_Mathod_Action(_ Sender : UIButton!)
    {
       
       
        
        let alert = UIAlertController(title: Alert.kmsg, message: Alert.k_Job_confirm, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            // logout
            let dic =  self.globel_var.applied_job_by_id_Arr[Sender.tag]
            self.update_job_Mathod(api_Key: Constant.kTo_job_status_user, aj_id: dic.aj_id, status_Val: "1", job_id: dic.job_id)
            
            
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @objc func confirm_Mathod_Action2(_ Sender : UIButton!){
        
        viewIno.isHidden = false
           viewBack.isHidden = false
        let val_dic  =  self.globel_var.applied_job_by_id_Arr[Sender.tag]
        print(val_dic)
        let artist_id = val_dic.artist_id
        let job_id = val_dic.job_id
        
        
        let parameters : [String : String] = ["job_id" : job_id, "artist_id":artist_id]
        
        Revoke_Service_Class.sharedInstance.get_applied_job_Invoice(vc: self, dictPram: parameters, methodName: Constant.kTo_SinglegetInvoice) { (success) in
            if success
            {
                let dic =  self.globel_var.getSingle_Incoice_Struct
                var setString = "Service # "
                var getServiceName:String = dic.invoice_id
                self.labelInvocieId.text  = setString + getServiceName
                  let dateStr = dic.created_at
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = Locale.init(identifier: "en_GB")
                let dateObj = dateFormatter.date(from: dateStr)
                let formatter = DateFormatter()
                formatter.dateFormat = "d MMM, yyyy"
                
          //      self.lblDate.text = (formatter.string(from: dateObj!))
                
                var workingMin:String =  dic.working_min
                dateFormatter.dateFormat = "mm:ss"
                let dateObjMins = dateFormatter.date(from: workingMin)
                if dateObjMins == nil{
                    self.lblDuration.text = "DURATION " + "00:00:00"
                }
                else{
                    dateFormatter.dateFormat = "HH:mm:ss"
                    self.lblDuration.text = "DURATION " +  (dateFormatter.string(from: dateObjMins!))
                }
                self.lblPrice.text = dic.currency_type + " " +  dic.total_amount
                self.lblArtistNamer.text = dic.artistName
                
                 let image_url = dic.artistImage
                 self.imageArts.sd_setImage(with: URL(string:image_url ), placeholderImage: #imageLiteral(resourceName: "profile"))
                 self.imageArts.layer.cornerRadius = self.imageArts.frame.width / 2;
                  self.imageArts.layer.masksToBounds = true;
                
                self.lblCategory.text = dic.category_name
                self.lblCat1.text = dic.category_name
                
            }
            else
            {
               
            }
        }
        
        
    }
    @objc func confirm_Mathod_Action1(_ Sender : UIButton!)
    {
    let val_dic  =  self.globel_var.applied_job_by_id_Arr[Sender.tag]
    print(val_dic)
    let artist_id = val_dic.artist_id
    let user_id = val_dic.user_id
    let sender_name = val_dic.artist_name
    let ch_VC:Chat_VCont = Chat_VCont.viewController()
    ch_VC.artist_id = artist_id
    ch_VC.user_id = user_id
    ch_VC.sender_name = sender_name
    self.navigationController?.pushViewController(ch_VC, animated: false)
    }
    
    //MARK: - complete
    @objc func complete_Mathod_Action(_ Sender : UIButton!)
    {
        
     
        if getTitle  == " Finish job"{
 let alert = UIAlertController(title: Alert.kmsg, message: defaultLocalizer.stringForKey(key:"Are you sure do you want to finish this job"), preferredStyle: .alert)
 
 // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
 UIAlertAction in
 NSLog("OK Pressed")
 // logout
    let ch_VC:BookingViewController = BookingViewController.viewController()
    self.navigationController?.pushViewController(ch_VC, animated: false)

 
 }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
 UIAlertAction in
 NSLog("Cancel Pressed")
 }
 
 // Add the actions
 alert.addAction(okAction)
 alert.addAction(cancelAction)
 
 
 
 self.present(alert, animated: true, completion: nil)
 
        }else{
            
        }
    }
}

extension Applied_VCont : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.globel_var.applied_job_by_id_Arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : Applied_TableVCell = tableView.dequeueReusableCell(withIdentifier: "Applied_TableVCell", for: indexPath) as! Applied_TableVCell
        let dic =  self.globel_var.applied_job_by_id_Arr[indexPath.row]
        cell.mobileImage.isHidden = false
        cell.mobileEmail.isHidden = false
        cell.mobileAddres.isHidden = false
        cell.name_Label.text        =   dic.artist_name
        cell.job_id_Label.text      =   dic.job_id
        let date        =                   dic.created_at
        cell.dec_Label.text         =   dic.description
        cell.address_Label.text     =   dic.artist_address
        cell.email_Label.text       =   dic.artist_email
        cell.mobile_Label.text      =   dic.artist_mobile
        cell.rating_Label.text      =   rating_Mathod(ratingStr:String(dic.ava_rating)) //
        cell.rating_View.rating     =   rat_Mathod(ratingStr: String(dic.ava_rating))
        cell.service_Label.text = dic.category_name
        cell.lblPrice.text = dic.currency_symbol + " " + dic.price
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dd = formatter.date(from: date)
        let myString = formatter.string(from: dd!)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd MMM YYYY HH:mm:ss"
        _ = formatter.string(from: yourDate!)
        cell.date_Label.text = timeStamp_Str_MathodGMT(timeSt: dic.job_timestamp)
        
        print(dic.artist_mobile)
        print(dic.artist_email)
        print(dic.artist_address)
       
        if dic.artist_mobile == "" {
             cell.mobileImage.image = nil
        }
        if dic.artist_email == "" {
             cell.mobileEmail.image = nil
        }
         if dic.artist_address == "" {
            cell.mobileAddres.image = nil
        }
        
        
        /*
         Feb_red
         Feb_green
         Feb_yello
         */
        cell.stuts_Label.layer.cornerRadius = 5
        cell.stuts_Label.clipsToBounds = true
        if dic.status == "0"
        {
            cell.stuts_Label.text =  "Applied"
            cell.stuts_Label.backgroundColor = Constant.KcolorYoga
            cell.complete_View.isHidden = true
            cell.option_View.isHidden = false
           cell.viewInvoice.isHidden = true
            cell.height_Constrent.constant = 40
            cell.complete_Button.isUserInteractionEnabled = true
        }
        else if  dic.status == "1"
        {
            cell.stuts_Label.backgroundColor = Constant.Feb_yello
            cell.stuts_Label.text =  "Confirm"
            cell.complete_View.isHidden = false
              cell.viewInvoice.isHidden = true
            cell.option_View.isHidden = true
            cell.height_Constrent.constant = 40     //Artist will satrt soon
               cell.complete_Button.setTitle(" Artist will start soon", for: .normal)
              cell.complete_Button.isUserInteractionEnabled =  false
        }
        else if  dic.status == "2"
        {
            cell.stuts_Label.backgroundColor = Constant.Feb_green
            cell.stuts_Label.text =  "Complete"
            cell.complete_View.isHidden = true
             cell.option_View.isHidden = true
              cell.viewInvoice.isHidden = false
            cell.height_Constrent.constant = 40
        }
        else if  dic.status == "3"
        {
            cell.stuts_Label.backgroundColor = Constant.Feb_red
            cell.stuts_Label.text =  "Reject"
            cell.complete_View.isHidden = true
            cell.option_View.isHidden = true
          cell.viewInvoice.isHidden = true

            cell.height_Constrent.constant = 0
        }
        else if  dic.status == "5"
        {
            cell.complete_Button.isUserInteractionEnabled = true
            cell.complete_Button.setTitle(" Finish job", for: .normal)
            cell.stuts_Label.backgroundColor = UIColor.blue
            cell.stuts_Label.text =  "In Progress"
            cell.complete_View.isHidden = false
            cell.option_View.isHidden = true
           cell.viewInvoice.isHidden = true
            cell.height_Constrent.constant = 40
            getTitle  =     (cell.complete_Button.titleLabel?.text)!
            cell.complete_Button.isUserInteractionEnabled =  true

        }
        cell.pro_ImgV.sd_setImage(with: URL(string:dic.artist_image ), placeholderImage: #imageLiteral(resourceName: "profile"))
        
        cell.complete_Button.tag = indexPath.row
        cell.reject_Button.tag = indexPath.row
        cell.getTouch_Button.tag = indexPath.row
        cell.chatButton.tag = indexPath.row
       cell.getInvoice.tag = indexPath.row
        cell.complete_Button.addTarget(self, action: #selector(self.complete_Mathod_Action(_:)), for: .touchUpInside)
        
        cell.reject_Button.addTarget(self, action: #selector(self.reject_Mathod_Action(_:)), for: .touchUpInside)
        cell.getTouch_Button.addTarget(self, action: #selector(self.confirm_Mathod_Action(_:)), for: .touchUpInside)
        cell.chatButton.addTarget(self, action: #selector(self.confirm_Mathod_Action1(_:)), for: .touchUpInside)
         cell.getInvoice.addTarget(self, action: #selector(self.confirm_Mathod_Action2(_:)), for: .touchUpInside)
        
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        total_applied_TableV.estimatedRowHeight = 120
        total_applied_TableV.rowHeight = UITableView.automaticDimension
        return  total_applied_TableV.rowHeight
    }
    
    
}
extension Applied_VCont  : UISearchBarDelegate
{
    
    // MARK: - SEARCH BAR This method updates filteredData based on the text in the Search Box
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
        
        if searchText.count == 0
        {
            self.globel_var.applied_job_by_id_Arr = self.val_Appliedjob_Arr
            
            DispatchQueue.main.async {
                self.total_applied_TableV.reloadData()
            }
        }
        else if searchText.count >= 1
        {
            print(searchText.count)
            let predicate=NSPredicate(format: "SELF."+"\(search_By_Predicate)"+" CONTAINS[cd] %@", searchText)
            
            print(predicate)
            
            
            
            self.globel_var.applied_job_by_id_Arr = val_Appliedjob_Arr.filter({( job_Obj : Get_applied_job_by_id_Struct) -> Bool in
                
                print(job_Obj.job_id)
                
                
                return job_Obj.job_id.lowercased().contains(searchText.lowercased())
            })
            
            DispatchQueue.main.async {
                self.total_applied_TableV.reloadData()
            }
            
            
        }
        
        
    }
    
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        load_Table_Search()
    }
    
    
    
    func load_Table_Search()
    {
        self.globel_var.applied_job_by_id_Arr = self.val_Appliedjob_Arr
        DispatchQueue.main.async {
            self.total_applied_TableV.reloadData()
        }
    }
    
}


extension Applied_VCont {
    func notificationMathod()
    {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(self.NewRequestFound10012(notfication:)),
                                       name: NSNotification.Name(rawValue: "NewRequestFound10012"),
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(self.sobStart10003(notfication:)),
                                       name: NSNotification.Name(rawValue: "sobStart10003"),
                                       object: nil)
    }
    
    @objc func NewRequestFound10012(notfication: NSNotification)
    {
        get_applied_job_by_id(api_Key: Constant.kTo_applied_job_by_id)
        
    }
    
    @objc func sobStart10003(notfication: NSNotification)
    {
        get_applied_job_by_id(api_Key: Constant.kTo_applied_job_by_id)
        
        
    }
    
}
