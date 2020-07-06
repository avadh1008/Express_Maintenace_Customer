
//
//  BookingViewController.swift
//  FabCustomer
//
//  Created by Apple on 02/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit


class BookingViewController: UIViewController {
    
    class func viewController() -> BookingViewController {
        return "Main".viewController("BookingViewController") as! BookingViewController
    }
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    @IBOutlet weak var searchBar    :       UISearchBar!
    @IBOutlet weak var LBLNODATA    :       UILabel!
    @IBOutlet weak var tblBooking   :       UITableView!
    
    var  current_booking_Dic        = Get_current_booking_struct()
    var  current_booking_Dic_Search = Get_current_booking_struct()
    
    
    var search_By_Predicate  =  "artistName"
    var comp_Persentage = 0.0
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.init(red: 82.0/255.0, green: 207.0/255.0, blue: 154.0/255.0, alpha: 1.0)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.placeholder = "Search By Artist"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.loadBookingFromServer()
        self.tblBooking.addSubview(self.refreshControl)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationbarSetUp()
        self.loadBookingFromServer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func navigationbarSetUp()
    {
        
        if let image : UIImage = UIImage(named: "menu")  {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
            //  SJSwiftSideMenuController .showRightMenuNavigationBarButton(image: image)
        }
        let image = UIImage(named: "Header_bar")
        self.navigationController?.navigationBar.setBackgroundImage(image,for: .default)
        
        self.navigationItem.title = self.defaultLocalizer.stringForKey(key:"My Bookings")
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationItem.setHidesBackButton(true, animated:false)
        
        //Bar Left Button
        let btnmenu = UIButton(type: .custom)
        btnmenu.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        btnmenu.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        btnmenu.addTarget(self, action: #selector(BookingViewController.left_Menu(_:)), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btnmenu)
        
        self.navigationItem.setLeftBarButtonItems([item1], animated: true)
        
        
    }
    
    @IBAction func left_Menu(_ sender : UIButton!)
    {
        
        self.view.endEditing(true)
        if let image : UIImage = UIImage(named: "menu") {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool:true)
        }
          SJSwiftSideMenuController.toggleLeftSideMenu()
      
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return  self.current_booking_Dic.current_booking.count
        
       
        
    }
    
    // MARK:- payNow n
    @IBAction func payNow_Action(_ sender: UIButton!) {
        
        
        
        let dic = self.current_booking_Dic.current_booking[sender.tag]
        
        let work_Com_VC : Work_Compeleted_Payment_VCont  = Work_Compeleted_Payment_VCont.viewController()
        if let dicw = dic.invoiceDic
        {
            work_Com_VC.finished_Booking_Dic =  dicw
            self.navigationController?.pushViewController(work_Com_VC, animated: true)

            
        }
        
        
        
    }
    
    @objc func finishJob(sender: UIButton) {
        
        
        
    }
    // MARK:- cancel
    @IBAction func viewInvoice_Action(_ sender: UIButton!) {
        let val_dic = self.current_booking_Dic.current_booking[sender.tag]
        //viewPop.isHidden = false
        if let invoiceVC : InvoiceViewController = InvoiceViewController.viewController()
        {
            if val_dic.invoiceDic != nil
            {
                invoiceVC.current_booking   =  val_dic
                self.navigationController?.present(invoiceVC, animated: true)
            }
            
        }
    }
    
    // MARK:- cancel
    @IBAction func cancel_Booking_Action(_ sender: UIButton!) {
        
        
        Alert.alert_PopMathod(vc: self, title: Alert.msg, message_Str: Alert.msg_finish_booking, action_Title: ["Ok" , "Cancel"], action_Style: [.default,.cancel] , action: [
            
            { Ok in
                print("Ok")
                
                
                let dic = self.current_booking_Dic.current_booking[sender.tag]
                
                
               
                let parameters : [String : String] = ["user_id":GlobalVariables.sharedManager.user_id  , "booking_id":dic.id, "decline_by" : Constant.USER_ROLL , "decline_reason":"reason"]
                
                Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_decline_booking, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
                {
                    
                    GlobalVariables.sharedManager.get_Status = modelVal!
                    Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                    self.loadBookingFromServer()
                    loader.hideLoader()
                    
                }
                else
                {
                    Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                    loader.hideLoader()
                    }
                })
                
                
                
                
            },
            { Cancel in
                print("Cancel")
                
            }
            ]
            
            
        )
        
        
        
    }
    
    
    
    @objc func bookingDecline(sender: UIButton){
        
        
        
        
    }
    
    
    @objc func bookingDecline2(sender: UIButton){
        
        
        
    }
    
    func loadBookingFromServer(){
        
        
        let parameters : [String : String] = ["user_id" :GlobalVariables.sharedManager.user_id]
        print(parameters)
        //   DPKWebOperation.operation_delegate = self
        //SHOW DPK Loader
        loader.showLoader()
        //Call WebService
        //   DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_getMyCurrentBookingUser)
        
        
        //   let parameters : [String : String] = ["user_id":"self.globel_Var.user_ID"]
        
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getMyCurrentBookingUser, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_current_booking_struct.self  , completion : {(success, modelVal) -> Void in if success
        {
            self.current_booking_Dic  = modelVal!
            self.current_booking_Dic_Search  = modelVal!
            self.tblBooking.reloadData()
            loader.hideLoader()
        }
        else
        {
            //Alert.showMiddleToast(message: self.globel_Var.get_Status.message, view_VC: self)
            self.tblBooking.reloadData()
            loader.hideLoader()
            
            
            }
        })
    }
    
   
    
    @objc func viewMap(sender: UIButton){
        
        
    }
    @objc func viewMapSECOND(sender: UIButton){
      
    }
    @objc func viewMapTHIRD(sender: UIButton){
       
    }
   
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //Call WS
        tblBooking.reloadData()
        self.loadBookingFromServer()
        refreshControl.endRefreshing()
    }
    
}

extension  BookingViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let val_dic = self.current_booking_Dic.current_booking[indexPath.row]
        
        
        
        let cellLast:FirstCellTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "FirstCellTableViewCell", for: indexPath) as! FirstCellTableViewCell
        
        cellLast.lblCatName.text = val_dic.category_name.uppercased()
        cellLast.lblName.text = "Booking With " + val_dic.artistName
        
        cellLast.date_label.text = val_dic.booking_date + " "  + val_dic.booking_time
        
        cellLast.address_label.text = val_dic.artistLocation //btnAddress.setTitle(" "+address, for: .normal)
        cellLast.cancel_Pay_Button.tag = indexPath.row
        
        cellLast.cancel_Pay_Button.removeTarget(self, action: #selector(self.cancel_Booking_Action(_:)), for: .touchUpInside)
        
        
        cellLast.cancel_Pay_Button.removeTarget(self, action: #selector(self.payNow_Action(_:)), for: .touchUpInside)
        
        cellLast.pay_label.text  = "  \(val_dic.currency_type) \(val_dic.price) "
        cellLast.payResponse_label.text  = " Hey, for this work aritst will take \(val_dic.currency_type) \(val_dic.price) for this booking "
        
        comp_Persentage = Double(val_dic.completePercentages)
        let cap_Per = Int(comp_Persentage)
        
        cellLast.btnPercentageComplete.setTitle(" "+"\(String(cap_Per))"+self.defaultLocalizer.stringForKey(key:" % Completion"), for: .normal)
        cellLast.btnJobComplete.setTitle(" "+"\(String(val_dic.jobDone))"+self.defaultLocalizer.stringForKey(key:" Jobs Completed"), for: .normal)
        
       cellLast.imgeArtist.sd_setImage(with: URL(string:val_dic.artistImage ), placeholderImage: #imageLiteral(resourceName: "profile"))
        cellLast.imgeArtist.layer.cornerRadius = cellLast.imgeArtist.frame.width / 2;
        cellLast.imgeArtist.layer.masksToBounds = true;
        
        cellLast.cancel_Pay_ButtonConstraint.constant = 50
        
        //0  live booking 3  job
        
        if val_dic.invoiceDic == nil
        {
            cellLast.viewInvoice_Button.isHidden = true
            cellLast.viewInvoice_Height.constant = 0
        }
        else
        {
            cellLast.viewInvoice_Button.isHidden = false
            cellLast.viewInvoice_Height.constant = 45
            cellLast.viewInvoice_Button.tag = indexPath.row
            cellLast.viewInvoice_Button.addTarget(self, action: #selector(self.viewInvoice_Action(_:)), for: .touchUpInside)
            
        }
        
        
        
        if  val_dic.booking_type == "0" ||  val_dic.booking_type == "3" ||  val_dic.booking_type == "2"
        {
            
            if val_dic.booking_flag == "0"
            {
                cellLast.response_label.text = "Waiting for artist response"
                cellLast.cancel_Pay_View.isHidden = false
                cellLast.cancel_Pay_Button.setTitle("Cancel Booking", for: .normal)
                cellLast.cancel_Pay_Button.addTarget(self, action: #selector(self.cancel_Booking_Action(_:)), for: .touchUpInside)
            }
            if val_dic.booking_flag == "1"
            {
                cellLast.response_label.text = "Waiting for artist response"
                cellLast.cancel_Pay_View.isHidden = false
                cellLast.cancel_Pay_Button.setTitle("Cancel Booking", for: .normal)
                cellLast.cancel_Pay_Button.addTarget(self, action: #selector(self.cancel_Booking_Action(_:)), for: .touchUpInside)
            }
            else if val_dic.booking_flag == "2"
            {
                cellLast.response_label.text = "Request accepted by artist"
                cellLast.cancel_Pay_View.isHidden = true
                
                cellLast.cancel_Pay_ButtonConstraint.constant = 0
                
            }
            else if val_dic.booking_flag == "3"
            {
                cellLast.response_label.text = "Your work in progress"
                cellLast.cancel_Pay_View.isHidden = true
                
                cellLast.lblTimer.isHidden = false
                let min = val_dic.working_min
                
                cellLast.stopTimer()
                cellLast.counter = Double(min*60)
                cellLast.runTimer()
            }
            else if val_dic.booking_flag == "4"
            {
                cellLast.response_label.text = "Invoice Generated"
                
                if let dicw = val_dic.invoiceDic
                {
                    
                    if dicw.flag == "1"
                    {
                        cellLast.response_label.text = "Invoice Paid"
                        cellLast.cancel_Pay_View.isHidden = true
                        cellLast.lblTimer.isHidden = true
                        cellLast.cancel_Pay_ButtonConstraint.constant = 0
                    }
                    else if dicw.flag == "0"
                    {
                        
                        cellLast.cancel_Pay_View.isHidden = false
                        cellLast.lblTimer.isHidden = true
                        cellLast.cancel_Pay_Button.setTitle("Pay Now", for: .normal)
                        cellLast.cancel_Pay_Button.addTarget(self, action: #selector(self.payNow_Action(_:)), for: .touchUpInside)
                        
                    }
                }
                
                
                
            }
            
        }
        
        return cellLast
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        return tableView.rowHeight
        
        
    }
    

}

extension BookingViewController  : UISearchBarDelegate
{
    
    // MARK: - SEARCH BAR This method updates filteredData based on the text in the Search Box
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
        
        if searchText.count == 0
        {
            self.current_booking_Dic.current_booking  = self.current_booking_Dic_Search.current_booking
            
            DispatchQueue.main.async {
                self.tblBooking.reloadData()
            }
        }
        else if searchText.count >= 1
        {
            print(searchText.count)
            //let predicate=NSPredicate(format: "SELF."+"\(search_By_Predicate)"+" CONTAINS[cd] %@", searchText)
            
            self.current_booking_Dic.current_booking = self.current_booking_Dic_Search.current_booking.filter({( job_Obj : Get_current_booking_Data_Struct) -> Bool in
                
                print(job_Obj.artistName)
                return job_Obj.artistName.lowercased().contains(searchText.lowercased())
                
            })
            
            DispatchQueue.main.async {
                self.tblBooking.reloadData()
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    
    func load_Table_Search()
    {
        self.current_booking_Dic.current_booking  = self.current_booking_Dic_Search.current_booking
        
        DispatchQueue.main.async {
            self.tblBooking.reloadData()
        }
    }
    
}
