//
//  HistoryVC.swift
//  FabArtist
//
//  Created by iMac on 09/03/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController,UITableViewDataSource,UITableViewDelegate  {
    
    class func viewController() -> HistoryVC {
        return "Main".viewController("HistoryVC") as! HistoryVC
    }
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    @IBOutlet weak var viewPop: UIScrollView!
    @IBOutlet weak var issue_TF: UITextView!
    @IBOutlet var tblhistory:UITableView!
    
    
    let search_By_Predicate  =  "invoice_id"
    
    
    @IBOutlet weak var searchBar: UISearchBar!
  
    var history_Bool:Bool = false
    var history_Array :  NSArray = NSArray()
    let globel_variable = GlobalVariables.sharedManager
    var strApiFlag:String = ""
    var search_Bol : Bool = false
    @IBOutlet weak var lblnoDataFound: UILabel!
    //MARK:- REFRESH TABLE VIEW
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(HistoryVC.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    var sendertagForSelection = 0
    var paidArray:NSMutableArray = NSMutableArray()
    var unPaidArray:NSMutableArray = NSMutableArray()
    var  paid_Search_Array:NSArray = NSArray()
    var unPaidArray_Search_Array:NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblnoDataFound.isHidden = true
        searchBar.delegate = self
        searchBar.placeholder = "Search By Transaction Id "
        //  segmentControl.titles = ["Paid", "Unpaid"]
         self.navigationController?.setNavigationBarHidden(false, animated: false)
        viewPop.isHidden = true
       // self.navigationbarSetUp()
        self.load_MainData()
        self.tblhistory.contentInset = UIEdgeInsets(top: 10,left: 0,bottom: 0,right: 0)
        self.tblhistory.addSubview(self.refreshControl)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        create_Navigation_Bar_Mathod()
    }
   
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        unPaidArray_Search_Array = NSArray()
        paid_Search_Array = NSArray()
        unPaidArray.removeAllObjects()
        paidArray.removeAllObjects()
        
            load_MainData()
        refreshControl.endRefreshing()
    }
    var invoicePaidArr2 = [InvoiceSrtuctArr]()
    var invoiceUnPaidArr1 = [InvoiceSrtuctArr]()
    
    var invoicePaidArr2Search = [InvoiceSrtuctArr]()
    var invoiceUnPaidArr1Search = [InvoiceSrtuctArr]()
    
    
    var invoiceDic =  InvoiceStruct()
    func load_MainData()
    {
        let parameters : [String : String] = ["user_id":  (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)! ,"role":(SignUpDataClass.shareMngr.signUpData?.SignUdata!.role)!]
        
        print(parameters)
        
        //DPKWebOperation.operation_delegate = self
        //SHOW DPK Loader
        loader.showLoader()
        //Call WebService
        
        history_Bool = true
        //DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_getMyInvoice)
        
       // let parameters : [String : String] = ["artist_id": GlobalVariables.sharedManager.user_id , "user_id":  GlobalVariables.sharedManager.user_id]
        
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getMyInvoice, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: InvoiceStruct.self  , completion : {(success, modelVal) -> Void in if success
        {
            print(modelVal!)
            self.invoiceDic = modelVal!
            self.invoicePaidArr2.removeAll()
            self.invoiceUnPaidArr1.removeAll()
            
            self.invoicePaidArr2Search.removeAll()
            self.invoiceUnPaidArr1Search.removeAll()
            
            for (_ , val ) in (self.invoiceDic.invoiceSrtuctArr?.enumerated())!
            {
                if val.payment_status == "1"
                {
                    self.invoicePaidArr2.append(val)
                   
                    
                }
                else
                {
                    
                     self.invoiceUnPaidArr1.append(val)
                }
            }
            self.invoicePaidArr2Search = self.invoicePaidArr2
            self.invoiceUnPaidArr1Search = self.invoiceUnPaidArr1
            
            self.lblnoDataFound.isHidden = true
            loader.hideLoader()
             self.tblhistory.reloadData()
        }
        else
        {
            self.lblnoDataFound.isHidden = false
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
             self.tblhistory.reloadData()
            
            }
        })
        
    }
    
   
    let left_B = UIButton()
    let right_B = UIButton()
    func create_Navigation_Bar_Mathod()
    {
        if let image : UIImage = UIImage(named: "menu")
        {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
            
        }
        
        left_B.addTarget(self, action: #selector(self.left_Mathod_Action(_:)), for: .touchUpInside)
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "menu"), left_title_Str: nil, right_B_Img:nil, right_title_Str: nil, title_Str: "Invoice" , hidden_Nav: false, left_Button: left_B , right_Button: nil)
        
    }
    
    @IBAction func left_Mathod_Action( _ sender : UIButton!)
    {
        if let image : UIImage = UIImage(named: "menu")
        {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
        }
        SJSwiftSideMenuController.toggleLeftSideMenu()
    }
    
   
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sendertagForSelection == 0
        {
             return self.invoicePaidArr2.count
        }
        else
        {
            return self.invoiceUnPaidArr1.count
        }
        
       
        
      /*  if sendertagForSelection == 0{ //paid
            if  search_Bol ==  true
            {
                return paid_Search_Array.count
            }
            else
            {
                return paidArray.count
            }
        }
        else{ //UNpaid
            if  search_Bol ==  true
            {
                return unPaidArray_Search_Array.count
            }
            else
            {
                return unPaidArray.count
            }
        }*/
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell:HistoryVCCell = tableView.dequeueReusableCell(withIdentifier: "HistoryVCCell", for: indexPath) as! HistoryVCCell
        
        cell.payButton.isHidden =  true
        cell.payViewHeight.constant = 0
        if sendertagForSelection == 0{
            if  self.invoicePaidArr2.count > indexPath.row
            {
                let dic = self.invoicePaidArr2[indexPath.row]
                let  getPaymentFlag:String = dic.flag!
                let payment_type:String = dic.payment_type!
                if getPaymentFlag == "0"{
                    cell.btnview.setTitle(" paid ", for: .normal)
                    cell.btnview.backgroundColor = UIColor.orange
                }else{
                    if payment_type  == "0"{ //online
                        cell.btnview.setTitle("  Paid  ", for: .normal)
                    }else{
                        cell.btnview.setTitle("  Paid  ", for: .normal)
                    }
                    cell.btnview.backgroundColor = UIColor(red: 87/255, green: 153/255, blue: 35/255, alpha: 1)
                }
                if (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)! == dic.artist_id
                {
                    if let userImg = dic.userImage 
                    {
                        
                        cell.imgProfile.sd_setImage(with: URL(string: userImg), placeholderImage: UIImage(named: "profile"))
                        
                    }
                    //Set image
                    cell.lblName.text = dic.userName?.capitalized
                }
                else if (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)! == dic.user_id
                {
                    if let image_url = dic.userImage
                    {
                        if let url = URL(string: image_url)
                        {
                            cell.imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "profile"))
                        }
                    }
                    cell.lblName.text = dic.artistName?.capitalized
                }
                
                cell.lblprice.text = dic.currency_type! + " " + dic.final_amount!
                cell.lblservice.text = "Invoice Id # \(dic.invoice_id!)"
                
                //String To date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard let date = dateFormatter.date(from: (dic.booking_date!)) else {
                    fatalError("ERROR: Date conversion failed due to mismatched format.")
                }
                //Date to String
                dateFormatter.dateFormat = "d MMM, yyyy"
                let strDate:String = dateFormatter.string(from: date)
                
                // use date constant here
                
                cell.lbldate.text = strDate
                cell.lblservicetype1.text = (dic.categoryName!).uppercased()
                cell.lblservicetype.text = (dic.categoryName!).uppercased()
                cell.btnreport.tag = indexPath.row
                cell.btnreport.addTarget(self, action:  #selector(self.open_IssueView_Action(sender:)), for: .touchUpInside)
                let workingMin:String = dic.working_min!
                
                cell.lbldate.text = timeStamp_Str_Mathod(timeSt: dic.created_at!)
                
                
                dateFormatter.dateFormat = "mm:ss"
                let dateObj = dateFormatter.date(from: workingMin)
                if dateObj == nil{
                    
                }
                else{
                    dateFormatter.dateFormat = "HH:mm:ss"
                    cell.lblDuration.text = "DURATION " +  (dateFormatter.string(from: dateObj!))
                }
                
            }
            
        }
            
        else
        {
            cell.payButton.isHidden =  false
            cell.payViewHeight.constant = 50
            cell.payButton.tag = indexPath.row
            cell.payButton.addTarget(self, action: #selector(self.payAction(_:)), for: .touchUpInside)
            
            if self.invoiceUnPaidArr1.count > indexPath.row
            {
                let dic = self.invoiceUnPaidArr1[indexPath.row]
                
                let  getPaymentFlag:String = dic.flag!
                let payment_type:String = dic.payment_type!
                if getPaymentFlag == "0"{
                    cell.btnview.setTitle(" Unpaid ", for: .normal)
                    cell.btnview.backgroundColor = UIColor.orange
                }else{
                    if payment_type  == "0"{ //online
                        cell.btnview.setTitle(" Paid cash ", for: .normal)
                    }else{
                        cell.btnview.setTitle(" Paid online ", for: .normal)
                    }
                    cell.btnview.backgroundColor = UIColor(red: 87/255, green: 153/255, blue: 35/255, alpha: 1)
                }
                if (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)! == dic.artist_id
                {
                    if let userImg = dic.userImage
                    {
                         cell.imgProfile.sd_setImage(with: URL(string: userImg), placeholderImage: UIImage(named: "profile"))
                        
                    }
                    //Set image
                    cell.lblName.text = dic.userName?.capitalized
                }
                else if (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)! == dic.user_id
                {
                    if let image_url = dic.userImage
                    {
                        if let url = URL(string: image_url)
                        {
                            cell.imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "profile"))
                            
                        }
                    }
                    cell.lblName.text = dic.artistName?.capitalized
                }
                
                cell.lblprice.text = dic.currency_type! + " " + dic.final_amount!
                cell.lblservice.text = "Invoice Id # \(dic.invoice_id!)"
                
                //String To date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard let date = dateFormatter.date(from: (dic.booking_date!)) else {
                    fatalError("ERROR: Date conversion failed due to mismatched format.")
                }
                //Date to String
                dateFormatter.dateFormat = "d MMM, yyyy"
                let strDate:String = dateFormatter.string(from: date)
                
                // use date constant here
                
                cell.lbldate.text = strDate
                cell.lblservicetype1.text = (dic.categoryName!).uppercased()
                cell.lblservicetype.text = (dic.categoryName!).uppercased()
                //cell.btnreport.removeTarget(self, action:  #selector(self.open_IssueView_Action(sender:)), for: .touchUpInside)
                
              //  cell.btnreport.setTitle("Edit Invoice", for: .normal)
                cell.btnreport.tag = indexPath.row
                cell.btnreport.addTarget(self, action:  #selector(self.open_IssueView_Action(sender:)), for: .touchUpInside)
                
                
                cell.lbldate.text = timeStamp_Str_Mathod(timeSt: dic.created_at!)
                
                let workingMin : String = dic.working_min!
                
                dateFormatter.dateFormat = "mm:ss"
                let dateObj = dateFormatter.date(from: workingMin)
                if dateObj == nil{
                    
                }
                else{
                    dateFormatter.dateFormat = "HH:mm:ss"
                    cell.lblDuration.text = "DURATION " +  (dateFormatter.string(from: dateObj!))
                }
                
            }
        }
            return cell
    }
    
    
    //MARK: - pay Action
    @IBAction func payAction(_ sender: UIButton)
    {
        if sendertagForSelection == 0
        {
            
        }
        else
        {
            if self.invoiceUnPaidArr1.count > sender.tag
            {
                let dic = self.invoiceUnPaidArr1[sender.tag]
                
                let work_Com_VC : Work_Compeleted_Payment_VCont  = Work_Compeleted_Payment_VCont.viewController()
                
                    if let invId =  dic.invoice_id , let arid =  dic.artist_id
                    {
                        work_Com_VC.finished_Booking_Dic.artist_id      = arid
                        work_Com_VC.finished_Booking_Dic.invoice_id     = invId
                        work_Com_VC.finished_Booking_Dic.total_amount   = dic.final_amount ?? ""
                        work_Com_VC.finished_Booking_Dic.address        = dic.address ?? ""
                        work_Com_VC.finished_Booking_Dic.ArtistName     = dic.artistName ?? ""
                        work_Com_VC.finished_Booking_Dic.categoryName   = dic.categoryName ?? ""
                        work_Com_VC.finished_Booking_Dic.artistImage    = dic.artistImage ?? ""
                       
                        self.navigationController?.pushViewController(work_Com_VC, animated: true)
                    }
                    
                    
               
               
            }
            
        }
        
        
        //let dic =  finished_BookingDic.finished_Booking_Arr[sender.tag]
      
        
        
    }
    

    @IBAction  func open_Edit_Action(sender : UIButton!)
    {
        //viewPop.isHidden = false
       /* if let invoiceVC : InvoiceEditVViewController = self.storyboard?.instantiateViewController(withIdentifier: "InvoiceEditVViewController") as? InvoiceEditVViewController
        {
            invoiceVC.invoiceDelegate = self
            
            if sendertagForSelection == 0{
                
                
                if  self.invoicePaidArr2.count > sender.tag
                {
                    
                    
                    let dic = self.invoicePaidArr2[sender.tag]
                    invoiceVC.invoicePaid =  dic
                    
                }
                
            }
            else
            {
                if self.invoiceUnPaidArr1.count > sender.tag
                {
                    let dic = self.invoiceUnPaidArr1[sender.tag]
                    invoiceVC.invoicePaid =  dic
                }
                
            }
            
            
            
            self.navigationController?.pushViewController(invoiceVC, animated: true)//.present(invoiceVC, animated: true)
        }*/
    }
    
    
    

    @IBAction  func open_IssueView_Action(sender : UIButton!)
    {
        //viewPop.isHidden = false
        if let invoiceVC : InvoiceViewController = InvoiceViewController.viewController()
        {
            if sendertagForSelection == 0{
                
                
                if  self.invoicePaidArr2.count > sender.tag
                {
                    
                    
                    let dic = self.invoicePaidArr2[sender.tag]
                    invoiceVC.invoicePaid =  dic
                    
                }
                
            }
            else
            {
                if self.invoiceUnPaidArr1.count > sender.tag
                {
                    let dic = self.invoiceUnPaidArr1[sender.tag]
                    invoiceVC.invoicePaid =  dic
                }
                
            }
            
            
         
            self.navigationController?.present(invoiceVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        tableView.estimatedRowHeight = 300
        
        tableView.rowHeight = UITableView.automaticDimension
            return tableView.rowHeight
    }

    //MARK: - Add issue view Action
    @IBAction func submin_Issue_Action(_ sender: UIButton)
    {
        
        let val_dic : NSDictionary  =  history_Array[sender.tag] as! NSDictionary
        //let user_name = (val_dic["userName"] as! String)
        let artist_name = (val_dic["ArtistName"] as! String)
        let artist_SERVICE = "SERVICE # \(val_dic["invoice_id"] as! String)"
        
        let issue_Str = "Hello "+"\(artist_name)"+"here and my "+"SERVICE # \(artist_SERVICE)"+"  is sxecgrt  and issue is :- "+"\(self.issue_TF.text!)"
        
        let parameters : [String : String] = ["user_id" :(SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!,"reason" :issue_Str]
        print(parameters)
        
        
        strApiFlag = "issue_Data"
        
    
        loader.showLoader()
       
        self.view.endEditing(true)
        
        viewPop.isHidden = true
    }
    
    @IBAction func cancel_Issue_View(_ sender: UIButton)
    {
        if sender.tag == 101
        {
            self.view.endEditing(true)
        
        }
        else
        {
            self.view.endEditing(true)
           
            viewPop.isHidden = true
        }
        
        
    }
    
}

extension HistoryVC
{
    @IBAction func book_Finished_Seg_Mathod(segVal : UISegmentedControl)
    {
        if segVal.selectedSegmentIndex == 0
        {
            print("paid")
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
            self.search_Bol = false
            sendertagForSelection = 0
            tblhistory.reloadData()
        }
        else if segVal.selectedSegmentIndex == 1
        {
            print("unpaid")
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
            self.search_Bol = false
            sendertagForSelection = 1
            tblhistory.reloadData()
            
        }
    }

    
   
}

extension HistoryVC  : UISearchBarDelegate
{
    
    // MARK: - SEARCH BAR This method updates filteredData based on the text in the Search Box
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
        
        
        if sendertagForSelection == 0{
            if searchText.count == 0
            {
                
                self.invoicePaidArr2     =  self.invoicePaidArr2Search
              
                
                DispatchQueue.main.async {
                    self.tblhistory.reloadData()
                }
            }
            else if searchText.count >= 1
            {
                
                
                print(searchText.count)
                let predicate=NSPredicate(format: "SELF."+"\(search_By_Predicate)"+" CONTAINS[cd] %@", searchText)
                
                print(predicate)
                
                
                
                self.invoicePaidArr2 = self.invoicePaidArr2Search.filter({( Obj : InvoiceSrtuctArr) -> Bool in
                    
                    
                    return (Obj.invoice_id?.lowercased().contains(searchText.lowercased()))! ;
                })
                
                DispatchQueue.main.async {
                    self.tblhistory.reloadData()
                }
                
                
            }
            
        }
        else
        {
            if searchText.count == 0
            {
                
                self.invoiceUnPaidArr1   =  self.invoiceUnPaidArr1Search
                
                
                
                
                
                
                DispatchQueue.main.async {
                    self.tblhistory.reloadData()
                }
            }
            else if searchText.count >= 1
            {
                
                
                print(searchText.count)
                let predicate=NSPredicate(format: "SELF."+"\(search_By_Predicate)"+" CONTAINS[cd] %@", searchText)
                
                print(predicate)
                
                self.invoiceUnPaidArr1 = self.invoiceUnPaidArr1Search.filter({( Obj : InvoiceSrtuctArr) -> Bool in
                    
                    
                    return (Obj.invoice_id?.lowercased().contains(searchText.lowercased()))! ;                })
                
                DispatchQueue.main.async {
                    self.tblhistory.reloadData()
                }
                
                
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
        
       /// load_Table_Search()
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
        self.invoicePaidArr2     =  self.invoicePaidArr2Search
        self.invoiceUnPaidArr1   =  self.invoiceUnPaidArr1Search
        
        DispatchQueue.main.async {
            self.tblhistory.reloadData()
        }
    }
    
}

/*extension HistoryVC  : updateMathodInvoice
{
    func updateMathod() {
        unPaidArray_Search_Array = NSArray()
        paid_Search_Array = NSArray()
        unPaidArray.removeAllObjects()
        paidArray.removeAllObjects()
        
        load_MainData()
    }
    
    
}*/
/*
 // This method updates filteredData based on the text in the Search Box
 func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
 
 search_Bol = true
 print(searchText)
 if sendertagForSelection == 0{ //paid
 let predicate=NSPredicate(format: "SELF.invoice_id CONTAINS[cd] %@", searchText)
 paid_Search_Array  = paidArray.filtered(using: predicate)  as! NSArray
 
 tblhistory.reloadData()
 }
 else{
 let predicate=NSPredicate(format: "SELF.invoice_id CONTAINS[cd] %@", searchText)
 unPaidArray_Search_Array  = unPaidArray.filtered(using: predicate) as! NSArray
 
 tblhistory.reloadData()
 }
 
 }
 func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
 self.searchBar.showsCancelButton = true
 self.search_Bol = true
 }
 
 func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
 searchBar.showsCancelButton = false
 searchBar.text = ""
 searchBar.resignFirstResponder()
 self.search_Bol = false
 unPaidArray_Search_Array = NSArray()
 paid_Search_Array = NSArray()
 unPaidArray.removeAllObjects()
 paidArray.removeAllObjects()
 self.load_MainData()
 
 }

 //MARK:- Web Service Response Delegate
 /*@objc func callBackSuccessResponse(dictResponse: NSDictionary) {
 print(dictResponse)
 lblnoDataFound.isHidden = true
 tblhistory.isHidden = false
 searchBar.isHidden = false
 // segmentControl.isHidden = false
 loader.hideLoader()
 
 if dictResponse.count != 0
 {
 if  dictResponse["status"] as! NSNumber == 1
 {
 if history_Bool == true
 {
 if dictResponse["data"] != nil
 {
 let check_get : NSArray = (dictResponse["data"] as! NSArray)
 history_Array = check_get as NSArray
 loader.hideLoader()
 history_Bool = false
 for i in 0..<history_Array.count{
 let dict:NSDictionary = history_Array.object(at: i) as! NSDictionary
 var  getPaymentFlag:String = dict.value(forKey: "flag") as! String
 if getPaymentFlag == "0"{  //payNow
 
 unPaidArray.add(dict)
 
 }else{
 paidArray.add(dict)
 }
 }
 tblhistory.reloadData()
 }
 
 }
 if strApiFlag == "issue_Data"
 {
 loader.hideLoader()
 Alert.show(vc: self, titleStr: "Message", messageStr:(dictResponse["message"] as? String)!)
 }
 }
 else
 {
 //Alert Message for API any error
 Alert.show(vc: self, titleStr: "Message", messageStr: (dictResponse["message"] as! NSString) as String)
 loader.hideLoader()
 }
 }
 }*/
 
 /* @objc func callBackFailResponse(dictResponse: NSDictionary)
 {
 print(dictResponse)
 //SHOW DPK Loader
 loader.hideLoader()
 lblnoDataFound.isHidden = false
 searchBar.isHidden = true
 tblhistory.isHidden = true
 //   segmentControl.isHidden = true
 //Alert Message for API Fail
 // Alert.show(vc: self, titleStr: "Message", messageStr: (dictResponse["message"] as! NSString) as String)
 }*/
 */
