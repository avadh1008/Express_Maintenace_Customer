import UIKit
//import SJSwiftSideMenuController

class SupportViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    class func viewController() -> SupportViewController {
        return "Main".viewController("SupportViewController") as! SupportViewController
    }
    
    
    var my_Tckt_Dic = My_Tckt_Struct()
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    @IBOutlet weak var viewPop: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleTF : UITextField!
    @IBOutlet weak var tblSupport : UITableView!
    let globel_variable = GlobalVariables.sharedManager
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = Constant.loder_Color_D
        return refreshControl
    }()
    
    //MARK:- Reloade :-
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
       self.get_Support_Data()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.get_Support_Data()
        self.tblSupport.addSubview(self.refreshControl)
        
        viewPop.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationbarSetUp()
       
    }
   
    func get_Support_Data()
    {
       
        let parameters : [String : String] = ["user_id" :(SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)! ]
        print(parameters)
      
     //   DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_getMyTicket)
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getMyTicket, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: My_Tckt_Struct.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            
            self.my_Tckt_Dic = modelVal!
            
            loader.hideLoader()
            self.tblSupport.reloadData()
            self.refreshControl.endRefreshing()
            
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })
    }
    
    func navigationbarSetUp() {
        //set naviggation backgroun image
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let image = UIImage(named: "Header_bar") as! UIImage
        self.navigationController?.navigationBar.setBackgroundImage(image,for: .default)
        
        navigationItem.title = defaultLocalizer.stringForKey(key: "Support")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let imgView = UIImageView()
        imgView.image = UIImage(named: "add64")
        imgView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        view.addSubview(imgView)
        let btnApply = UIButton(type: .custom)
        btnApply.backgroundColor = UIColor.clear
        //btnApply.setImage(UIImage(named: "add32"), for: .normal)
        btnApply.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        btnApply.addTarget(self, action: #selector(self.AdddReport), for: .touchUpInside)
        view.addSubview(btnApply)

        let item2 = UIBarButtonItem(customView: view)
        self.navigationItem.setRightBarButtonItems([item2], animated: true)
        navigationItem.title = defaultLocalizer.stringForKey(key: "Support")

    }

    
    @objc func AdddReport(){
        
        viewPop.isHidden = false
    }
    @IBAction func btnSubmitAction(_ sender: Any) {
        
        
        postReportServer()
    }
    @IBAction func btnClosePop(_ sender: Any) {
        self.view.endEditing(true)
        
        viewPop.isHidden = true
    }
    
   
    func postReportServer(){
        self.view.endEditing(true)
        
        if titleTF.text == ""
        {
            Alert.showMiddleToast(message: "Please Enter title.", view_VC: self)
            return ;
        }
        else if textView.text  == ""
        {
            Alert.showMiddleToast(message: "Please Enter description.", view_VC: self)
            return ;
        }
        
       
        let parameters : [String : String] = ["user_id" :(SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!,"reason" :titleTF.text! , "description":textView.text!]
        print(parameters)
        
      /*  DPKWebOperation.operation_delegate = self
        //SHOW DPK Loader
        loader.showLoader()
        //Call WebService
        
        
        DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_generateTicket)*/
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_generateTicket, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            
            self.titleTF .text  = ""
            self.textView.text = ""
            self.viewPop.isHidden = true
            self.get_Support_Data()
            loader.hideLoader()
             self.tblSupport.reloadData()
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return my_Tckt_Dic.my_Tckt_Arr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SupportTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SupportTableViewCell", for: indexPath) as! SupportTableViewCell
        if my_Tckt_Dic.my_Tckt_Arr.count > indexPath.row
        {
            let val_Dic  =  my_Tckt_Dic.my_Tckt_Arr[indexPath.row]
            
                cell.lblDesc.text = val_Dic.description
            
            
                cell.lblUserName.text = val_Dic.reason
            
            
            if let str =  val_Dic.status
            {
                if str == "0"{
                    cell.lblstatus.text = "Pending"
                }
               else if str == "1"{
                    cell.lblstatus.text = "Solve"
                }
                else
                {
                    cell.lblstatus.text = "Close"
                }
            }
            if let dateStr =  val_Dic.craeted_at
            {
                
                let strNs = NSString(string: dateStr)
                let interval: TimeInterval? = strNs.doubleValue
                let date_get = Date(timeIntervalSince1970: interval!)
                let format_time = DateFormatter()
                format_time.dateFormat = "yyyy-MM-dd"
                let date_Str_Com = format_time.string(from:date_get )
                print(date_Str_Com)
                let formatter_Time = DateFormatter()
                formatter_Time.dateFormat = "h:mm a"
                let date_Str_Time = formatter_Time.string(from:date_get)
                print(date_Str_Time)
                cell.lblDay.text = "\(date_Str_Com)"+" "+"\(date_Str_Time)"
                if  NSCalendar.current.isDateInToday(date_get )
                {
                    cell.lblDay.text = "Today"+" "+"\(date_Str_Time)"
                }
                if  NSCalendar.current.isDateInYesterday(date_get)
                {
                    cell.lblDay.text = "Yesterday"+" "+"\(date_Str_Time)"
                }
                
            
                
                
            }
        }
        
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tblSupport.estimatedRowHeight = 110
        tblSupport.rowHeight = UITableView.automaticDimension
        return  tblSupport.rowHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
         let val_dic  =  my_Tckt_Dic.my_Tckt_Arr[indexPath.row]
     
        let ch_VC:SupportChatViewController = SupportChatViewController.viewController()
        ch_VC.ticket_id = val_dic.id
        ch_VC.user_id = val_dic.user_id
        self.navigationController?.pushViewController(ch_VC, animated: false)
    }

    
    @objc func callBackFailResponse(dictResponse: NSDictionary) {
        print(dictResponse)
        //SHOW DPK Loader
        loader.hideLoader()
        
        //Alert Message for API Fail
        Alert.show(vc: self, titleStr: "Message", messageStr: (dictResponse["message"] as! NSString) as String)
    }
    
}

