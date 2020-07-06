//
//  Post_Job_ViewController.swift
//  FabCustomer
//
//  Created by Samyotech on 24/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//


import UIKit
import DropDown

import GoogleMaps
import GooglePlaces
import GooglePlacePicker

protocol updateJobsAddDelegate {
   func updateJobsAdd()
}


////  post_job //  user_id title description category_id address lati longi avtar
class Post_Job_ViewController: UIViewController {
    
    class func viewController() -> Post_Job_ViewController {
        return "Main".viewController("Post_Job_ViewController") as! Post_Job_ViewController
    }
    

    var delegate : updateJobsAddDelegate?
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    @IBOutlet weak var txtPrice: UITextField!
    let formatter = DateFormatter()
    @IBOutlet weak var date_time_Picker: UIDatePicker!
    @IBOutlet weak var date_View: UIView!
    
    var index_Val : Int?
    var edit_Bool : Bool? = false
    @IBOutlet weak var address_TV: UITextView!
    @IBOutlet weak var desc_TV: UITextView!
    @IBOutlet weak var title_TF: UITextField!
    
    @IBOutlet weak var job_ImaveV: UIImageView!
    
    var lattitudeStr:String = ""
    var longitudeStr:String = ""
    
    let left_B = UIButton()
    let right_B = UIButton()
    
    var media_img_st : String? = nil
    var image_Send : UIImage? = nil
    var cat_id : String?
    @IBOutlet weak var dateLabel        :   UILabel!
    let globel_var  =  GlobalVariables.sharedManager
    
    @IBOutlet weak var drop_header: UIView!
    
    let cate_DropDown = DropDown()
    
    @IBOutlet weak var select_Category_Label : UILabel!
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.cate_DropDown
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        address_TV.delegate = self
        desc_TV.delegate = self
        title_TF.delegate = self
        
        if self.globel_var.all_Caegory_Arr.count > 0
        {
           
        }
        else
        {
            get_all_Caegory(api_Key : Constant.kTo_getAllCaegory)
        }
        
        
        
        
        let image : UIImage = UIImage(named: "menu")!
        SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
            //  SJSwiftSideMenuController .showRightMenuNavigationBarButton(image: image)
        
        
        
        
        
        
        if edit_Bool == true
        {
            load_Data_Mathod()
        }else
        {
             create_Navigation_Bar_Mathod(title_Str: "New Job")
        }
       
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.date_View.isHidden = true
        self.drop_Create_Mathod()
        
        txtPrice.keyboardType = .asciiCapableNumberPad
        
    }
    //MARK: - Load data for edit
    func load_Data_Mathod()
    { // edit_post_job
        
        if self.globel_var.all_job_Arr.count > index_Val!
        {
        let dic =  self.globel_var.all_job_Arr[index_Val!]
        select_Category_Label.text      = dic.category_name
        title_TF.text                   = dic.title
        desc_TV.text                    = dic.description
        globel_var.location_to_Edit     = dic.address
        address_TV.text                 = globel_var.location_to_Edit
        txtPrice.text = dic.price
        lattitudeStr                    = dic.lati
        longitudeStr                    = dic.longi
        job_ImaveV.sd_setImage(with: URL(string:dic.avtar ), placeholderImage: #imageLiteral(resourceName: "profile"))
        image_Send                      = job_ImaveV.image
        cat_id                          = dic.category_id
        dateLabel.text = dic.created_at
        create_Navigation_Bar_Mathod(title_Str: "Edit Job")
        media_img_st = "avtar"
            
        }
        
    }
    func create_Navigation_Bar_Mathod( title_Str  : String!)
    {
        
        left_B.addTarget(self, action: #selector(self.back_Mathod_Action(_:)), for: .touchUpInside)
        
        right_B.addTarget(self, action: #selector(self.right_Mathod_Action(_:)), for: .touchUpInside)
        
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img: #imageLiteral(resourceName: "back2"), left_title_Str: nil, right_B_Img: nil, right_title_Str: defaultLocalizer.stringForKey(key:"Post"), title_Str: defaultLocalizer.stringForKey(key:title_Str) , hidden_Nav: false, left_Button: left_B, right_Button: right_B )
        
    }
    
    @IBAction func right_Mathod_Action( _ sender : UIButton!)
    {
        if edit_Bool == true
        {   if self.globel_var.all_job_Arr.count > index_Val!
            {
                let dic = self.globel_var.all_job_Arr[index_Val!]
                post_job(api_Key: Constant.kTo_edit_post_job, job_id: dic.job_id)
            }
            print("editPost")
        }
        else
        {
              print("addPoat")
            post_job(api_Key: Constant.POST_JOB_NEW, job_id: "")
        }
        
        
        
    }
    @IBAction func back_Mathod_Action( _ sender : UIButton!)
    {
        
        back_Mathod()
    }
    func back_Mathod()
    {
        let image : UIImage = UIImage(named: "menu")!
        SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Drop Selection for all
    @IBAction func Category_Mathod_Action( _ sender : UIButton!)
    {
        
        cate_DropDown.show()
    }
    func drop_Create_Mathod()
    {
        
        
        var pet_Type_Arr   =  [""]
        pet_Type_Arr.removeAll()
        for tem  in self.globel_var.all_Caegory_Arr
        {
            print(tem.id)
            pet_Type_Arr.append(tem.cat_name)
        }
        
        Drop_Down_Class.sharedInstance.setupChooseDropDown(vc: self, dropDown: cate_DropDown, drop_Header: drop_header, arrayOfDrop: pet_Type_Arr as NSArray) { (Drop_Connection_Result) in
            switch Drop_Connection_Result {
            case .success(let data): print(data)
            print(data)
            self.select_Category_Label.text = data.0
            if self.globel_var.all_Caegory_Arr.count > data.1
            {
                let val = self.globel_var.all_Caegory_Arr[data.1]
                
                self.cat_id = val.id
                
            }
            case .failure(let error): print(error)
            loader.hideLoader()
            self.select_Category_Label.text = self.defaultLocalizer.stringForKey(key:"Select Again")

              
            }
            
        }
        self.dropDowns.forEach { $0.dismissMode = .automatic }
        self.dropDowns.forEach { $0.direction = .bottom }
        Drop_Down_Class.sharedInstance.customizeDropDown(dropDowns: self.dropDowns)
    }
    
    
    func get_all_Caegory(api_Key : String!)
    {
        // artist_id  ///  get_all_job
        
        let parameters : [String : String] = ["user_id" :globel_var.user_id]
        
        Revoke_Service_Class.sharedInstance.getAllCaegory_Request(vc: self, dictPram: parameters, methodName: api_Key) { (success) in
            if success
            {
                print(self.globel_var.all_Caegory_Arr.count)
                if self.globel_var.all_Caegory_Arr.count > 0
                {
                   print(self.globel_var.all_Caegory_Arr)
                    
                    self.drop_Create_Mathod()
                }
                else
                {
                    self.drop_Create_Mathod()
                    
                }
               
            }
            else
            {
                self.drop_Create_Mathod()
            }
        }
        
    }
    ////  post_job //  user_id title description category_id address lati longi avtar
    //MARK: - post_job
    func post_job(api_Key : String! , job_id : String!)
    {
        
        
        
        if select_Category_Label.text?.isEmpty == true ||  select_Category_Label.text == "- Select Job Categories -" ||  select_Category_Label.text == "Job Categories" ||  select_Category_Label.text == "Select Again"
        {
            Alert.show(vc: self, titleStr: "Message", messageStr: self.defaultLocalizer.stringForKey(key:"Please select job category."))
            return
        }
        else if title_TF.text?.isEmpty == true
        {
            Alert.show(vc: self, titleStr: "Message", messageStr: self.defaultLocalizer.stringForKey(key:"Please enter job title.") )
            return
        }
        else if desc_TV.text?.isEmpty == true
        {
            Alert.show(vc: self, titleStr: "Message", messageStr: self.defaultLocalizer.stringForKey(key:"Please enter description."))
            return
        }
        else if txtPrice.text?.isEmpty == true
        {
            Alert.show(vc: self, titleStr: "Message", messageStr: self.defaultLocalizer.stringForKey(key:"Please enter price."))
            return
        }
        else if address_TV.text?.isEmpty == true
        {
            Alert.show(vc: self, titleStr: "Message", messageStr: self.defaultLocalizer.stringForKey(key:"Please select Address") )
            return
        }
        else if lattitudeStr.isEmpty == true || longitudeStr.isEmpty == true
        {
            Alert.show(vc: self, titleStr: "Message", messageStr: self.defaultLocalizer.stringForKey(key:"Please select Address again."))
            return
        }
        
        else if dateLabel.text?.isEmpty == true
        {
            Alert.show(vc: self, titleStr: "Message", messageStr: self.defaultLocalizer.stringForKey(key:"Please select date."))
            return
        }
        
        
      
        
        var parameters : [String : String] = [ "title":title_TF.text!, "description":desc_TV.text!, "category_id":cat_id!, "address":globel_var.location_to_Edit!, "lati":lattitudeStr, "longi":longitudeStr,"price":txtPrice.text! , "job_date" : dateLabel.text! ]
        if job_id != ""
        {
            parameters["job_id"] = job_id
        }
        else
        {
            parameters["user_id"] = globel_var.user_id
        }
        
        print(parameters)
       
      
        loader.showLoader()
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: api_Key, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            GlobalVariables.sharedManager.get_Status = modelVal!
            self.delegate?.updateJobsAdd()
            loader.hideLoader()
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            self.back_Mathod()
          
          
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })
       
        
    }
  
    // MARK:- Image Option
    @IBAction func image_Opt_Action(_ sender: AnyObject) {
        
        
    
        ImageAction.instance.cropFigureType = 1
        ImageAction.instance.cornerRadiousType = 30
        ImageAction.instance.showFullActionSheet(on: self){ (image) in
            self.image_Send = image
            self.media_img_st = "avtar"
            self.job_ImaveV.image =  image
        }
    }
    // MARK:- location Option
    @IBAction func get_Location_From_map(_ sender: UIButton)
    {
       let addressVc = Address_Picker_ViewController.viewController()
        addressVc.delegate = self
        self.navigationController?.pushViewController(addressVc, animated: false)
        
    }
    
    @IBAction func done_Cancel_Mathod(_ sender: UIButton!) {
        
        self.date_View.isHidden = true
        formatter.dateFormat = "E, MMM d, yyyy  h:mm a"//"dd MMM yyyy hh:mm a"
        dateLabel.text = formatter.string(from: date_time_Picker.date)
    }
    
    
    @IBAction func date_Time_Select_Action(_ sender: UIButton!) {
        
        self.view.endEditing(true)
        
        self.date_View.isHidden = false
        date_time_Picker.minimumDate = Date() //Calendar.current.date(bySettingHour : 8 , minute: 0, second: 0, of: Date())
        //  date_time_Picker.maximumDate = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())
        
    }

}

extension Post_Job_ViewController : UITextViewDelegate
{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
           
            return false
        }
        return true
    }
}
extension Post_Job_ViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


extension Post_Job_ViewController : AddressDelegate
{
    func updateAddress(address: String, lat: String, long: String) {
        address_TV.text = address
        globel_var.location_to_Edit = address
        lattitudeStr = lat
        longitudeStr = long
    }
    
  
    
    
}
