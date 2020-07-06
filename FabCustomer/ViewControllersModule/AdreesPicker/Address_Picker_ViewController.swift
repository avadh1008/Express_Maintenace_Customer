
import UIKit
import GoogleMaps
import GooglePlaces

protocol AddressDelegate {
    func updateAddress(address: String, lat :String, long : String)
}

class Address_Picker_ViewController: UIViewController, GMSMapViewDelegate {
    
    class func viewController() -> Address_Picker_ViewController {
        return "Main".viewController("Address_Picker_ViewController") as! Address_Picker_ViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        map_View.delegate = self
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: GlobalVariables.sharedManager.currentLocation.coordinate.latitude , longitude: GlobalVariables.sharedManager.currentLocation.coordinate.longitude , zoom: 15)
        map_View.camera = camera
        map_View.isMyLocationEnabled = true
       
    }
    @IBOutlet weak var map_View: GMSMapView!
    
    @IBOutlet weak var address_label: UILabel!
    var current_lat = 0.0
    var current_long = 0.0
    
    var delegate : AddressDelegate? = nil
  
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        current_lat = coordinate.latitude
        current_long = coordinate.longitude
        mapView.clear()
        let marker = GMSMarker(position: coordinate)
        
        marker.map = mapView
        
        getAddressFromLatLon(pdblLatitude: current_lat, withLongitude: current_long)
       //getAddressForLatLng(latitude: String(current_lat), longitude: String(current_long))
    }
    
    @IBAction func selectAddress(_ sender: UIButton) {
        delegate?.updateAddress(address: address_label.text ?? "Select Address", lat: String(current_lat), long: String(current_long))
        self.dismiss(animated: false, completion: nil)
        self.navigationController?.popViewController(animated: false)
    }
    
   
    
    
   /* func getAddressForLatLng(latitude: String, longitude: String)  { // Call this function

        let url = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)" + "&key=" + "AIzaSyC3M6dFMNU1I8kNnTc1dEwRCSCudbWux_A")//Here pass your latitude, longitude
        print(url!)
        let data = NSData(contentsOf: url! as URL)

        if data != nil {
            let json = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            print(json)

            let status = json["status"] as! String
            if status == "OK" {

                if let result = json["results"] as? NSArray   {

                    if result.count > 0 {
                        if let addresss:NSDictionary = result[0] as? NSDictionary {
                            if let address = addresss["address_components"] as? NSArray {
                                var newaddress = ""
                                var number = ""
                                var street = ""
                                var city = ""
                                var state = ""
                                var zip = ""
                                var country = ""

                                if(address.count > 1) {
                                    number =  (address.object(at: 0) as! NSDictionary)["short_name"] as! String
                                }
                                if(address.count > 2) {
                                    street = (address.object(at: 1) as! NSDictionary)["short_name"] as! String
                                }
                                if(address.count > 3) {
                                    city = (address.object(at: 2) as! NSDictionary)["short_name"] as! String
                                }
                                if(address.count > 4) {
                                    state = (address.object(at: 4) as! NSDictionary)["short_name"] as! String
                                }
                                if(address.count > 6) {
                                    zip =  (address.object(at: 6) as! NSDictionary)["short_name"] as! String
                                }
                                newaddress = "\(number) \(street), \(city), \(state) \(zip)"
                                print(newaddress)
                                address_label.text = newaddress
                                // OR
                                //This is second type to fetch pincode, country, state like this type of data

                                for i in 0..<address.count {
                                    print(((address.object(at: i) as! NSDictionary)["types"] as! Array)[0])
                                    if ((address.object(at: i) as! NSDictionary)["types"] as! Array)[0] == "postal_code" {
                                        zip =  (address.object(at: i) as! NSDictionary)["short_name"] as! String
                                    }
                                    if ((address.object(at: i) as! NSDictionary)["types"] as! Array)[0] == "country" {
                                        country =  (address.object(at: i) as! NSDictionary)["long_name"] as! String
                                    }
                                    if ((address.object(at: i) as! NSDictionary)["types"] as! Array)[0] == "administrative_area_level_1" {
                                        state =  (address.object(at: i) as! NSDictionary)["long_name"] as! String
                                    }
//                                    if ((address.object(at: i) as! NSDictionary)["types"] as! Array)[0] == "administrative_area_level_2" {
//                                        district =  (address.object(at: i) as! NSDictionary)["long_name"] as! String
//                                    }

                                }

                            }

                        }
                    }

                }

            }

        }

    }*/

    
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat = pdblLatitude
     
        let lon = pdblLongitude
       
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]

                if pm.count > 0 {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }

                    self.address_label.text = addressString
                    print(addressString)
                }
        })

    }
 


}

