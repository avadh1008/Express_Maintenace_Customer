//
//  AddressSetViewController.swift
//  FabCustomer
//
//  Created by AmitSharma on 19/07/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

protocol LocationUpdateDelegate {
    func UpdaeLoacation()
}

class AddressSetViewController: UIViewController {
    
    class func viewController() -> AddressSetViewController {
        return "Main".viewController("AddressSetViewController") as! AddressSetViewController
    }

    var locaDelegate : LocationUpdateDelegate?
    
    // ------------Manage Address   Outlet----------//
    
    
    var lattitudeStr:String     = ""
    var longitudeStr:String     = ""
    var address_Str:String      = ""
    
    var city_Str                = ""
    var country                 = ""
    var postel_Str              = ""
    var state_str               = ""
    var placeIdStr              = ""
    var placeAddressStr         = ""
    
    
    @IBOutlet weak var manage_Address_Label : UILabel!
    /*
    @IBOutlet weak var manage_Address_CityTField : UITextField!
    @IBOutlet weak var manage_Address_CountryTField : UITextField!
    */
    
    @IBOutlet weak var manage_Address_CityTField : UITextField!
    @IBOutlet weak var manage_Address_Save_Button : UIButton!
    @IBOutlet weak var manage_Address_Cancel_Button : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manage_Address_Label.text =  SignUpDataClass.shareMngr.signUpData?.SignUdata?.address
        manage_Address_CityTField.text =  SignUpDataClass.shareMngr.signUpData?.SignUdata?.city
        // Do any additional setup after loading the view.
    }
    @IBAction func button_Action(_ sender: UIButton!)
    {
        switch sender {
            
            
        case manage_Address_Cancel_Button:
            self.backMathod()
            break;
            
        case manage_Address_Save_Button:
           
           
             self.view.endEditing(true)
             if manage_Address_Label.text?.isEmpty == true
             {
             Alert.showToast(message: Alert.kEmpty_Current_Address, view_VC: self)
             return;
             }
             
             if manage_Address_CityTField.text?.isEmpty ==  true
             {
             Alert.showToast(message: Alert.CITY_MES, view_VC: self)
             return;
             }
             
             guard let diStr = SignUpDataClass.shareMngr.signUpData?.SignUdata?.user_id else{ return }
             
             let parameters : [String : String] =  ["user_id": diStr ,"city":manage_Address_CityTField.text!,"country":"c","address":manage_Address_Label.text!,"latitude":lattitudeStr,"longitude":longitudeStr ]
             
             
             loader.showLoader()
           
             Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_editPersonalInfo, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  ,  video_url_Up_Arr :  nil, with: Get_SignUp_Struct.self  , completion : {(success, modelVal) -> Void in if success
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
                       self.locaDelegate?.UpdaeLoacation()
                        
                        self.dismiss(animated: true)
                        
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

            
            break;
            
        default : break;
            
            
        }
    }
    
    
    func backMathod()
    {
      
        self.dismiss(animated: true)
    }
    @IBAction func get_Location_From_map(_ sender: UIButton)
    {
       let addressVc = self.storyboard?.instantiateViewController(withIdentifier: "Address_Picker_ViewController" ) as! Address_Picker_ViewController
        addressVc.delegate = self
        present(addressVc, animated: false, completion: nil)
    }
    
    
    
}
extension AddressSetViewController : AddressDelegate {
    func updateAddress(address: String, lat: String, long: String) {
        manage_Address_Label.text = address
        lattitudeStr = lat
        longitudeStr = long
    }
    
    
}

extension AddressSetViewController : GMSPlacePickerViewControllerDelegate {
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
                                
                                
                                self.manage_Address_CityTField.text = city_Str
                                
                            } //
                            if component.type == "country" {
                                country = component.name
                                
                                
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
                
                if let add_palce = place.name
                {
                    
                    placeAddressStr = add_palce + "," + addressSetFirstTime;
                    self.manage_Address_Label.text =  add_palce + "," + addressSetFirstTime;
                    
                    self.manage_Address_Label.text =  add_palce + "," + addressSetFirstTime;
                    
                    
                    
                }
                else
                {
                    
                    
                    self.manage_Address_Label.text =  addressSetFirstTime;
                    placeAddressStr =  addressSetFirstTime;
                    self.manage_Address_Label.text =  addressSetFirstTime;
                    
                    
                    
                }
                
                
            }
            
            
        }
        
        
    }
    
    
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        
        viewController.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
}

extension AddressSetViewController : updateLoactionDelegate
{
    func updateLoacationMathod(locationClass: LocationManager) {
        
    }
    
    
}
