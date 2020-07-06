
//
//  ProfileSettingViewController.swift
//  FabCustomer
//
//  Created by Samyotech on 20/03/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit
import GoogleMaps

class ProfileSettingViewController: UIViewController  ,UITextFieldDelegate ,    UITextViewDelegate{
    
    class func viewController() -> ProfileSettingViewController {
        return "Main".viewController("ProfileSettingViewController") as! ProfileSettingViewController
    }
    
    var delete_Image_Check = ""
    var profile_apdate_Dic : NSDictionary = NSDictionary()
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    @IBOutlet weak var picker_Show_View: UIView!
    var cell4:ProfileSettingTableViewCell  = ProfileSettingTableViewCell()
    @IBOutlet weak var gender_Picker: UIPickerView!
    var pickerData: [String] = [String]()
    
    
    @IBOutlet weak var maleButton           : UIButton!
    @IBOutlet weak var femaleButton         : UIButton!
    
    @IBOutlet weak var male_ImageV           : UIImageView!
    @IBOutlet weak var female_ImageV         : UIImageView!
    
    
    
    
    @IBOutlet weak var tblProfileSetting: UITableView!
    var image_Send:UIImage? = nil
    var parameters : [String : String]! = nil
    var save_PopUp_Action:Bool = false
    let globel_variable = GlobalVariables.sharedManager
    var Data_Bool : Bool = false
    var lattitudeStr:String = ""
    var longitudeStr:String = ""
    var address:String = ""
    var adderss_home_bol : Bool = false
    
    
    //MARK: - Personal address View Outlet
    
    @IBOutlet var personal_Add_VIew: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var last_nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobilNo_TF: UITextField!
    @IBOutlet weak var gendarTF: UITextField!
    var gender_Str = ""
    
    //MARK: - Password Change View Outlet
    
    @IBOutlet var password_change_VIew: UIView!
    
    @IBOutlet weak var old_Pas_TF: UITextField!
    @IBOutlet weak var new_Pas_TF: UITextField!
    @IBOutlet weak var con_Pas_TF: UITextField!
    
    //MARK: - set address VIwe Outlet
    
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameTF.delegate = self
        emailTF.delegate = self
        mobilNo_TF.delegate = self
        gendarTF.delegate = self
        old_Pas_TF.delegate = self
        new_Pas_TF.delegate = self
        con_Pas_TF.delegate = self
        
        emailTF.isUserInteractionEnabled = false
        self.picker_Show_View.isHidden = true
        
        self.navigationbarSetUp()
        // Connect data:
        // self.gender_Picker.delegate = self
        // self.gender_Picker.dataSource = self
        pickerData = ["Male", "Female"]
        
        //Add Popup views
        personal_Add_VIew.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(personal_Add_VIew)
        
        password_change_VIew.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(password_change_VIew)
        
        personal_Add_VIew.isHidden = true
        password_change_VIew.isHidden = true
        
        self.tblProfileSetting.dataSource = self
        self.tblProfileSetting.delegate = self
        self.get_Data()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        //        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillDisappear(animated)
    }
    
    //Hide Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when   'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        textField.endEditing(true)
        return true;
    }
    
    
    
    func get_Data()
    {
        if let emid = SignUpDataClass.shareMngr.signUpData?.SignUdata?.email_id
        {
            emailTF.text = emid
            nameTF.text = SignUpDataClass.shareMngr.signUpData?.SignUdata?.name
            mobilNo_TF.text = SignUpDataClass.shareMngr.signUpData?.SignUdata?.mobile
            last_nameTF.text = SignUpDataClass.shareMngr.signUpData?.SignUdata?.name
        }
        
        if SignUpDataClass.shareMngr.signUpData?.SignUdata?.gender == "1"
        {
            gendarTF.text = "Male"
            
            
            self.male_ImageV.image = UIImage(named: "gndr_fill")// #imageLiteral(resourceName: "gndr_fill")
            self.female_ImageV.image = UIImage(named: "gndr_emty")// #imageLiteral(resourceName: "gndr_emty")
            
            
            self.gender_Str  = "1"
        }
        else if SignUpDataClass.shareMngr.signUpData?.SignUdata?.gender == "0"
        {
            gendarTF.text = "Female"
            self.gender_Str  = "0"
            
            self.male_ImageV.image = UIImage(named: "gndr_emty")// #imageLiteral(resourceName: "gndr_fill")
            self.female_ImageV.image = UIImage(named: "gndr_fill")// #imageLiteral(resourceName: "gndr_emty")
        }
        
        self.tblProfileSetting.reloadData()
        
    }
    
    @IBAction func back_Action(_ sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Custom Method
    func navigationbarSetUp() {
        
        let image = UIImage(named: "Header_bar")
        self.navigationController?.navigationBar.setBackgroundImage(image,for: .default)
        self.navigationItem.title = self.defaultLocalizer.stringForKey(key:"Profile Settings")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.setHidesBackButton(true, animated:false)
        
    }
    
    @IBAction func Mycart(_ sender: Any) {
        // let next:MyCartVC = storyboard?.instantiateViewController(withIdentifier: "MyCartVC") as! MyCartVC
        // self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    
    //MARK -  Cancel Popup
    @IBAction func cancel_PopUP_Action(_ sender: UIButton)
    {
        self.hideKeyboardWhenTappedAround()
        
        nameTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        gendarTF.resignFirstResponder()
        mobilNo_TF.resignFirstResponder()
        // home_Add_TF.resignFirstResponder()
        con_Pas_TF.resignFirstResponder()
        old_Pas_TF.resignFirstResponder()
        new_Pas_TF.resignFirstResponder()
        
        
        personal_Add_VIew.isHidden = true
        password_change_VIew.isHidden = true
    }
    
    
    //MARK -  SAVE Popup
    //Note pop up button to save all pop up button action
    @IBAction func Save_PopUP_Action(_ sender: UIButton)
    {
        self.view.endEditing(true)
        save_PopUp_Action = true
        
        // change personal information
        if sender.tag == 101
        {
            //            let user_lat = String(format: "%f", currentLocation.coordinate.latitude)
            //            let user_long = String(format: "%f", currentLocation.coordinate.longitude)
            
            
            if nameTF.text?.isEmpty == true
            {
                Alert.show(vc: self, titleStr: "Message", messageStr:self.defaultLocalizer.stringForKey(key:Alert.kEmpty_Name))
                
            }
            else if last_nameTF.text?.isEmpty == true
            {
                Alert.show(vc: self, titleStr: "Message", messageStr:self.defaultLocalizer.stringForKey(key:Alert.kEmpty_LasName))
                
            }
            else if emailTF.text?.isEmpty == true
            {
                Alert.show(vc: self, titleStr: "Message", messageStr:self.defaultLocalizer.stringForKey(key:Alert.Email_msg))
                
            }
            else if mobilNo_TF.text?.isEmpty == true
            {
                Alert.show(vc: self, titleStr: "Message", messageStr:self.defaultLocalizer.stringForKey(key:Alert.kEmpty_Mobile))
                
            }else if gender_Str.isEmpty == true
            {
                Alert.show(vc: self, titleStr: "Message", messageStr:self.defaultLocalizer.stringForKey(key:Alert.kEmpty_gender))
                
            }
            else
            {
                parameters  = ["user_id":  globel_variable.user_id, "name" :nameTF.text! , "email_id" :emailTF.text! ,"gender":gender_Str ,"mobile":mobilNo_TF.text! , "last_name":last_nameTF.text!]
                
                Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_editPersonalInfo, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  ,  video_url_Up_Arr :  nil, with: Get_SignUp_Struct.self  , completion : {(success, modelVal) -> Void in if success
                {
                    do
                    {
                        
                        
                        SignUpDataClass.shareMngr.signUpData =  modelVal
                        if let useID = SignUpDataClass.shareMngr.signUpData?.SignUdata?.user_id {
                            GlobalVariables.sharedManager.user_id = useID
                            Revoke_Service_Class.sharedInstance.save_Data_NsUser_Default(vc: self, dic_Data:  try (modelVal).asDictionary() as NSDictionary)
                            loader.hideLoader()
                            Alert.showMiddleToast(message: SignUpDataClass.shareMngr.signUpData?.message, view_VC: self)
                            
                            loader.hideLoader()
                            self.tblProfileSetting.reloadData()
                            
                            
                            
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                    
                }
                else
                {
                    Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                    loader.hideLoader()
                    
                    }
                })
                
                /* DPKWebOperation.operation_delegate = self
                 
                 DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_editPersonalInfo)
                 */
                
                personal_Add_VIew.isHidden = true
                password_change_VIew.isHidden = true
                
            }
            
            
        }
            // change pass
        else if sender.tag == 102
        {
            
            if old_Pas_TF.text?.isEmpty == true || new_Pas_TF.text?.isEmpty == true || con_Pas_TF.text?.isEmpty == true
            {
                Alert.show(vc: self, titleStr: "Message", messageStr:self.defaultLocalizer.stringForKey(key:"Please fill all Field."))
                
            }
                
            else if  new_Pas_TF.text! != con_Pas_TF.text!
            {
                Alert.show(vc: self, titleStr: "Message", messageStr:self.defaultLocalizer.stringForKey(key:"Please fill password same as confirm password."))
            }
            else
            {
                parameters  = ["user_id":  globel_variable.user_id, "password" :old_Pas_TF.text! , "new_password" :new_Pas_TF.text!  ]
                
                /*  DPKWebOperation.operation_delegate = self
                 
                 DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_editPersonalInfo)
                 loader.showLoader()
                 
                 */
                
                personal_Add_VIew.isHidden = true
                password_change_VIew.isHidden = true
                
                
                Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_editPersonalInfo, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
                {
                    
                    GlobalVariables.sharedManager.get_Status = modelVal!
                    
                    loader.hideLoader()
                    Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                    self.tblProfileSetting.reloadData()
                    
                    
                    
                }
                else
                {
                    Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                    loader.hideLoader()
                    
                    }
                })
                
                
                
            }
            
            
        }// change address
        
        
        
    }
    @objc func SaveINfo(sender: UIButton){
        
        cell4.txtCountry.text = "Country"
        if  cell4.txtviewOfficalAddress.text?.isEmpty ==  true
        {
            Alert.show(vc: self, titleStr: "Message", messageStr:self.defaultLocalizer.stringForKey(key:"Please set location."))
            
        }
        else if cell4.txtAddress.text?.isEmpty ==  true{
            Alert.show(vc: self, titleStr: "Message", messageStr:self.defaultLocalizer.stringForKey(key:"Please enter address."))
            
        }    else if cell4.txtCity.text?.isEmpty ==  true{
            Alert.show(vc: self, titleStr: "Message", messageStr:self.defaultLocalizer.stringForKey(key:"Please enter city."))
            
        }
        else if cell4.txtCountry.text?.isEmpty ==  true{
            Alert.show(vc: self, titleStr: "Message", messageStr:self.defaultLocalizer.stringForKey(key:"Please enter country."))
            
        }
        else
        {
            loader.showLoader()
            parameters  = ["user_id":  globel_variable.user_id, "address" :cell4.txtAddress.text , "office_address" :cell4.txtviewOfficalAddress.text ,"country":cell4.txtCountry.text,"city":cell4.txtCity.text,"latitude":lattitudeStr,"longitude":longitudeStr ]
            /*  DPKWebOperation.operation_delegate = self
             DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_editPersonalInfo)
             */
            Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_editPersonalInfo, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr :  nil, with: Get_SignUp_Struct.self  , completion : {(success, modelVal) -> Void in if success
            {
                do
                {
                    
                    
                    SignUpDataClass.shareMngr.signUpData =  modelVal
                    if let useID = SignUpDataClass.shareMngr.signUpData?.SignUdata?.user_id
                    {
                        GlobalVariables.sharedManager.user_id = useID
                        Revoke_Service_Class.sharedInstance.save_Data_NsUser_Default(vc: self, dic_Data:  try (modelVal).asDictionary() as NSDictionary)
                        loader.hideLoader()
                        Alert.showMiddleToast(message: SignUpDataClass.shareMngr.signUpData?.message, view_VC: self)
                        
                        loader.hideLoader()
                        self.tblProfileSetting.reloadData()
                        
                        
                        
                    }
                }
                catch
                {
                    print(error)
                }
                
            }
            else
            {
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                loader.hideLoader()
                
                }
            })
            
            self.personal_Add_VIew.isHidden = true
            self.password_change_VIew.isHidden = true
        }
        
        
    }
    
    func load_MainData()
    {
        let parameters : [String : String] = ["artist_id":  globel_variable.user_id , "user_id":  globel_variable.user_id]
        
        print(parameters)
        
        loader.showLoader()
        //Call WebService
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getArtistByid, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_SignUp_Struct.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            loader.hideLoader()
            Alert.showMiddleToast(message: SignUpDataClass.shareMngr.signUpData?.message, view_VC: self)
            
            self.tblProfileSetting.reloadData()
            
            
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })
        
        
    }
    
    
    
    //MARK: - Picker gender
    // The number of columns of data
    
    @IBAction func Picker_Open_Action(_ sender: UIButton)
    {
        self.view.endEditing(true)
        self.picker_Show_View.isHidden = false
        self.view.addSubview(self.picker_Show_View)
        
    }
    @IBAction func picker_Close_Action(_ sender: UIButton)
    {
        self.picker_Show_View.isHidden = true
        
    }
    
    /*  func numberOfComponents(in pickerView: UIPickerView) -> Int {
     return 1
     }
     
     // The number of rows of data
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     return pickerData.count
     }
     
     // The data to return for the row and component (column) that's being passed in
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     self.gendarTF.text = pickerData[row]
     return pickerData[row]
     }
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
     {
     self.gendarTF.text = pickerData[row]
     if self.gendarTF.text! ==  "Male"
     {
     gender_Str = "1"
     }
     if self.gendarTF.text! ==  "Female"
     {
     gender_Str = "0"
     }
     
     
     }
     
     func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
     let attributedString = NSAttributedString(string: pickerData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
     return attributedString
     
     }
     /*
     // MARK: - get location from pop up
     // mySkills_View outlet Add a UIButton in Interface Builder, and connect the action to this function.
     func pickPlace(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
     let center = CLLocationCoordinate2D(latitude: pdblLatitude, longitude: pdblLongitude)
     let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001, longitude: center.longitude + 0.001)
     let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001, longitude: center.longitude - 0.001)
     let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
     let config = GMSPlacePickerConfig(viewport: viewport)
     //let placePicker1 = GMSPlacePicker(config: config)
     let placePicker = GMSPlacePickerViewController(config: config)
     placePicker.delegate = self
     
     present(placePicker, animated: true, completion: nil)
     
     }
     // GMSPlacePickerViewControllerDelegate and implement this code.
     func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
     
     viewController.dismiss(animated: true, completion: nil)
     lattitudeStr = String(place.coordinate.latitude)
     longitudeStr = String(place.coordinate.longitude)
     if let addressSetFirstTime  = place.formattedAddress
     {
     //            print(lattitude)
     //            print(longitude)
     self.address = addressSetFirstTime
     
     
     cell4.txtviewOfficalAddress.text = self.address
     
     
     
     }
     
     
     }
     
     func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
     
     viewController.dismiss(animated: true, completion: nil)
     
     }*/
     
     */
    
}

extension ProfileSettingViewController: UITableViewDelegate, UITableViewDataSource, ProfileSettingDelegate {
    //MARK: - tableview Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell:ProfileSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ProfileSettingTableViewCell
            
            if let image_url = SignUpDataClass.shareMngr.signUpData?.SignUdata?.image
            {
                
                cell.imgProfilePic.sd_setImage(with: URL(string:image_url ), placeholderImage: #imageLiteral(resourceName: "profile"))
                cell.imgProfilePic.clipsToBounds = true
                cell.imgProfilePic.layer.cornerRadius = cell.imgProfilePic.frame.height/2
            }
            cell.btnChange.backgroundColor = UIColor(red: 0/255, green: 107/255, blue: 212/255, alpha: 1)
            cell.btnChange.setTitleColor(UIColor.white, for: .normal)
            cell.btnDelete.backgroundColor = UIColor(red: 0/255, green: 107/255, blue: 212/255, alpha: 1)
            cell.btnDelete.setTitleColor(UIColor.white, for: .normal)
            cell.cellDelegate = self
            
            return cell
        }
        else if indexPath.row == 1
        {
            let cell:ProfileSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ProfileSettingTableViewCell
            
            cell.lblFullName.text   = SignUpDataClass.shareMngr.signUpData?.SignUdata?.name
            cell.nameLastName.text  = SignUpDataClass.shareMngr.signUpData?.SignUdata?.name
            cell.lblEmail.text      = SignUpDataClass.shareMngr.signUpData?.SignUdata?.email_id
            cell.lblMobile.text     = SignUpDataClass.shareMngr.signUpData?.SignUdata?.mobile
            
            if SignUpDataClass.shareMngr.signUpData?.SignUdata?.gender == "1"
            {
                cell.lblGender.text = "Male"
                
            }
            else if SignUpDataClass.shareMngr.signUpData?.SignUdata?.gender == "0"
            {
                cell.lblGender.text = "Female"
            }
            
            cell.cellDelegate = self
            return cell
        }
        else if indexPath.row == 2
        {
            let cell:ProfileSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! ProfileSettingTableViewCell
            
            cell.cellDelegate = self
            
            return cell
        }
        else
        {
            cell4 = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath) as! ProfileSettingTableViewCell
            cell4.txtviewOfficalAddress.text    =  SignUpDataClass.shareMngr.signUpData?.SignUdata?.address
            cell4.txtAddress.text               =  SignUpDataClass.shareMngr.signUpData?.SignUdata?.address
            cell4.txtCountry.text               =  SignUpDataClass.shareMngr.signUpData?.SignUdata?.country
            cell4.txtCity.text                  =  SignUpDataClass.shareMngr.signUpData?.SignUdata?.city
            
            cell4.cellDelegate = self
            cell4.btnSaveInfoCLick.addTarget(self, action: #selector(ProfileSettingViewController.SaveINfo), for: .touchUpInside)
            return cell4
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        
    }
    
    @objc(tableView:heightForRowAtIndexPath:)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            return 225
            
        }else if indexPath.row == 1 {
            
            tableView.estimatedRowHeight = 252
            tableView.rowHeight = UITableView.automaticDimension
            return tableView.rowHeight
            
        }else if indexPath.row == 2 {
            
            return 71
        }else {
            
            tableView.estimatedRowHeight = 450
            tableView.rowHeight = UITableView.automaticDimension
            return tableView.rowHeight
            
        }
    }
    
    //MARK: - TableView CallBack
    func callBackDelete(cell: ProfileSettingTableViewCell)
    {
        cell.btnChange.backgroundColor = UIColor.gray
        cell.btnChange.setTitleColor(UIColor.white, for: .normal)
        
        cell.btnDelete.backgroundColor =  Constant.Ubeaut_Red_Color
        cell.btnDelete.setTitleColor(UIColor.white, for: .normal)
        
        
        
        self.parameters  = ["user_id":  self.globel_variable.user_id ]
        loader.showLoader()
        
        
        self.image_Send =  UIImage(named: "profile")
        
        Revoke_Service_Class.sharedInstance.createMultiPartReqest2(vc: self, dictPram: parameters, methodName: Constant.kTo_editPersonalInfo, img_pram: "image", imageUpload_Arr: [self.image_Send] , media_pram: nil  , video_url_Up_Arr :  nil, with: Get_SignUp_Struct.self  , completion : {(success, modelVal) -> Void in if success
        {
            do
            {
                
                SignUpDataClass.shareMngr.signUpData =  modelVal
                if let useID = SignUpDataClass.shareMngr.signUpData?.SignUdata?.user_id
                {
                    GlobalVariables.sharedManager.user_id = useID
                    Revoke_Service_Class.sharedInstance.save_Data_NsUser_Default(vc: self, dic_Data:  try (modelVal).asDictionary() as NSDictionary)
                    loader.hideLoader()
                    Alert.showMiddleToast(message: SignUpDataClass.shareMngr.signUpData?.message, view_VC: self)
                    
                    loader.hideLoader()
                    
                    self.tblProfileSetting.reloadData()
                    
                    
                }
                
            }
            catch
            {
                print(error)
            }
            
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })
        
        
        
        
    }
    
    func callBackChange(cell: ProfileSettingTableViewCell)
    {
        cell.btnChange.backgroundColor =  UIColor(red: 0/255, green: 107/255, blue: 212/255, alpha: 1)
        cell.btnChange.setTitleColor(UIColor.white, for: .normal)
        
        cell.btnDelete.backgroundColor = UIColor.gray
        cell.btnDelete.setTitleColor(UIColor.white, for: .normal)
      
        ImageAction.instance.cropFigureType = 1
        ImageAction.instance.cornerRadiousType = 30
        ImageAction.instance.showFullActionSheet(on: self){ (image) in
            self.image_Send = image
            let image: UIImage = self.resizeImage(image: image!, newWidth: 600.0)
            self.image_Send = self.RBSquareImage(image: image)//image
            //cell.imgProfilePic.image = image
            let parameters : [String : String]  = ["user_id":  self.globel_variable.user_id ]
            loader.showLoader()
            
            if self.image_Send == nil
            {
                Alert.show(vc: self, titleStr: "Message", messageStr:"Please select image to change.")
                
            }else
            {
                guard let varImg = self.image_Send
                    else {
                        print("imageNotFound")
                        return
                }
                self.image_Send = self.resizeImage(image:  varImg , newWidth: 200)
                Revoke_Service_Class.sharedInstance.createMultiPartReqest2(vc: self, dictPram: parameters, methodName: Constant.kTo_editPersonalInfo, img_pram: "image", imageUpload_Arr: [self.image_Send] , media_pram: nil  , video_url_Up_Arr :  nil, with: Get_SignUp_Struct.self  , completion : {(success, modelVal) -> Void in if success
                {
                    do
                    {
                        
                        SignUpDataClass.shareMngr.signUpData =  modelVal
                        if let useID = SignUpDataClass.shareMngr.signUpData?.SignUdata?.user_id
                        {
                            GlobalVariables.sharedManager.user_id = useID
                            Revoke_Service_Class.sharedInstance.save_Data_NsUser_Default(vc: self, dic_Data:  try (modelVal).asDictionary() as NSDictionary)
                            loader.hideLoader()
                            Alert.showMiddleToast(message: SignUpDataClass.shareMngr.signUpData?.message, view_VC: self)
                            
                            loader.hideLoader()
                            
                            self.tblProfileSetting.reloadData()
                            
                            
                        }
                        
                    }
                    catch
                    {
                        print(error)
                    }
                    
                }
                else
                {
                    Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                    loader.hideLoader()
                    
                    }
                })
                /*
                 DPKWebOperation.WebServiceCallingWithImage(vc: self, dictPram: self.parameters, methodName: Constant.kTo_editPersonalInfo, img_pram: "image", imageUpload: self.image_Send! )
                 DPKWebOperation.operation_delegate = self
                 
                 
                 
                 self.image_Send = nil*/
            }
            
        }
    }
    
    //MARK:- signOut
    @IBAction func signOut_Action(_ sender : UIButton!)
    {
        singOut()
    }
    //MARK:- changeLanguge
    @IBAction func changeLanguge_Action(_ sender : UIButton!)
    {
        
        
        let nextVc : Lang_ViewController = Lang_ViewController.viewController()
        self.navigationController?.pushViewController(nextVc, animated: true)
    }
    //MARK:- bankDetil
    @IBAction func bankDetils_Action(_ sender : UIButton!)
    {
        //let nextVc : BackDtailsAddViewController = self.storyboard?.instantiateViewController(withIdentifier: "BackDtailsAddViewController") as! BackDtailsAddViewController
        // self.navigationController?.pushViewController(nextVc, animated: true)
    }
    
    func singOut()
    {
        print("Signout")
        
        
        let alertController = UIAlertController(title: "FabCustomer", message: Alert.kSign_Out, preferredStyle: UIAlertController.Style.alert)
        
        let nOAction = UIAlertAction(title: "No", style: UIAlertAction.Style.default)
        {
            (result : UIAlertAction) -> Void in
            print("You pressed No")
        }
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default)
        {
            (result : UIAlertAction) -> Void in
            print("You pressed yes")
            
            //self.uploade_Images_Mathod(api_key: Constant.W_AddCard)
            if let bundleID = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleID)
            }
            
            let LoginVC:SplashViewController = SplashViewController.viewController()
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let navigationController = UINavigationController.init(rootViewController: LoginVC)
            appDelegate.window?.rootViewController = navigationController
            appDelegate.window?.makeKeyAndVisible()
        }
        alertController.addAction(nOAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Gender select
    @IBAction func gender_Mathod_Action(_ sender : UIButton!)
    {
        switch sender {
        case maleButton:
            
            self.male_ImageV.image = UIImage(named: "gndr_fill")// #imageLiteral(resourceName: "gndr_fill")
            self.female_ImageV.image = UIImage(named: "gndr_emty")// #imageLiteral(resourceName: "gndr_emty")
            gender_Str = "1"
            break;
        case femaleButton:
            
            gender_Str = "0"
            self.male_ImageV.image = UIImage(named: "gndr_emty")// #imageLiteral(resourceName: "gndr_emty")
            self.female_ImageV.image = UIImage(named: "gndr_fill")// #imageLiteral(resourceName: "gndr_fill")
            
            break;
        default:break;
        }
    }
    
    func callBackPersonalInfo(cell: ProfileSettingTableViewCell)
    {
        self.get_Data()
        personal_Add_VIew.isHidden = false
        password_change_VIew.isHidden = true
    }
    
    func callBackChangePassword(cell: ProfileSettingTableViewCell)
    {
        personal_Add_VIew.isHidden = true
        password_change_VIew.isHidden = false
    }
    
    func callBackHomeAddress(cell: ProfileSettingTableViewCell)
    {
        
        
        adderss_home_bol = false
        
        personal_Add_VIew.isHidden = true
        password_change_VIew.isHidden = true
    }
    
    func callBackOfficeAssress(cell: ProfileSettingTableViewCell)
    {
        
        let addVC : AddressSetViewController =  AddressSetViewController.viewController()
        
        addVC.locaDelegate = self
        
        self.navigationController?.present(addVC, animated: true)
        
    }
    
    
    
    
}
extension ProfileSettingViewController: LocationUpdateDelegate
{
    func UpdaeLoacation() {
        
        self.tblProfileSetting.reloadData()
    }
}
