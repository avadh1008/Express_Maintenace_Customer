//

//
//
//  Created by Samyotech on 21/05/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//
import UIKit
import Alamofire
import Photos

import SwiftyJSON

enum ConnectionResult {
    case success(NSDictionary)
    case failure(String)

}


struct Service {
    
   
    static let sharedInstance = Service()
    

    //MARK:- Simple Web Service Calling Post
    func post_web_Service_Mathod(vc: UIViewController, dictPram: [String: Any], methodName: String , completion: @escaping (ConnectionResult) -> ()) {
        
        //CHECK REACHABILITY
        let onjRechability: NetworkReachabilityManager = NetworkReachabilityManager()!
        
        if onjRechability.isReachable {
            
            let strUrl = String(format: "%@%@", Constant.kBase_Url, methodName)
            
             
           
            // MAKE REQUEST
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 100
            
            Alamofire.request(strUrl, method: .post, parameters: dictPram, encoding: URLEncoding.default).responseJSON { (responseData) in
                
               
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    
                    //SAVE USER DETAIL DEFAULT
                    let dict : NSDictionary = responseData.result.value! as! NSDictionary
                   
                    if  dict["status"] as! NSNumber == 1
                    {
                        completion(.success(dict))
                    }
                    else if  dict["status"] as! NSNumber == 0
                    {
                        
                        completion(.success(dict))
                        
                    }
                    else if  dict["status"] as! NSNumber == 3
                    {
                        
                      self.status_Mathod(data: dict)
                            self.status_3_mathod(vc: vc)
                       
                        
                    }
                    else
                    {
                        //CallBack Fail
                        completion(.failure(responseData.error! as! String))
                        
                    }
                    
                }
                else
                {
                    completion(.failure("response.error! as! String"))
                    Alert.show(vc: vc, titleStr: "Server Error", messageStr: Alert.Try_agn_msg)
                }
            }
            
        }
        else
        {
            print("not reachable")
            completion(.failure("response.error! as! String"))
            Alert.show(vc: vc, titleStr: "Network Error", messageStr: Alert.Try_agn_msg)
        }
    }
    
    
    
    
    //MARK:- Row_Service Mathod
    // send Josn paramter : -- - - - ---- --- -
    
    func post_Row_web_Service_Mathod(vc: UIViewController, dictPram: NSMutableDictionary?, methodName: String , completion: @escaping (ConnectionResult) -> ()) {
        
        //CHECK REACHABILITY
        let onjRechability: NetworkReachabilityManager = NetworkReachabilityManager()!
        
        if onjRechability.isReachable {
            
            let strUrl = String(format: "%@%@", Constant.kBase_Url, methodName)
            
            print(strUrl, "\n",dictPram as Any)
            
            // MAKE REQUEST
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 100
            
            
            let ulr =  NSURL(string:strUrl)
            var request = URLRequest(url: ulr! as URL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let data = try! JSONSerialization.data(withJSONObject: dictPram!, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            if let json = json {
                
            }
            request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
            
            
            /* guard let mutableRequest = (request as NSURLRequest).mutableCopy() as? URLRequest else {
             // Handle the error
             return
             }
             
             URLProtocol.setProperty(true, forKey: "", in: mutableRequest)
             request = mutableRequest as URLRequest*/
            
            Alamofire.request(request ).responseJSON(){ (responseData) in
                
                //Hide Loader
                print(responseData.result)
                print(responseData)
                
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    print(swiftyJsonVar)
                    
                    //SAVE USER DETAIL DEFAULT
                    let dict : NSDictionary = responseData.result.value! as! NSDictionary
                    
                    if  dict["status"] as! NSNumber == 1
                    {
                        completion(.success(dict))
                    }
                    else if  dict["status"] as! NSNumber == 0
                    {
                        completion(.success(dict))
                        
                    }
                    else if  dict["status"] as! NSNumber == 3
                    {
                        
                        self.status_Mathod(data: dict)
                        self.status_3_mathod(vc: vc)
                        
                        
                    }
                    else
                    {
                        //CallBack Fail
                        completion(.failure(responseData.error! as! String))
                        
                    }
                    
                }
                else
                {
                    completion(.failure("response.error! as! String"))
                    Alert.show(vc: vc, titleStr: "Server Error", messageStr: Alert.Try_agn_msg)
                }
            }
            
            
        }
        else
        {
            print("not reachable")
            completion(.failure("response.error! as! String"))
            Alert.show(vc: vc, titleStr: "Network Error", messageStr: Alert.Try_agn_msg)
        }
    }
    
    //MARK:- Simple Web Service Calling Get
     func get_web_Service_Mathod(vc: UIViewController, dictPram: [String: Any], methodName: String, completion: @escaping (ConnectionResult) -> ()) {
        
        //CHECK REACHABILITY
        let onjRechability: NetworkReachabilityManager = NetworkReachabilityManager()!
        
        if onjRechability.isReachable {
            //True
            
            //URL
            let strUrl = String(format: "%@%@", Constant.kBase_Url, methodName)
            
            print(strUrl, "\n",dictPram)
            
            // MAKE REQUEST
            Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 100
            Alamofire.request(strUrl, method: .get, parameters: dictPram, encoding: URLEncoding.default).responseJSON { (responseData) in
                
                print(responseData.result)
                print(responseData)
                
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    print(swiftyJsonVar)
                    
                    //SAVE USER DETAIL DEFAULT
                    let dict : NSDictionary = responseData.result.value! as! NSDictionary
                    
                  
                    if  dict["status"] as! NSNumber == 1
                    {
                       completion(.success(dict))
                    }else if  dict["status"] as! NSNumber == 0
                    {
                        completion(.success(dict))
                    }
                    else if  dict["status"] as! NSNumber == 3
                    {
                        
                        self.status_Mathod(data: dict)
                        self.status_3_mathod(vc: vc)
                        
                        
                    }
                    else
                    {
                        //CallBack Fail
                        completion(.failure(responseData.error! as! String))
                    }
                    
                }
                else
                {
                   completion(.failure("response.error! as! String"))
                    Alert.show(vc: vc, titleStr: "Network Error", messageStr: Alert.Try_agn_msg)
                   
                }
            }
            
            
        }
        else
        {
            print("not reachable")
            completion(.failure("response.error! as! String"))
            Alert.show(vc: vc, titleStr: "Network Error", messageStr: Alert.Try_agn_msg)
        }
    }
    
    //MARK:- Image Web Service Calling Post
    //MARK:- Video Post Web Service Calling
    // There if you do not need any paramter so pass nil there end it will mangage to send
    
    
    
    func post_Request_Media(vc: UIViewController, dictPram: [String: String], methodName: String, img_pram: String?, imageUpload_Arr : [UIImage?]? , media_pram: String?, video_url_Up_Arr: [URL?]?, completion: @escaping (ConnectionResult) -> ()) {
        
        //CHECK REACHABILITY
        let onjRechability: NetworkReachabilityManager = NetworkReachabilityManager()!
        
        if onjRechability.isReachable {
            
          
            
            let strUrl = String(format: "%@%@", Constant.kBase_Url, methodName)
            print(strUrl)
            
            upload(multipartFormData: { (MultipartFormData) in
                
                //------------------------------------------------------//
                // This condition send multipale image or single image  //
                if let  img_pra  = img_pram
                {
                    

                    if (imageUpload_Arr?.count)! == 1
                    {
                        if let imag_up = imageUpload_Arr?[0] // img_pra+"["+"\(index)"+"]"
                        {
                            if let data = imag_up.pngData() as NSData? {
                                MultipartFormData.append(data as Data, withName: img_pra, fileName: "file.png", mimeType: "image/jpeg")
                            }
                        }
                    }
                    else
                    {
                        for (index,image) in (imageUpload_Arr?.enumerated())!
                        {
                            print(index)
                            print(img_pra+"["+"\(index)"+"]")
                            if let data = image!.pngData() as NSData? {
                                MultipartFormData.append(data as Data, withName: img_pra+"\(index)", fileName: "file.png", mimeType: "image/jpeg")
                            }
                        }
                    }
                    

                }
                //------------------------------------------------------//
                // This condition send multipale Video or single Video  //
                if let  media_pra  = media_pram
                {
                    
                    if (video_url_Up_Arr?.count)! == 1
                    {
                        if let video_url = video_url_Up_Arr?[0]
                        {
                            guard let video_Data = NSData(contentsOf: video_url as URL) else {
                                return
                            }

                            print("File size after compression: \(Double(video_Data.length / 1048576)) mb")
                            print("video", video_Data )
                            
                            MultipartFormData.append(video_Data  as Data, withName: media_pra, fileName:  "video.mp4", mimeType: "mov")
                        }
                    }
                    else
                    {
                        for (index,video_url) in (video_url_Up_Arr?.enumerated())!
                        {
                            print(index)
                            
                            
                            
                            guard let video_Data = NSData(contentsOf: video_url! ) else {
                                return
                            }
                            
                            print("File size after compression: \(Double(video_Data.length / 1048576)) mb")
                            print("video", video_Data )
                            
                            MultipartFormData.append(video_Data  as Data, withName: media_pra+"\(index)", fileName:  "video.mp4", mimeType: "mov")
                            
                        }
                    }
                   
                }
                //------------------------------------------------------//
                
                for (key, value) in dictPram
                {
                    MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key);
                }
                
            }, to: strUrl,
               encodingCompletion: { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    
                    upload.responseJSON { response in
                        
                        if let dict: NSDictionary = response.result.value as? NSDictionary {
                            
                            print(dict)
                            
                            if  dict["status"] as! NSNumber == 1
                            {
                                completion(.success(dict))
                                
                            }
                            else if  dict["status"] as! NSNumber == 0
                            {
                                completion(.success(dict))
                            }
                            else if  dict["status"] as! NSNumber == 3
                            {
                                self.status_Mathod(data: dict)
                                 self.status_3_mathod(vc: vc)
                            }
                            else
                            {
                                //CallBack Fail
                                completion(.failure(response.error! as! String))
                                
                            }
                            
                        }
                        else
                        {
                            //Alert Message for Server Error
                            //loader.hideLoader()
                            //loader.stopTimer()
                            completion(.failure("response.error! as! String"))
                            Alert.show(vc: vc, titleStr: "Server Error", messageStr: Alert.Try_agn_msg)
                        }
                        
                    }
                    
                case .failure:
                    
                    completion(.failure("response.error! as! String"))
                    Alert.show(vc: vc, titleStr: "Network Error", messageStr: Alert.Try_agn_msg)
                    break
                }
            })
            
        }
        else
        {
            print("not reachable")
            completion(.failure("response.error! as! String"))
            Alert.show(vc: vc, titleStr: "Network Error", messageStr: Alert.Try_agn_msg)
        }
    }
    func post_Multi_Request_Media(vc: UIViewController, dictPram: [String: String], methodName: String, img_pram: String?, imageUpload_Arr : [UIImage?]? , media_pram: String?, video_url_Up_Arr: [URL?]?, completion: @escaping (ConnectionResult) -> ()) {
        
        //CHECK REACHABILITY
        let  globel_Var = GlobalVariables.sharedManager
        let onjRechability: NetworkReachabilityManager = NetworkReachabilityManager()!
        
        if onjRechability.isReachable {
            
            
            
            let strUrl = String(format: "%@%@", Constant.kBase_Url, methodName)
            print(strUrl)
            
            upload(multipartFormData: { (MultipartFormData) in
                
                //------------------------------------------------------//
                // This condition send multipale image or single image  //
                if let  img_pra  = img_pram
                {
                    
                    
                    if (imageUpload_Arr?.count)! == 1
                    {
                        if let imag_up = imageUpload_Arr?[0] // img_pra+"["+"\(index)"+"]"
                        {
                            if let data = imag_up.pngData() as NSData? {
                                MultipartFormData.append(data as Data, withName: img_pra+"["+"\(0)"+"]", fileName: "file.png", mimeType: "image/jpeg")
                            }
                        }
                    }
                    else
                    {
                        for (index,image) in (imageUpload_Arr?.enumerated())!
                        {
                            print(index)
                            print(img_pra+"["+"\(index)"+"]")
                            if let data = image!.pngData() as NSData? {
                                MultipartFormData.append(data as Data, withName: img_pra+"["+"\(index)"+"]", fileName: "file.png", mimeType: "image/jpeg")
                                DispatchQueue.main.async {
                               // globel_Var.img_Load_Index_Val = index
                                
                               // globel_Var.glo_coll_obj.reloadData()
                                }
                            }
                        }
                    }
                    
                    
                }
                //------------------------------------------------------//
                // This condition send multipale Video or single Video  //
                if let  media_pra  = media_pram
                {
                    
                    if (video_url_Up_Arr?.count)! == 1
                    {
                        if let video_url = video_url_Up_Arr?[0]
                        {
                            guard let video_Data = NSData(contentsOf: video_url as URL) else {
                                return
                            }
                            
                            print("File size after compression: \(Double(video_Data.length / 1048576)) mb")
                            print("video", video_Data )
                            
                            MultipartFormData.append(video_Data  as Data, withName: media_pra, fileName:  "video.mp4", mimeType: "mov")
                        }
                    }
                    else
                    {
                        for (index,video_url) in (video_url_Up_Arr?.enumerated())!
                        {
                            print(index)
                            
                            
                            
                            guard let video_Data = NSData(contentsOf: video_url! ) else {
                                return
                            }
                            
                            print("File size after compression: \(Double(video_Data.length / 1048576)) mb")
                            print("video", video_Data )
                            
                            MultipartFormData.append(video_Data  as Data, withName: media_pra+"\(index)", fileName:  "video.mp4", mimeType: "mov")
                            
                        }
                    }
                    
                }
                //------------------------------------------------------//
                
                for (key, value) in dictPram
                {
                    MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key);
                }
                
            }, to: strUrl,
               encodingCompletion: { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    
                    upload.responseJSON { response in
                        
                        if let dict: NSDictionary = response.result.value as? NSDictionary {
                            
                            print(dict)
                            
                            if  dict["status"] as! NSNumber == 1
                            {
                                completion(.success(dict))
                                
                            }
                            else if  dict["status"] as! NSNumber == 0
                            {
                                completion(.success(dict))
                            }
                            else if  dict["status"] as! NSNumber == 3
                            {
                                
                                self.status_Mathod(data: dict)
                                self.status_3_mathod(vc: vc)
                                
                                
                            }
                            else
                            {
                                //CallBack Fail
                                completion(.failure(response.error! as! String))
                                
                            }
                            
                        }
                        else
                        {
                           
                            completion(.failure("response.error! as! String"))
                            Alert.show(vc: vc, titleStr: "Server Error", messageStr: Alert.Try_agn_msg)
                        }
                        
                    }
                    
                case .failure:
                    
                   
                    completion(.failure("response.error! as! String"))
                    Alert.show(vc: vc, titleStr: "Network Error", messageStr: Alert.Try_agn_msg)
                    break
                }
            })
            
        }
        else
        {
            print("not reachable")
           
            completion(.failure("response.error! as! String"))
            Alert.show(vc: vc, titleStr: "Network Error", messageStr: Alert.Try_agn_msg)
        }
    }
    
    func status_3_mathod( vc : UIViewController)
    {
        
        let globel_var  =  GlobalVariables.sharedManager
        loader.hideLoader()
        let alert = UIAlertController(title: Alert.msg, message: globel_var.get_Status.message, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            // logout
            
            /*if let bundleID = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundleID)
            }*/
            
         /*   let ent_dtl_VC : Sign_Up_ViewCont  = vc.storyboard?.instantiateViewController(withIdentifier: "Sign_Up_ViewCont") as! Sign_Up_ViewCont
            
           
            let transition : CATransition = CATransition()
            transition.type = kCATransitionReveal
            transition.subtype = kCATransitionFromLeft
            transition.duration = 0.8
            vc.navigationController!.view.layer.add(transition, forKey: kCATransition)
            vc.navigationController?.pushViewController(ent_dtl_VC , animated: true)*/
            
        }
        
        
        alert.addAction(okAction)
        
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    func status_Mathod( data : NSDictionary )
    {
        
        let globel_var  =  GlobalVariables.sharedManager
        let decoder = JSONDecoder()
        
        do
        {
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            globel_var.get_Status = try decoder.decode(Get_Stutas.self , from: data.dict2json())
            
            
        }
        catch
        {
            print(error)
            
        }
    }

}


