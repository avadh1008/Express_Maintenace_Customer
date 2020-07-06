//
//  BookingInfoViewController.swift
//  FabCustomer
//
//  Created by AmitSharma on 10/07/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit

import GoogleMaps
import GooglePlaces
import GooglePlacePicker


class BookingInfoViewController: UIViewController {
    class func viewController() -> BookingInfoViewController {
        return "Main".viewController("BookingInfoViewController") as! BookingInfoViewController
    }
    
    var indexdCheck = 0
    var select_products : Products?
    
    
    let formatter = DateFormatter()
    var create_date = Date()
    var lattitudeStr:String     = ""
    var longitudeStr:String     = ""
    var address_Str:String      = ""

    var city_Str            = ""
    var country             = ""
    var postel_Str          = ""
    var state_str           = ""
    var placeIdStr          = ""
    var placeAddressStr       = ""
    
    @IBOutlet weak var locationLabel    :   UILabel!
    @IBOutlet weak var dateLabel        :   UILabel!
    
    
    @IBOutlet weak var userImg      :   UIImageView!
    @IBOutlet weak var nameLabel    :   UILabel!
    @IBOutlet weak var cateLabel    :   UILabel!
    @IBOutlet weak var priceLabel    :   UILabel!
    
    
    @IBOutlet weak var date_time_Picker: UIDatePicker!
    @IBOutlet weak var date_View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        self.date_View.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationbarSetUp()
    }
    
    func loadData()
    {
        
        
        if let val = app_delegate.tap_collectionVC?.artistDis.data.image
        {
            userImg.sd_setImage(with: URL(string: val), placeholderImage: UIImage(named: "imagePLaceHolder"))
        }
        if let val = app_delegate.tap_collectionVC?.artistDis.data.name
        {
            nameLabel.text = val
        }
        if let val = app_delegate.tap_collectionVC?.artistDis.data.category_name
        {
            cateLabel.text = val
        }
        if let val = app_delegate.tap_collectionVC?.artistDis.data.price
        {
            priceLabel.text = (app_delegate.tap_collectionVC?.artistDis.data.currency_type!)! + val //+ "/" + (app_delegate.tap_collectionVC?.artistDis.data.artist_commission_type!)!
        }
        
        if let location = app_delegate.tap_collectionVC?.artistDis.data.location
        {
            locationLabel.text = location
            formatter.dateFormat = "E, MMM d, yyyy  h:mm a"//"dd MMM yyyy hh:mm a"
            dateLabel.text = formatter.string(from: date_time_Picker.date)
            
            
        }
        
        if indexdCheck == 1
        {
            if let val = select_products?.price
            {
                priceLabel.text =   (select_products?.currency_type!)! +  val
            }
        }
    }
    
    @IBAction func date_Time_Select_Action(_ sender: UIButton!) {
        
        self.view.endEditing(true)
        
        self.date_View.isHidden = false
        date_time_Picker.minimumDate = Date() //Calendar.current.date(bySettingHour : 8 , minute: 0, second: 0, of: Date())
        //  date_time_Picker.maximumDate = Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())
        
    }
    // MARK:- location Option
    @IBAction func get_Location_From_map(_ sender: UIButton)
    {
       let addressVc = self.storyboard?.instantiateViewController(withIdentifier: "Address_Picker_ViewController") as! Address_Picker_ViewController
        addressVc.delegate = self
        self.navigationController?.pushViewController(addressVc, animated: false)
    }
    
    @IBAction func done_Cancel_Mathod(_ sender: UIButton!) {
        
        self.date_View.isHidden = true
        formatter.dateFormat = "dd MMM yyyy hh:mm a"
        dateLabel.text = formatter.string(from: date_time_Picker.date)
    }
    
    //MARK:- Custom Method
    func navigationbarSetUp() {
        if let image : UIImage = UIImage(named: "menu") {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
        }
        let image = UIImage(named: "Header_bar")
        self.navigationController?.navigationBar.setBackgroundImage(image,for: .default)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.setHidesBackButton(false, animated:false)
        self.title = "Booking Info"
        //Bar Left Button
        let btnmenu = UIButton(type: .custom)
        btnmenu.setImage(UIImage(named: "back2"), for: .normal)
        btnmenu.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        btnmenu.addTarget(self, action: #selector(self.back_Action), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btnmenu)
        self.navigationItem.setLeftBarButtonItems([item1], animated: true)
    }
    
    @objc func back_Action()
    {
        if let image : UIImage = UIImage(named: "menu") {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmBook_Mathod(_ sender: UIButton!) {
        
        if dateLabel.text?.isEmpty == true
        {
            Alert.showMiddleToast(message: "Please select Date.", view_VC: self)
            
        }
        else if priceLabel.text?.isEmpty == true
        {
            Alert.showMiddleToast(message: "Please select Date.", view_VC: self)
            
        }
        else if locationLabel.text?.isEmpty == true
        {
            Alert.showMiddleToast(message: "Please select Date.", view_VC: self)
            
        }
        else
        {
            
            bookArtist()
        }
        
        
    }
    
    func bookArtist(){
        
        /*
         let date = Date()
         let formatter = DateFormatter()
         formatter.dateFormat = "E, MMM d, yyyy  h:mm a"
         let resultDate = formatter.string(from: date)
         */
        
        if let val = app_delegate.tap_collectionVC?.artistDis.data.price
        {
        let parameters : [String : String] = ["user_id":  GlobalVariables.sharedManager.user_id ,"artist_id":(app_delegate.tap_collectionVC?.artistDis.data.user_id!)!  ,"date_string": dateLabel.text! ,"timezone": "timeZOne".timeZone ,"price":val , "latitude":lattitudeStr, "longitude":longitudeStr, "address":locationLabel.text!]
        
        print(parameters)
        
        
        loader.showLoader()
        
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_book_artist, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            GlobalVariables.sharedManager.get_Status = modelVal!
            print(modelVal!)
            loader.hideLoader()
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            self.navigationController?.popViewController(animated: true)
            //  self.artistTableView.reloadData()
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })
        
        // DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_book_artist)
        }
    }
}

extension BookingInfoViewController : AddressDelegate {
    func updateAddress(address: String, lat: String, long: String) {
      locationLabel.text = address
      lattitudeStr = lat
      longitudeStr = long
    }
    
    
}

extension BookingInfoViewController : GMSPlacePickerViewControllerDelegate {
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
        
        
        //   placeIdStr = place.placeID
        // loadFirstPhotoForPlace(placeID: place.placeID)
        
        
        if place.formattedAddress != nil
        {
            
            if let addressSetFirstTime = place.formattedAddress //!= nil
            {
                
                // send_TV.text = placeAddressStr
                
                
                
                if place.addressComponents != nil
                {
                    
                    if place.addressComponents?.count != 0
                    {
                        for component in place.addressComponents! {
                            if component.type == "administrative_area_level_2" {
                                city_Str = component.name
                                
                                
                                // self.manage_Address_CityTField.text = city_Str
                                
                            } //
                            if component.type == "country" {
                                country = component.name
                                
                                
                                // self.manage_Address_CountryTField.text = country
                                
                            }
                            
                            if component.type == "postal_code" {
                                postel_Str = component.name
                            }
                            if component.type == "administrative_area_level_1" {
                                state_str = component.name
                            }
                        }
                    }
                }
                
                //place.name ?? "" + "," +
                
                 let add_palce = place.name
                
                    
                placeAddressStr = add_palce ?? "" + "," + addressSetFirstTime;
                
                self.locationLabel.text = placeAddressStr
                    //  self.manage_Address_Label.text =  add_palce + "," + addressSetFirstTime;
                    
                    //self.address_Label.text =  add_palce + "," + addressSetFirstTime;
                    
                    
                    
                    // self.selected_addressyUser_Dic.latitude = lattitudeStr
                    // self.selected_addressyUser_Dic.longitude = longitudeStr
                    //  self.selected_addressyUser_Dic.address = placeAddressStr
                    
                
                
                
                // manage_Address_SetLocationTField
            }
            //self.globel_var.location_to_Edit = place.name
            
            
            
            
        }
        
        
    }
    
    
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        
        viewController.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
}
