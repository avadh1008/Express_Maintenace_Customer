//
//  JobS_ViewCont.swift
//  FabCustomer
//
//  Created by Samyotech on 24/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class JobS_ViewCont: UIViewController {
    
    class func viewController() -> JobS_ViewCont {
        return "Main".viewController("JobS_ViewCont") as! JobS_ViewCont
    }
    
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    
    @IBOutlet weak var searchBarJob: UISearchBar!
    var search_By_Predicate  =  ""
    var val_job_Arr = [Get_all_job]() //   val_Breed_Arr
   
   
    @IBOutlet weak var total_Jobs_TableV  : UITableView!
    @IBOutlet weak var noJob_Label  : UILabel!
    let left_B = UIButton()
    let right_B = UIButton()

    let globel_var  =  GlobalVariables.sharedManager
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    var search_Bol : Bool = false
    var jobSearch_Array :  NSArray = NSArray()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        create_Navigation_Bar_Mathod()
         search_By_Predicate = defaultLocalizer.stringForKey(key:"title")
        searchBarJob.placeholder = defaultLocalizer.stringForKey(key:"Search By Title")
        total_Jobs_TableV.addSubview(refreshControl)
        
        Register_Nib_With_Delegate.sharedInstance.register_Mathod(vc: self, tableV_Name: total_Jobs_TableV, cell_Identity: "Jobs_TableVCell")
        
        self.globel_var.all_job_Arr.removeAll()
                get_all_job(api_Key: Constant.kTo_all_job_user)
        
        notificationMathod()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    get_all_job(api_Key: Constant.kTo_all_job_user)
        
        create_Navigation_Bar_Mathod()

    }
    
    func create_Navigation_Bar_Mathod()
    {
        
        
        left_B.addTarget(self, action: #selector(self.back_Mathod_Action(_:)), for: .touchUpInside)
        
        right_B.addTarget(self, action: #selector(self.right_Mathod_Action(_:)), for: .touchUpInside)
        
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img: #imageLiteral(resourceName: "menu"), left_title_Str: nil, right_B_Img: nil, right_title_Str: defaultLocalizer.stringForKey(key: "Post Job"), title_Str: defaultLocalizer.stringForKey(key: "Jobs"), hidden_Nav: false, left_Button: left_B, right_Button: right_B )
        
    }
    
    @IBAction func right_Mathod_Action( _ sender : UIButton!)
    {
        //Post_Job_ViewController
        let Post_VC : Post_Job_ViewController = Post_Job_ViewController.viewController()
        
        Post_VC.delegate = self
        self.navigationController?.pushViewController(Post_VC, animated: false)
    }
    
    @IBAction func back_Mathod_Action( _ sender : UIButton!)
    {
        self.navigationController?.popViewController(animated: true)
        
    }
 
    
    func get_all_job(api_Key : String!)
    {
        // artist_id  ///  get_all_job
        self.globel_var.all_job_Arr.removeAll()

        let parameters : [String : String] = ["user_id" :globel_var.user_id]
        
        Revoke_Service_Class.sharedInstance.get_all_job_Request(vc: self, dictPram: parameters, methodName: api_Key) { (success) in
            if success
            {
                print(self.globel_var.all_job_Arr.count)
                if self.globel_var.all_job_Arr.count > 0
                {
                    self.noJob_Label.isHidden = true
                    self.val_job_Arr = self.globel_var.all_job_Arr
                    self.searchBarJob.isHidden = false
                }
                else
                {
                    self.noJob_Label.isHidden = false
                    self.searchBarJob.isHidden = true
                }
                self.refreshControl.endRefreshing()
                self.total_Jobs_TableV.reloadData()
            }
            else
            {
                self.refreshControl.endRefreshing()
                if self.globel_var.all_job_Arr.count > 0
                {
                    self.noJob_Label.isHidden = true
                    self.searchBarJob.isHidden = false
                }
                else
                {
                    self.noJob_Label.isHidden = false
                    self.searchBarJob.isHidden = true
                }
                print(self.globel_var.all_job_Arr)
                self.refreshControl.endRefreshing()
                self.total_Jobs_TableV.reloadData()
            }
        }
        
    }
    
    func delete_job_Mathod(api_Key : String! ,  status_Val : String!, job_id : String! )
    {
        // artist_id  ///  get_all_job
        
        let parameters : [String : String] = ["job_id" : job_id  , "status":status_Val!]
       
        Revoke_Service_Class.sharedInstance.Update_Mathod_Request(vc: self, dictPram: parameters, methodName: api_Key) { (success) in
            if success
            {
                self.get_all_job(api_Key: Constant.kTo_all_job_user)
            }
            else
            {
                
            }
        }
        
    }
    
    func complete_job_Mathod(api_Key : String! , job_id : String! )
    {
        // artist_id  ///  get_all_job
        
        let parameters : [String : String] = ["job_id" : job_id  , "user_id":self.globel_var.user_id]
        
        Revoke_Service_Class.sharedInstance.Update_Mathod_Request(vc: self, dictPram: parameters, methodName: api_Key) { (success) in
            if success
            {
                self.get_all_job(api_Key: Constant.kTo_all_job_user)
            }
            else
            {
                
            }
        }
        
    }
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
         self.globel_var.all_job_Arr.removeAll()
         get_all_job(api_Key: Constant.kTo_all_job_user)
    }
    

}

extension JobS_ViewCont : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.globel_var.all_job_Arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : Jobs_TableVCell = tableView.dequeueReusableCell(withIdentifier: "Jobs_TableVCell", for: indexPath) as! Jobs_TableVCell
        let dic =  self.globel_var.all_job_Arr[indexPath.row]
        cell.name_Label.text        =   dic.title
        cell.job_id_Label.text      =   dic.job_id
        
        
        let date         =   dic.created_at
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dd = formatter.date(from: date)
        let myString = formatter.string(from: dd!)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd MMM YYYY"
        let myStringafd = formatter.string(from: yourDate!)
        cell.date_Label.text = myStringafd
        
        cell.dec_Label.text         =   dic.description
        cell.address_Label.text     =   dic.address
        cell.service_Label.text = dic.category_name
        cell.lblPrice.text =   dic.currency_symbol + " " + dic.price
        
        /*
         Feb_red
         Feb_green
         Feb_yello
         */
         cell.stuts_Label.layer.cornerRadius = 5
        cell.stuts_Label.clipsToBounds = true
        
        if dic.status == "0"
        {
            cell.stuts_Label.backgroundColor = Constant.KcolorYoga
             cell.stuts_Label.text =  "Open"
            cell.edit_View.isHidden = false
            cell.height_Constrent.constant = 40
        }
        else if  dic.status == "1"
        {
            cell.stuts_Label.backgroundColor = Constant.Feb_yello
            cell.stuts_Label.text =  "Confirm"
            cell.edit_View.isHidden = false
            cell.height_Constrent.constant = 40
        }
        else if  dic.status == "2"
        {
            cell.stuts_Label.backgroundColor = Constant.Feb_green
            cell.stuts_Label.text =  "Done "
            cell.edit_View.isHidden = true
            cell.height_Constrent.constant = 0
        }
        else if  dic.status == "3"
        {
            cell.stuts_Label.backgroundColor = Constant.Feb_red
            cell.stuts_Label.text =  "Reject"
            cell.edit_View.isHidden = true
            cell.height_Constrent.constant = 0
        }
        
        
        
        cell.delete_Button.tag      =   indexPath.row
        cell.edit_Button.tag      =   indexPath.row
        cell.btnMarkAsComplete.tag = indexPath.row
        
        
        cell.pro_ImgV.sd_setImage(with: URL(string:dic.avtar ), placeholderImage: #imageLiteral(resourceName: "profile"))
        
         cell.delete_Button.addTarget(self, action: #selector(self.delete_Mathod_Action(_:)), for: .touchUpInside)
        
        cell.edit_Button.addTarget(self, action: #selector(self.edit_Mathod_Action(_:)), for: .touchUpInside)
        cell.btnMarkAsComplete.addTarget(self, action: #selector(self.btnMarkAsCompleteAon(_:)), for: .touchUpInside)

        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        total_Jobs_TableV.estimatedRowHeight = 120
        total_Jobs_TableV.rowHeight = UITableView.automaticDimension
        return total_Jobs_TableV.rowHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let Appl_VC : Applied_VCont = Applied_VCont.viewController()
        let dic =  self.globel_var.all_job_Arr[indexPath.row]
        Appl_VC.job_id = dic.job_id
        self.navigationController?.pushViewController(Appl_VC, animated: true)
        
    }
    @objc func btnMarkAsCompleteAon(_ Sender : UIButton!){
        
        
        let alert = UIAlertController(title: Alert.kmsg, message: Alert.k_Job_Complete, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
            let dic =  self.globel_var.all_job_Arr[Sender.tag]
            self.complete_job_Mathod(api_Key: Constant.kTo_jobComplete, job_id: dic.job_id)
            
            
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
    @objc func edit_Mathod_Action(_ Sender : UIButton!)
    {
        let dic =  self.globel_var.all_job_Arr[Sender.tag]
        let is_edit = dic.is_edit
        if  is_edit == 0{
            let alert = UIAlertController(title: Alert.kmsg, message: defaultLocalizer.stringForKey(key:"You can't edit this job because Artist have applied already"), preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
                
                
            }
            // Add the actions
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }else{
            let Post_VC : Post_Job_ViewController = Post_Job_ViewController.viewController()
            Post_VC.index_Val =  Sender.tag
            Post_VC.edit_Bool = true
            self.navigationController?.pushViewController(Post_VC, animated: false)
        }
        
    
    }
    
    @objc func delete_Mathod_Action(_ Sender : UIButton!)
    {
        
        
        let alert = UIAlertController(title: Alert.kmsg, message: Alert.k_Job_Delete, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
           let dic =  self.globel_var.all_job_Arr[Sender.tag]
            self.delete_job_Mathod(api_Key: Constant.kTo_deletejob, status_Val: "4", job_id: dic.job_id)
            
            
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
    
    
}


extension JobS_ViewCont  : UISearchBarDelegate
{
    
    // MARK: - SEARCH BAR This method updates filteredData based on the text in the Search Box
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
        
        if searchText.count == 0
        {
            self.globel_var.all_job_Arr = self.val_job_Arr
            
            DispatchQueue.main.async {
                self.total_Jobs_TableV.reloadData()
            }
        }
        else if searchText.count >= 1
        {
            print(searchText.count)
            let predicate=NSPredicate(format: "SELF."+"\(search_By_Predicate)"+" CONTAINS[cd] %@", searchText)
            
            print(predicate)
            
            
            
            self.globel_var.all_job_Arr = val_job_Arr.filter({( job_Obj : Get_all_job) -> Bool in
                
                print(job_Obj.title)
                
                
                return job_Obj.title.lowercased().contains(searchText.lowercased())
            })
            
            DispatchQueue.main.async {
                self.total_Jobs_TableV.reloadData()
            }
            
            
        }
        
        
    }
    
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
       
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        load_Table_Search()
    }
    
    
    
    func load_Table_Search()
    {
        self.globel_var.all_job_Arr = self.val_job_Arr
        DispatchQueue.main.async {
            self.total_Jobs_TableV.reloadData()
        }
    }
    
}
extension JobS_ViewCont {
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
        get_all_job(api_Key: Constant.kTo_all_job_user)
        
    }
    
    @objc func sobStart10003(notfication: NSNotification)
    {
        get_all_job(api_Key: Constant.kTo_all_job_user)
        
    }
    
}
extension JobS_ViewCont : updateJobsAddDelegate {
    func updateJobsAdd() {
        get_all_job(api_Key: Constant.kTo_all_job_user)
    }
    
    
}


