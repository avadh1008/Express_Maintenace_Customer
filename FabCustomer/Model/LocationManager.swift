//
//  Tabsdfsf.swift
//  WEDDING_APP
//
//  Created by Samyotech on 21/08/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

import Foundation
import UIKit
//import CoreLocation
//import GoogleMaps
//import GooglePlaces
import CoreLocation

 enum LocationManageState {
 case failed
 case updating
 case stoped
 case paused
 }


protocol updateLoactionDelegate {
    func updateLoacationMathod(locationClass : LocationManager)
}
class LocationManager: NSObject {
    
    
    var delegate  : updateLoactionDelegate? = nil
    
    /// Core location
    private let locationManager: CLLocationManager =  CLLocationManager()
    let  global_Var = GlobalVariables.sharedManager
    /// Location manager current state
      var state = LocationManageState.stoped
    
    /// Location
    var currentLocation = CLLocation()
    
   
    static let shared: LocationManager = {
        let instance = LocationManager()
        return instance
    }()
    
    ///Start Location updation
    func requestLocationAtOnce() {
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation() //iOS 9 and later
        locationManager.startUpdatingLocation()
            state = .updating
        
        /*  if getPermission() == false {
         displayAlertWithTitleMessageAndTwoButtons()
         }
        */
    }
    
    /// Get Permission from User
    func getPermission() -> Bool {
        
        if CLLocationManager.authorizationStatus() != nil {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways:
                return true
            case .authorizedWhenInUse:
                return true
            case .denied :
                return false
                 case .restricted:
                 return false
                 case .notDetermined:
                 locationManager.requestWhenInUseAuthorization()
                 return getPermission()
            }
        }
       

            return false
        
    }
    
 
     ///Stop Location Updation
     func stopUpdating() {
      locationManager.stopUpdatingLocation()
       state = .stoped
     }
   
     
    
    /// Display Permission alert
    func displayAlertWithTitleMessageAndTwoButtons() {
        
        let alertController = UIAlertController(title: "Enable Location",
                                                message: "Your current location will be displayed on the map and used for nearby search product.",
                                                preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alertAction) in
            
            /// Settings url
            //  let locationUrl = URL(string: "App-Prefs:root=Privacy&path=Bluetooth")
            UIApplication.shared.open(NSURL(string:UIApplication.openSettingsURLString + Bundle.main.bundleIdentifier!)! as URL, options: [:], completionHandler: nil)
        }
        alertController.addAction(settingsAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
      
        app_delegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        /*AppInfo.shared.application.windows.first?.rootViewController!.presentedViewController?.present(alertController, animated: true, completion: nil)*/
    }
}

/// Location manager delegate methods
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       // print(debugged: "Did Location access permission was changed: \(status)")
        
        switch status {
        case .denied:
           // print(debugged: "get Location permission to access")
            self.displayAlertWithTitleMessageAndTwoButtons()
        case .notDetermined,.restricted:
            //print(debugged: "get Location permission to access")
            manager.requestWhenInUseAuthorization()
        default:
            print( "Permission given")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          state = .updating
        
      
        if ((locations.first?.coordinate) != nil) {
            
            currentLocation = locations.first!
            global_Var.currentLocation = locations.first!
            
         
             delegate?.updateLoacationMathod(locationClass: self)
            
            locationManager.stopUpdatingLocation()
             manager.stopUpdatingLocation()
            
        }
        
        print("Location updated: \(String(describing: locations.first?.coordinate))")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        state = .failed
        print("Failed to update Locations: \(error.localizedDescription)")
        
        manager.requestLocation() //iOS 9 and later
    }
    
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
          state = .paused
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
          state = .updating
    }
}
