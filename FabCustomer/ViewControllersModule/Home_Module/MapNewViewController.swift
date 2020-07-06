

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import Alamofire
import MapKit
import CoreLocation

class MapNewViewController: UIViewController,GMSMapViewDelegate {
    
    class func viewController() -> MapNewViewController {
        return "Main".viewController("MapNewViewController") as! MapNewViewController
    }
   
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer

    var artists_Dic = AllArtists_Struct()
    
    
    @IBOutlet weak var mapNew: GMSMapView!
    @IBOutlet weak var lblCat: UILabel!
    let globel_variable = GlobalVariables.sharedManager
     var strApiFlag:String = ""
    var show_Array_tableMap : NSArray = NSArray()
    var show_array_categoryMap :  NSArray = NSArray()
  
    var dict:NSDictionary = NSDictionary()
    var cat_id = ""
    
    let marker = GMSMarker()
    private var infoWindow = MapMarkerWindow()
    fileprivate var locationMarker : GMSMarker? = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        LocationManager.shared.delegate = self
        LocationManager.shared.requestLocationAtOnce()
        
        
        if let  nextVc  =  CategorySelectionViewController.viewController()  {
            nextVc.delegate =  self
            nextVc.filterDelegate = self
        }
        
        
        self.getMainCat()
        self.mapNew.isMyLocationEnabled = true
        self.mapNew.settings.myLocationButton = true
         self.mapNew.settings.zoomGestures = true
        mapNew.delegate = self
        
        self.infoWindow = loadNiB()
      
    }

  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    LocationManager.shared.requestLocationAtOnce()
        if let  nextVc  =  CategorySelectionViewController.viewController()  {
            nextVc.delegate =  self
            nextVc.filterDelegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func getMainCat(){
        strApiFlag = "main"
      
        
        if GlobalVariables.sharedManager.currentLocation != nil
        {
            
            var parameters : [String : String] = ["":""]
            
            if cat_id != ""
            {
                parameters  = ["latitude" : String(GlobalVariables.sharedManager.currentLocation.coordinate.latitude)  , "longitude" : String(GlobalVariables.sharedManager.currentLocation.coordinate.longitude),"category_id" : cat_id , "user_id":  globel_variable.user_id]
            }
            else
            {
                parameters  = ["latitude" : String(GlobalVariables.sharedManager.currentLocation.coordinate.latitude)  , "longitude" : String(GlobalVariables.sharedManager.currentLocation.coordinate.longitude), "user_id":  globel_variable.user_id]
            }
            
            print(parameters)
            
           
            loader.showLoader()
            Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getAllArtists, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr :  nil, with: AllArtists_Struct.self  , completion : {(success, modelVal) -> Void in if success
            {
                
                self.artists_Dic = modelVal!
                loader.hideLoader()
                self.loadMap()
                
            }
            else
            {
                loader.hideLoader()
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                   self.mapNew.clear()
                
                }
            })
           
        }
        
        
    }
    @objc func getCategorty(notif: NSNotification) {
        
         loadMap()
     }
    @IBAction func getSubAll_Categorty()
    {
        
        if let  nextVc : CategorySelectionViewController =  CategorySelectionViewController.viewController()
            
        {
            nextVc.delegate = self
            self.navigationController?.present(nextVc,animated: true  )
        }
      
            }
    

    func loadNiB() -> MapMarkerWindow {
        let infoWindow = MapMarkerWindow.instanceFromNib() as! MapMarkerWindow
        return infoWindow
    }
    
   
    var camera = GMSCameraPosition()
    
    func loadMap(){
       
         
        
        mapNew.clear()
        infoWindow.removeFromSuperview()
        
        if GlobalVariables.sharedManager.currentLocation != nil {
           camera = GMSCameraPosition.camera(withLatitude: GlobalVariables.sharedManager.currentLocation.coordinate.latitude, longitude:
                GlobalVariables.sharedManager.currentLocation.coordinate.longitude, zoom: 15)
            
            
            if camera != nil
            {
                mapNew.animate(to: camera)
                
                mapNew.delegate = self
                
            }
          
        }
        for (ind , val ) in self.artists_Dic.artists_Arr.enumerated() {
                if let lati = val.live_lat , let long = val.live_long
                {
                    let longTemp =  Double(long)
                    let latTemp = Double(lati)
                    let marker = GMSMarker()
                     
                    marker.position = CLLocationCoordinate2D(latitude: latTemp!, longitude: longTemp!)
                    marker.map = self.mapNew
                    marker.userData = val
                }
                
        }
       
    }
 
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
    
        locationMarker = marker
        infoWindow.removeFromSuperview()
        infoWindow = loadNiB()
        guard let location = locationMarker?.position else {
            print("locationMarker is nil")
            return false
        }
        
        infoWindow.delegate = self
        infoWindow.alpha = 0.9
        infoWindow.infoButton.layer.cornerRadius = infoWindow.infoButton.frame.height / 2
        
        if let data = marker.userData as! AllArtists_DataStruct?  {
            
            infoWindow.spotData = data
            
            if let name = data.name
            {
                infoWindow.lblArtistNAme.text = name
            
            }
            if let category_name = data.category_name
            {
               
                  infoWindow.lblCatName.text = category_name
                
            }
            if let image = data.image
            {
               
                infoWindow.imgArtist.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "profile"))
            }
           
        }
     
        
       infoWindow.imgArtist.clipsToBounds = true
       infoWindow.imgArtist.layer.cornerRadius = infoWindow.imgArtist.frame.height/2
       
       
        
        // Offset the info window to be directly above the tapped marker
        infoWindow.center = mapView.projection.point(for: location)
        infoWindow.center.y = infoWindow.center.y - 82
        self.view.addSubview(infoWindow)
        return false
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if (locationMarker != nil){
            guard let location = locationMarker?.position else {
                print("locationMarker is nil")
                return
            }
            infoWindow.center = mapView.projection.point(for: location)
            infoWindow.center.y = infoWindow.center.y - 82
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        infoWindow.removeFromSuperview()
    }
   

  
}
extension MapNewViewController : MapMarkerDelegate
{
    func didTapInfoButton(data: AllArtists_DataStruct?) {
        
        let artist_Pro_VC:ArtistPrViewController = storyboard?.instantiateViewController(withIdentifier: "ArtistPrViewController") as! ArtistPrViewController
        if let id_to_send = data?.user_id
        {
         artist_Pro_VC.get_artist_id = id_to_send
         }
        self.navigationController?.pushViewController(artist_Pro_VC, animated: true)
    }
    
}


extension MapNewViewController : updateLoactionDelegate
{
    func updateLoacationMathod(locationClass: LocationManager) {
        getMainCat()
    }
    
    
}

 

extension MapNewViewController : updateCategoreyDelegate  , FilterDelegate {
    
    func updateCategoryMathod(val: CategoryOptionData?) {
        
        if  val != nil {
            
               if let cat_id = val?.id {
                    self.cat_id = cat_id
                    self.lblCat.text = val?.cat_name
                    self.getMainCat()
                }
                
                
             
        }else {
                cat_id = ""
                lblCat.text = "ALL CATEGORIES"
                self.getMainCat()
        }
        
        
        
    }
    
    func filterMethod(type: Int?) {
        if let intVal = type {
             let typeVal = Int(intVal)
                sortingMathod(type:typeVal )
             
        }
        
    }
    
}

extension MapNewViewController {
    
    func sortingMathod(type :Int) {
        
        artists_Dic.artists_Arr.sort{
            if type == 1
            {
                if Int($0.price) ?? 0 < Int($1.price) ?? 0 {
                    return Int($0.price) ?? 0 < Int($1.price) ?? 0
                }
                else {
                    return Int($0.price) ?? 0 < Int($1.price) ?? 0
                }
            }
            else if type == 2
            {
                if $0.jobDone > $1.jobDone {
                    return $0.jobDone > $1.jobDone
                }
                else {
                    return $0.jobDone > $1.jobDone
                }
            }
            else if type == 3
            {
                if Int($0.featured) ?? 0 > Int($1.featured) ?? 0 {
                    return Int($0.featured) ?? 0 > Int($1.featured) ?? 0
                }
                else {
                    return Int($0.featured) ?? 0 > Int($1.featured) ?? 0
                }
            }
            else if type == 4
            {
                if $0.ava_rating > $1.ava_rating{
                    return $0.ava_rating > $1.ava_rating
                }
                else {
                    return $0.ava_rating > $1.ava_rating
                }
            }
            else
            {
                return $0.distance! > $1.distance!
            }
            
        }
        self.loadMap()
        
    }
}
