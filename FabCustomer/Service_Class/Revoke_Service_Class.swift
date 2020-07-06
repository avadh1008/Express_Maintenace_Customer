//
//  Revoke_Service_Class
//
//
//  Created by Samyotech on 01/06/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

//class Revoke_Service_Class

//extension UIViewController
struct Revoke_Service_Class
{
    
    static let sharedInstance = Revoke_Service_Class()
    func get_applied_job_Invoice(vc: UIViewController, dictPram: [String: String], methodName: String , completion: @escaping (Bool) -> ())
    {
        
        let globel_var  =  GlobalVariables.sharedManager
        
        loader.showLoader()
        Service.sharedInstance.post_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let data): print(data)
            print(data)
            let dictResponse = data
            print(data.dict2json())
            
            if  dictResponse["status"] as! NSNumber == 1
            {
                loader.hideLoader()
                
                let data_Con : NSDictionary =  (dictResponse["data"] as? NSDictionary)!
                
                
                self.status_Mathod(data: data)
                do
                {
                    globel_var.getSingle_Incoice_Struct = try JSONDecoder().decode(Get_Single_Invoice.self , from: data_Con.dict2json())
                    print(globel_var.getSingle_Incoice_Struct)
                    
                    completion(true)
                    
                }
                catch
                {
                    print(error)
                    completion(false)
                    
                }
                
            }
            if  dictResponse["status"] as! NSNumber == 0
            {
                completion(false)
                self.status_Mathod(data: data)
                Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                
            }
            
            loader.hideLoader()
                
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
    func get_applied_job_by_id_Request(vc: UIViewController, dictPram: [String: String], methodName: String , completion: @escaping (Bool) -> ())
    {
        
        let globel_var  =  GlobalVariables.sharedManager
        
        loader.showLoader()
        Service.sharedInstance.post_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let data): print(data)
            print(data)
            let dictResponse = data
            print(data.dict2json())
            
            if  dictResponse["status"] as! NSNumber == 1
            {
                loader.hideLoader()
                
                let data_Con : NSArray =  (dictResponse["data"] as? NSArray)!
                
                
                self.status_Mathod(data: data)
                do
                {
                    
                    globel_var.applied_job_by_id_Arr = try JSONDecoder().decode([Get_applied_job_by_id_Struct].self , from: data_Con.arr2json())
                    
                    
                    
                    completion(true)
                    
                }
                catch
                {
                    print(error)
                    completion(false)
                    
                }
                
            }
            if  dictResponse["status"] as! NSNumber == 0
            {
                completion(false)
                self.status_Mathod(data: data)
                Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                
            }
            
            loader.hideLoader()
                
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
    // There Mathod delecre for re use if any mathod calling tow time so will be declare there
    func getAllCaegory_Request(vc: UIViewController, dictPram: [String: String], methodName: String , completion: @escaping (Bool) -> ())
    {
        let globel_var  =  GlobalVariables.sharedManager
        
        loader.showLoader()
        Service.sharedInstance.post_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let data): print(data)
            print(data)
            let dictResponse = data
            print(data.dict2json())
            
            if  dictResponse["status"] as! NSNumber == 1
            {
                loader.hideLoader()
                let data_Con : NSArray =  (dictResponse["data"] as? NSArray)!
                self.status_Mathod(data: data)
                do
                {
                    
                    globel_var.all_Caegory_Arr = try JSONDecoder().decode([Get_All_Caegory].self , from: data_Con.arr2json())
                    print(globel_var.all_Caegory_Arr)
                    
                    completion(true)
                    
                    
                }
                catch
                {
                    print(error)
                    completion(false)
                    
                }
                
            }
            if  dictResponse["status"] as! NSNumber == 0
            {
                self.status_Mathod(data: data)
                Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                completion(false)
            }
            
            loader.hideLoader()
                
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
    
    //MARK:- chat home
    
    func Update_Mathod_Request(vc: UIViewController, dictPram: [String: String], methodName: String , completion: @escaping (Bool) -> ())
    {
        
        let globel_var  =  GlobalVariables.sharedManager
        
        print(dictPram)
        loader.showLoader()
        Service.sharedInstance.post_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let data): print(data)
            print(data)
            let dictResponse = data
            print(data.dict2json())
            
            if  dictResponse["status"] as! NSNumber == 1
            {
                loader.hideLoader()
                
                self.status_Mathod(data: data)
                completion(true)
                let alert = UIAlertController(title: Alert.kmsg, message: globel_var.get_Status.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    
                }))
                
                vc.present(alert, animated: true, completion: nil)
                
            }
            else if  dictResponse["status"] as! NSNumber == 0
                
            {
                loader.hideLoader()
                
                
                self.status_Mathod(data: data)
                Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                
                completion(false)
                }
                
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
    
    
    func post_Mathod_Req(vc: UIViewController, dictPram: [String: String], methodName: String , completion: @escaping (Bool) -> ())
    {
        let globel_var  =  GlobalVariables.sharedManager
        
        loader.showLoader()
        Service.sharedInstance.post_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let data):
            
            let dictResponse = data
            
            self.status_Mathod(data: data)
            
            
                self.status_Mathod(data: data)
                
                if  dictResponse["status"] as! NSNumber == 1
                {
                    completion(true)
                    
                    
                }else if  dictResponse["status"] as! NSNumber == 0
                {
                    
                    Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                    completion(false)
                }
               
            
            
              
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
    
    //MARK:- Model callass send with data tage
    func createReqest <T:Decodable> (vc: UIViewController, dictPram: [String: String], methodName: String! , img_pram: String?, imageUpload_Arr : [UIImage?]?, media_pram : String?, video_url_Up_Arr: [URL?]? , with type:T.Type, completion: @escaping (Bool,T?) -> ())
    {
        
        
        let encoder = JSONEncoder()
        Service.sharedInstance.post_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let dictResponse):
                
                if  dictResponse["status"] as! NSNumber == 1
                {
                    
                    do
                    {
                        let model = try JSONDecoder().decode(type, from: dictResponse.dict2json())
                        completion(true, model)
                    }
                    catch
                    {
                        
                        print(error)
                        // Alert.show(vc: vc, titleStr: Alert.kmsg, messageStr: Alert.Try_agn_msg)
                        completion(false,  encoder as? T)
                    }
                    
                }
                if  dictResponse["status"] as! NSNumber == 0
                {
                    self.status_Mathod(data: dictResponse)
                    completion(false, encoder as? T)
                    //  Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_stutas.message)
                }
                
            case .failure(let error):
                print(error)
                completion(false, encoder as? T)
            }
        }
        
    }
    
    //MARK:- Profile with video Snap
    
    func get_Profile_Req(vc: UIViewController, dictPram: [String: String], methodName: String , completion: @escaping (Bool) -> ())
    {
        let globel_var  =  GlobalVariables.sharedManager
        
        loader.showLoader()
        Service.sharedInstance.post_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let data):
                
                let dictResponse = data
                
                self.status_Mathod(data: data)
                
                if  dictResponse["status"] as! NSNumber == 1
                {
                    
                        completion(true)
                    
                }
                else if  dictResponse["status"] as! NSNumber == 0
                {
                    self.status_Mathod(data: data)
                    Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                    completion(false)
                }
                
                
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
    
 
    
    func get_all_job_Request(vc: UIViewController, dictPram: [String: String], methodName: String , completion: @escaping (Bool) -> ())
    {
        
        let globel_var  =  GlobalVariables.sharedManager
        
        loader.showLoader()
        Service.sharedInstance.post_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let data): print(data)
            print(data)
            let dictResponse = data
            print(data.dict2json())
            
            if  dictResponse["status"] as! NSNumber == 1
            {
                loader.hideLoader()
                
                let data_Con : NSArray =  (dictResponse["data"] as? NSArray)!
                
                
                self.status_Mathod(data: data)
                do
                {
                    globel_var.all_job_Arr = try JSONDecoder().decode([Get_all_job].self , from: data_Con.arr2json())
                    print(globel_var.all_job_Arr)
                    
                    completion(true)
                    
                }
                catch
                {
                    print(error)
                    completion(false)
                    
                }
                
            }
            if  dictResponse["status"] as! NSNumber == 0
            {
                self.status_Mathod(data: data)
                Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                completion(false)
            }
            
            loader.hideLoader()
                
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
  
    
    //MARK:- getEvents
    
    /*func get_Events_Reqest(vc: UIViewController, dictPram: [String: Any], methodName: String , completion: @escaping (Bool) -> ())
    {
        let globel_var  =  GlobalVariables.sharedManager
        
        loader.showLoader()
        Service.sharedInstance.post_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let data):
            let dictResponse = data
            
            
            if  dictResponse["status"] as! NSNumber == 1
            {
                self.status_Mathod(data: data)
               
                completion(false)
                
                /*if let data_Con : NSArray =  (dictResponse["data"] as? NSArray)
                {
                    do
                    {
                        globel_var.mony_Arr = try JSONDecoder().decode([ Get_Mony_his_Struct].self , from: data_Con.arr2json())
                        completion(true)
                        
                    }
                    catch
                    {
                        Alert.show(vc: vc, titleStr: Alert.msg, messageStr: Alert.Try_agn_msg)
                        print(error)
                        completion(false)
                        
                    }
                }*/
      
            }
            else if  dictResponse["status"] as! NSNumber == 0
            {
                
                if let page =  dictPram["page"] as? String
                {
                    let page_int = Int(page)
                    if page_int! > 1
                    {
                        completion(true)
                    }
                    else
                    {
                        self.status_Mathod(data: data)
                        completion(false)
                    }
                    
                }
                else
                {
                    self.status_Mathod(data: data)
                    completion(false)
                }
                
 
            }
            
            
             
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
    
    */
    func get_Post_Refresh_Reqest(vc: UIViewController, dictPram: [String: Any], methodName: String , completion: @escaping (Bool) -> ())
    {
        let globel_var  =  GlobalVariables.sharedManager
        
        loader.showLoader()
        Service.sharedInstance.post_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let data):
            let dictResponse = data
            
            
            /*if  dictResponse["status"] as! NSNumber == 1
            {
                self.status_Mathod(data: data)
                //loader.hideLoader()
                //loader.stopTimer()
                
               
                if let data_Con : NSArray =  (dictResponse["getPosts"] as? NSArray)
                {
                    do
                    {
                        
                        if globel_var.posts_Arr.count > 0
                        {
                            globel_var.posts_Arr =  globel_var.posts_Arr + (try JSONDecoder().decode([Get_Posts_Struct].self , from: data_Con.arr2json()))
                            //globel_var.posts_Arr.append(try JSONDecoder().decode(Get_Posts_Struct.self , from: data_Con.arr2json()))
                        }
                        else
                        {
                            globel_var.posts_Arr = try JSONDecoder().decode([Get_Posts_Struct].self , from: data_Con.arr2json())
                        }
                        
                        
                        
                        
                        completion(true)
                        
                        
                    }
                    catch
                    {
                        
                        
                        Alert.show(vc: vc, titleStr: Alert.W_msg, messageStr: Alert.W_Par_Er)
                        print(error)
                        completion(false)
                        
                        
                        
                        
                        
                    }
                }
                if let data_Con : NSArray =  (dictResponse["getComments"] as? NSArray)
                {
                    do
                    {
                        
                        if globel_var.comment_Arr.count > 0
                        {
                            globel_var.comment_Arr =  globel_var.comment_Arr + (try JSONDecoder().decode([Get_Comment_Struct].self , from: data_Con.arr2json()))
                            //globel_var.posts_Arr.append(try JSONDecoder().decode(Get_Posts_Struct.self , from: data_Con.arr2json()))
                        }
                        else
                        {
                            globel_var.comment_Arr = try JSONDecoder().decode([Get_Comment_Struct].self , from: data_Con.arr2json())
                        }
                        
                        
                        completion(true)
                        
                        
                    }
                    catch
                    {
                        
                        
                        Alert.show(vc: vc, titleStr: Alert.W_msg, messageStr: Alert.W_Par_Er)
                        print(error)
                        completion(false)
                        
                        
                        
                        
                        
                    }
                }
                //
                //
                
                
            }
            else if  dictResponse["status"] as! NSNumber == 0
            {
                
                if let page =  dictPram["page"] as? String
                {
                    let page_int = Int(page)
                    if page_int! > 1
                    {
                        completion(true)
                    }
                    else
                    {
                        self.status_Mathod(data: data)
                        completion(false)
                    }
                    
                }
                else
                {
                    self.status_Mathod(data: data)
                    completion(false)
                }
                
                
                
                //Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                
            }
            else if  dictResponse["status"] as! NSNumber == 3
            {
                self.status_Mathod(data: data)
                Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                //completion(false)
            }*/
                
                //loader.hideLoader()
                //  loader.stopTimer()
                
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
    
  
    
    //MARK:- createFunction
    //MARK:- add Venu 
    func create_SignUp_Reqest(vc: UIViewController, dictPram: [String: String], methodName: String! , img_pram: String?, imageUpload_Arr : [UIImage?]?, media_pram : String?, video_url_Up_Arr: [URL?]?, completion: @escaping (Bool) -> ())
    {
        
        let globel_var  =  GlobalVariables.sharedManager
        //let mainVC = SJSwiftSideMenuController()
        loader.showLoader()
        Service.sharedInstance.post_Request_Media(vc: vc, dictPram: dictPram, methodName: methodName,  img_pram : img_pram, imageUpload_Arr: imageUpload_Arr, media_pram: media_pram, video_url_Up_Arr: video_url_Up_Arr) { (connectionResult) in
            switch connectionResult {
            case .success(let data):
                
                let dictResponse = data
                
                self.status_Mathod(data: data)
                if  dictResponse["status"] as! NSNumber == 1
                {
                    if let data_Con : NSDictionary =  (dictResponse["data"] as? NSDictionary)
                    {
                        let data_dic : NSDictionary = dictResponse["data"] as! NSDictionary
                        
                        globel_var.user_id = data_dic["user_id"] as! String
                        completion(true)
                        
                    }
                    else
                    {
                        completion(true)
                    }
                    
                    
                    
                }
                if  dictResponse["status"] as! NSNumber == 0
                {
                    
                    
                    completion(false)
                    Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                    
                }
                
                
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
    
    
    
    
    
    //MARK:- add Venu
    func send_Reqest(vc: UIViewController, dictPram: [String: String], methodName: String! , img_pram: String?, imageUpload_Arr : [UIImage?]?, media_pram : String?, video_url_Up_Arr: [URL?]?, completion: @escaping (Bool) -> ())
    {
        
        
        let globel_var  =  GlobalVariables.sharedManager
        
        loader.showLoader()
        Service.sharedInstance.post_Request_Media(vc: vc, dictPram: dictPram, methodName: methodName,  img_pram : img_pram, imageUpload_Arr: imageUpload_Arr, media_pram: media_pram, video_url_Up_Arr: video_url_Up_Arr) { (connectionResult) in
            switch connectionResult {
            case .success(let data):
                
                let dictResponse = data
                
                self.status_Mathod(data: data)
                if  dictResponse["status"] as! NSNumber == 1
                {
                    completion(true)
                }
                if  dictResponse["status"] as! NSNumber == 0
                {
                    
                    
                    completion(false)
                    Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                    
                }
                
                
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
    //MARK:- add multi ple invitation card
    
    func create_Multiple_Reqest(vc: UIViewController, dictPram: [String: String], methodName: String! , img_pram: String?, imageUpload_Arr : [UIImage?]?, media_pram : String?, video_url_Up_Arr: [URL?]?, completion: @escaping (Bool) -> ())
    {
        
        //, media_pram: String?, video_url_Up: URL?
        
        let globel_var  =  GlobalVariables.sharedManager
        
        loader.showLoader()
        
        Service.sharedInstance.post_Multi_Request_Media(vc: vc, dictPram: dictPram, methodName: methodName,  img_pram : img_pram, imageUpload_Arr: imageUpload_Arr, media_pram: media_pram, video_url_Up_Arr: video_url_Up_Arr) { (connectionResult) in
            switch connectionResult {
            case .success(let data):
           
            let dictResponse = data
            
            self.status_Mathod(data: data)
            if  dictResponse["status"] as! NSNumber == 1
            {
                
                completion(true)
                
                
            }
            if  dictResponse["status"] as! NSNumber == 0
            {
              
                completion(false)
                Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                
                }
             
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
    //MARK:- Model callass send with data tage
    func createMultiPartReqest2 <T:Decodable> (vc: UIViewController, dictPram: [String: String], methodName: String! , img_pram: String?, imageUpload_Arr : [UIImage?]?, media_pram : String?, video_url_Up_Arr: [URL?]? , with type:T.Type, completion: @escaping (Bool,T?) -> ())
    {
        
        let globel_var  =  GlobalVariables.sharedManager
        
        let encoder = JSONEncoder()
        
        
        Service.sharedInstance.post_Request_Media(vc: vc, dictPram: dictPram, methodName: methodName, img_pram: img_pram, imageUpload_Arr: imageUpload_Arr, media_pram: media_pram, video_url_Up_Arr: video_url_Up_Arr) { (connectionResult) in
            switch connectionResult {
            case .success(let data):
                
                let dictResponse = data
                
                self.status_Mathod(data: data)
                if  dictResponse["status"] as! NSNumber == 1
                {
                    
                    do {
                        
                        let model = try JSONDecoder().decode(type, from: data.dict2json())
                        completion(true, model)
                    }
                    catch
                    {
                        
                        print(error)
                        
                        //Alert.show(vc: vc, titleStr: Alert.kmsg, messageStr: Alert.Try_agn_msg)
                        print(error)
                        completion(false,  encoder as? T)
                    }
                }
                if  dictResponse["status"] as! NSNumber == 0
                {
                    self.status_Mathod(data: data)
                    
                    completion(false, encoder as? T)
                    
                    Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                    
                }
                
                
            case .failure(let error):
                completion(false, encoder as? T)
            }
            
        }
        
    }
    
    
    //MARK:- Model callass send with data tage
    func createGetReqest <T:Decodable> (vc: UIViewController, dictPram: [String: String], methodName: String! , img_pram: String?, imageUpload_Arr : [UIImage?]?, media_pram : String?, video_url_Up_Arr: [URL?]? , with type:T.Type, completion: @escaping (Bool,T?) -> ())
    {
        
        
        let encoder = JSONEncoder()
        
        
        loader.showLoader()
        
        Service.sharedInstance.get_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let dictResponse):
                
                if  dictResponse["status"] as! NSNumber == 1
                {
                    
                    do
                    {
                        let model = try JSONDecoder().decode(type, from: dictResponse.dict2json())
                        completion(true, model)
                    }
                    catch
                    {
                        
                        print(error)
                        // Alert.show(vc: vc, titleStr: Alert.kmsg, messageStr: Alert.Try_agn_msg)
                        completion(false,  encoder as? T)
                    }
                    
                }
                if  dictResponse["status"] as! NSNumber == 0
                {
                    self.status_Mathod(data: dictResponse)
                    completion(false, encoder as? T)
                    //  Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_stutas.message)
                }
                
            case .failure(let error):
                print(error)
                completion(false, encoder as? T)
            }
            
        }
        
    }
    //MARK:- getMathod
    
  func get_Mathod_Request(vc: UIViewController, dictPram: [String: String], methodName: String , completion: @escaping (Bool) -> ())
    {
        
        let globel_var  =  GlobalVariables.sharedManager
        
        loader.showLoader()
        
        Service.sharedInstance.get_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let data):
            
            if  data["status"] as! NSNumber == 1
            {
              /*  self.status_Mathod(data: data)
                
                if let data_Con : NSArray =  (data["packages"] as? NSArray)
                {
                    do
                    {
                        globel_var.packages_Arr = try JSONDecoder().decode([Get_Packages_Struct].self , from: data_Con.arr2json())
                        
                        completion(true)
                        
                        
                    }
                    catch
                    {
                        Alert.show(vc: vc, titleStr: Alert.W_msg, messageStr: Alert.W_Par_Er)
                        print(error)
                        completion(false)
                        
                        
                    }
                }
               
                */
            }
            /*else if  data["status"] as! NSNumber == 0{
                
                self.status_Mathod(data: data)
                Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_Status.message)
                
                completion(false)
            }
            */
            
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }
    

    
    /*
    
    //MARK: -  get_comments
    // comment // postID // user_id // content
    // get_comments // postID //  user_id

    // This mathod will get both send comment and get comment api handle
    func post_Comment_Request(vc: UIViewController, dictPram: [String: String], methodName: String , completion: @escaping (Bool) -> ())
    {
        
        let globel_var  =  GlobalVariables.sharedManager
        
        print(dictPram)
        loader.showLoader()
        Service.sharedInstance.post_web_Service_Mathod(vc: vc, dictPram: dictPram, methodName: methodName) { (connectionResult) in
            switch connectionResult {
            case .success(let data): print(data)
            print(data)
            let dictResponse = data
            print(data.dict2json())
            
            if  dictResponse["status"] as! NSNumber == 1
            {
                if dictResponse["data"] == nil
                {
                
                loader.hideLoader()
                    loader.stopTimer()
                self.status_Mathod(data: data)
                completion(true)
                
                }
                else
                {
                    let data_Con : NSArray =  (dictResponse["data"] as? NSArray)!
                    
                    do {
                        
                        globel_var.all_comments_Arr = try JSONDecoder().decode([Get_all_comments_Struct].self , from: data_Con.arr2json())
                        loader.hideLoader()
                        loader.stopTimer()
                        completion(true)
                        
                    }
                    catch
                    {
                        print(error)
                        completion(false)
                        loader.hideLoader()
                        loader.stopTimer()
                        
                    }
                    
                }
                
            }
            else if  dictResponse["status"] as! NSNumber == 0
                
            {
                loader.hideLoader()
                loader.stopTimer()
                
                self.status_Mathod(data: data)
                Alert.show(vc: vc, titleStr: "Message", messageStr: globel_var.get_stutas.message)
                
                completion(false)
                }
                
            case .failure(let error): print(error)
            completion(false)
            }
            
        }
        
    }*/
    
    /*func delete_Event_Mathod(  api_key : String! , media_V_str : String? , vid_url : URL? , media_Img_str : String? , ima_Ob : UIImage? , event_id : String! , vc : UIViewController )
    {
        let global_Var  =  GlobalVariables.sharedManager
        
        let parameters : [String : String] = ["user_id":global_Var.myUserId , "event_id":event_id, "function_id":global_Var.fun_Id]
        
        print(parameters)
        
        createFunction_Reqest(vc: vc, dictPram: parameters, methodName: api_key, img_pram: media_Img_str, imageUpload_Arr: [ima_Ob], media_pram: media_V_str , video_url_Up_Arr : [vid_url] , completion : { (success) -> Void in if success
        {
            
            let alert = UIAlertController(title: Alert.W_msg, message: global_Var.get_Status.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                global_Var.reloade_Bol = false
                vc.navigationController?.popViewController(animated: true)
            }))
            
            vc.present(alert, animated: true, completion: nil)
        }
        else
        {
            print("false")
            }
        })
        
    }*/
    
    
    
    
    //MARK: - Save User Default Data
    
    func save_Data_NsUser_Default(  vc : UIViewController , dic_Data : NSDictionary! )
    {
        
        if let dicData = dic_Data
        {
            let data = NSKeyedArchiver.archivedData(withRootObject: dicData )
            UserDefaults.standard.set( data , forKey:"FabCustomer")
            
        }
        
        
        /*if  let outData = UserDefaults.standard.data(forKey: "KeyMarket")
        {
            if  let dict = NSKeyedUnarchiver.unarchiveObject(with: outData)
            {
                let dic_Code : NSDictionary = dict as! NSDictionary
                
                do
                {
                    globel_var.user_Authonti_Dic = try JSONDecoder().decode(Get_User_Authontication_Struct.self , from: dic_Code.dict2json())
                    
                    
                }
                catch
                {
                    
                    let alert = UIAlertController(title: Alert.W_msg, message: "EnCodeble Error", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        
                        
                    }))
                    
                    vc.present(alert, animated: true, completion: nil)
                    
                }
                
            }
            
        }*/
        
    }

    
    //MARK: - Get User Default Data
    func get_Data_NsUser_Default(vc : UIViewController  , completion: @escaping (Bool) -> ()){
        
        if  let outData = UserDefaults.standard.data(forKey: "FabCustomer") //WEDDING
        {
           
            do {
               
                if   let dic = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(outData)
                {
                    let dic_Code : NSDictionary = dic as! NSDictionary
                    
                    do
                    {
                        SignUpDataClass.shareMngr.signUpData = try JSONDecoder().decode(Get_SignUp_Struct.self , from: dic_Code.dict2json())
                        
                   
                        if let useID = SignUpDataClass.shareMngr.signUpData?.SignUdata?.user_id
                        {
                            GlobalVariables.sharedManager.user_id = useID
                        
                            loader.hideLoader()
                            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: vc)
                        }
                        //globel_var.signUp_Dic =
                        completion(true)
                    }
                    catch
                    {
                        
                        let alert = UIAlertController(title: Alert.msg, message: Alert.Try_agn_msg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            completion(false)
                            
                        }))
                        
                        vc.present(alert, animated: true, completion: nil)
                        
                    }
                    
                }
                else
                {
                    completion(false)
                }
            } catch {
                //handle error
                print(error)
            }
            
            
            
        }
        else
        {
            completion(false)
        }
        
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
  
    
    
    // Load any kind of codable objects
    func load_Dic <T:Decodable> (_  data_Send : NSDictionary?  ,vc: UIViewController  , with type:T.Type) -> T? {
       
         let encoder = JSONEncoder()
        if let data = data_Send {
            do {
                let model = try JSONDecoder().decode(type, from: data.dict2json())
                return model
            }catch{
                
                Alert.show(vc: vc, titleStr: Alert.msg, messageStr: Alert.Try_agn_msg)
                return encoder as? T
               // fatalError(error.localizedDescription)
            }
            
        }else{
            
            Alert.show(vc: vc, titleStr: Alert.msg, messageStr: Alert.Try_agn_msg)
            return encoder as? T
         // fatalError("Data unavailable at path ")
        }
        
    }
    // Load any kind of codable objects // static
    func load_Arr <T:Decodable> (_  data_Send : NSArray?,vc: UIViewController , with type:T.Type) -> T? {
        
         let encoder = JSONEncoder()
        if let data = data_Send {
            do {
                
                let model = try JSONDecoder().decode(type, from: data.arr2json())
                return model
                
            }
            catch
            {
                Alert.show(vc: vc, titleStr: Alert.msg, messageStr: Alert.Try_agn_msg)
                return encoder as? T
                // fatalError(error.localizedDescription)
            }
            
            
        }else{
            Alert.show(vc: vc, titleStr: Alert.msg, messageStr: Alert.Try_agn_msg)
            return encoder as? T
            // fatalError(error.localizedDescription)
            
        }
        
    }
    
//    // Load any kind of codable objects // static
//     func load_Arr <T:Decodable> (_  data_Send : NSArray?  , with type:T.Type, completion: @escaping (Bool) -> ()) -> T {
//
//
//        if let data = data_Send {
//            do {
//                let model = try JSONDecoder().decode(type, from: data.arr2json())
//                return model
//
//            }catch{
//                completion(false)
//                fatalError(error.localizedDescription)
//
//
//
//            }
//            completion(true)
//
//        }else{
//            completion(false)
//            fatalError("Data unavailable at path ")
//
//        }
//
//    }
 
    
}
extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
