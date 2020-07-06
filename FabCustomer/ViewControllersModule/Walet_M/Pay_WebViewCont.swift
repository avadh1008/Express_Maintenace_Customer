//
//  Pay_WebViewCont.swift
//  FabArtist
//
//  Created by apple on 14/11/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class Pay_WebViewCont: UIViewController , UIWebViewDelegate{
    
    class func viewController() -> Pay_WebViewCont {
        return "Main".viewController("Pay_WebViewCont") as! Pay_WebViewCont
    }

    var invoiceId = ""
    var otherUserId = ""
    var checkIndex = 0
    let globel_Var = GlobalVariables.sharedManager
    var amount_Str  = "00"
    let left_B = UIButton()
    let right_B = UIButton()
    
    
    var finished_Booking_Dic  = Get_invoice_struct()
    
    
    // payment_BaseUrl
    var str_Url : String?
    
    @IBOutlet weak var add_Mony_WebV : UIWebView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let image : UIImage = UIImage(named: "menu")  {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
            //  SJSwiftSideMenuController .showRightMenuNavigationBarButton(image: image)
        }
        // paypal paid
        if checkIndex == 1 {
            str_Url =  Constant.payment_BaseUrl+"Webservice/paypalWallent?amount="+"\(amount_Str)"+"&userId="+"\(globel_Var.user_id)" + "&invoice_id=" + "\(invoiceId)";
            
            
        } else if checkIndex == 2 { // strip payamet Other user Id
            
            str_Url  = Constant.payment_BaseUrl+"Stripe/Payment/make_payment/"+"\( otherUserId)/"+"\(amount_Str)"//+"&invoice_id="+"\(invoiceId)"
            
        } else if checkIndex == 3 { // paypal wallt add
            
            str_Url =  Constant.payment_BaseUrl+"Webservice/paypalWallent?amount="+"\(amount_Str)"+"&userId="+"\(globel_Var.user_id)";
            
            
        } else if checkIndex == 4 { // stripe wallet addd
            
              str_Url  = Constant.payment_BaseUrl+"Stripe/Payment/make_payment/"+"\(globel_Var.user_id)/"+"\(amount_Str)"
            
            
     
            
        }
        
        loader.showLoader()
        add_Mony_WebV.delegate = self
        if let strUrl = str_Url {
            let url = URL (string: strUrl)
            let requestObj = URLRequest(url: url!)
            add_Mony_WebV.loadRequest(requestObj)
            
            create_Navigation_Bar_Mathod()
        }
        
    }
    
    func create_Navigation_Bar_Mathod()
    {
        left_B.addTarget(self, action: #selector(self.left_Mathod_Action(_:)), for: .touchUpInside)
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "back2"), left_title_Str: nil, right_B_Img:nil, right_title_Str: nil, title_Str: "Payment", hidden_Nav: false, left_Button: left_B , right_Button: nil)
        
    }
    
    @IBAction func left_Mathod_Action( _ sender : UIButton!)
    {
        
        navigationController?.popViewController(animated: false)
    }
    
    internal func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        loader.showLoader()
        let currentLoadingUrl: String = (request.mainDocumentURL?.absoluteString)!
        print(currentLoadingUrl)
        return true
    }
    
    /*if currentLoadingUrl.containsString("<domain to check>"){
     return false
     }*/
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        loader.hideLoader()
        print(webView.request?.mainDocumentURL?.absoluteString as Any)
        let fileName = webView.request?.mainDocumentURL?.absoluteString as Any
        let fileArray = (fileName as AnyObject).components(separatedBy: "/")
        let status_Web = fileArray.last
        print(status_Web as Any)
        if status_Web == "success"
        {
            if checkIndex == 1 || checkIndex == 2 {
            payment_Request(  api_key : Constant.kTo_makePayment  , payment_type : "1"   )
            } else if checkIndex == 3 || checkIndex == 4 {
              payment_Request(  api_key : Constant.kTo_addMoney , payment : "1"   )
            }
            //  Alert.show(vc: self, titleStr: "Message", messageStr: "Payment Success.")
            
        }
        else if status_Web == "fail"
        {
            Alert.show(vc: self, titleStr: "Message", messageStr: "Please try after some time.")
        }
    }
    
    
    //MARK:-getMyTicket
    func payment_Request(  api_key : String! , payment : String!   )
    {
        
        let parameters : [String : String] = ["user_id":globel_Var.user_id , "amount":payment ]
        print(parameters)
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: api_key, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            self.globel_Var.get_Status = modelVal!
            Alert.showMiddleToast(message: self.globel_Var.get_Status.message, view_VC: self)
            loader.hideLoader()
        }
        else
        {
            Alert.showMiddleToast(message: self.globel_Var.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            
            }
        })
        
    }
    //1. Cash 0. Online 2. Wallet
    //MARK:-getMyTicket
    func payment_Request(  api_key : String! , payment_type : String!   )
    {
        
        /*
         user_id:15
         invoice_id:4PQC8AUDUXQR
         final_amount:49.5
         payment_type:1
         coupon_code:ADD10
         */
        var parameters : [String : String] = ["user_id":globel_Var.user_id  , "invoice_id":invoiceId, "final_amount":amount_Str, "payment_type":payment_type , "payment_status":"1","discount_amount":GlobalVariables.sharedManager.coupon_Status.discount_amount]
        
        if self.finished_Booking_Dic.coupon_code != ""
        {
            parameters["coupon_code"] = self.finished_Booking_Dic.coupon_code
        }
        
        
        
        print(parameters)
        
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: api_key, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            
            self.globel_Var.get_Status = modelVal!
            
            let review_Rating_ViewC : Review_Rating_ViewCont  = Review_Rating_ViewCont.viewController()
            review_Rating_ViewC.finished_Booking_Dic = self.finished_Booking_Dic
            
            self.navigationController?.pushViewController(review_Rating_ViewC, animated: true)
            
            // Alert.showMiddleToast(message: self.globel_Var.get_Status.message, view_VC: self)
            loader.hideLoader()
        }
        else
        {
            Alert.showMiddleToast(message: self.globel_Var.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            
            }
        })
        
    }
    
    
} /*{

    let  globel_Var = GlobalVariables.sharedManager
    var amount_Str : String = "00"
    let left_B = UIButton()
    let right_B = UIButton()
    
    @IBOutlet weak var add_Mony_WebV : UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image : UIImage = UIImage(named: "menu")  {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
            //  SJSwiftSideMenuController .showRightMenuNavigationBarButton(image: image)
        }
        
        let str_Url =   "http://phpstack-132936-677440.cloudwaysapps.com/Stripe/Payment/make_payment/"+"\(globel_Var.user_id)"+"/"+"\(amount_Str)";
        
        print(str_Url)
        loader.showLoader()
        add_Mony_WebV.delegate = self
        
        let url = URL (string: str_Url)
        let requestObj = URLRequest(url: url!)
        add_Mony_WebV.loadRequest(requestObj)
        
        create_Navigation_Bar_Mathod()
    }
    
    func create_Navigation_Bar_Mathod()
    {
        left_B.addTarget(self, action: #selector(self.left_Mathod_Action(_:)), for: .touchUpInside)
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "back2"), left_title_Str: nil, right_B_Img:nil, right_title_Str: nil, title_Str: "Payment", hidden_Nav: false, left_Button: left_B , right_Button: nil)
        
    }
    
    @IBAction func left_Mathod_Action( _ sender : UIButton!)
    {
       
        navigationController?.popViewController(animated: false)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        loader.showLoader()
        let currentLoadingUrl: String = (request.mainDocumentURL?.absoluteString)!
        print(currentLoadingUrl)
        return true
    }
    
    /*if currentLoadingUrl.containsString("<domain to check>"){
    return false
    }*/
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        loader.hideLoader()
        print(webView.request?.mainDocumentURL?.absoluteString as Any)
        let fileName = webView.request?.mainDocumentURL?.absoluteString as Any
        let fileArray = (fileName as AnyObject).components(separatedBy: "/")
        let status_Web = fileArray.last
        print(status_Web as Any)
        if status_Web == "success"
        {
            
            
            let alertController = UIAlertController(title: "Message", message: "Payment Success.", preferredStyle: UIAlertControllerStyle.alert)
            
            /*let nOAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default)
            {
                (result : UIAlertAction) -> Void in
                print("You pressed No")
            }*/
            let yesAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default)
            {
                (result : UIAlertAction) -> Void in
                print("You pressed yes")
               
                //self.navigationController?.popViewController(animated: false)
            }
            //alertController.addAction(nOAction)
            alertController.addAction(yesAction)
            self.present(alertController, animated: true, completion: nil)
            
           
        }
        else if status_Web == "fail"
        {
            Alert.show(vc: self, titleStr: "Message", messageStr: "Please try after some time.")
        }
    }

}*/
