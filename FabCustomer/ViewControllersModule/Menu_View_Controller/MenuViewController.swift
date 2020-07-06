//
//  MenuViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit


class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  , UIAlertViewDelegate{
    
    class func viewController() -> MenuViewController {
        return "Main".viewController("MenuViewController") as! MenuViewController
    }
    
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    /*var dealItemsImage = ["sideHome.png","sideChat.png","sideBooking.png","JObsB","AppoinemtSide","sideNotification.png","history","coupon","settingsProfile","sideProfile.png","Lang_Img","sideProfile.png"]*/

    // globel variable object
    let globel_variable = GlobalVariables.sharedManager
    
    
    var arrayMenuOptions = [Dictionary<String,String>]()
    var arrayMenuOptions1 = [Dictionary<String,String>]()
    var arrayMenuOptions2 = [Dictionary<String,String>]()
    var arrayMenuOptions3 = [Dictionary<String,String>]()
    
    
    @IBOutlet var tblMenuOptions : UITableView!
    
    /**
     *  Transparent button to hide menu
     */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
     *  Array containing menu options
     */
    
    
    /**
     *  Menu button which was tapped to display the menu
     */
    
    
    /**
     *  Delegate of the MenuVC
     */
    var window: UIWindow?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.dataSource = self
        tblMenuOptions.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        updateArrayMenuOptions()
        tblMenuOptions.reloadData()
        
        tblMenuOptions.tableFooterView = UIView()
    }
    
   
    
    func updateArrayMenuOptions(){
        
        
            arrayMenuOptions.removeAll()
            arrayMenuOptions1.removeAll()
            arrayMenuOptions2.removeAll()
            arrayMenuOptions3.removeAll()
        
        
        arrayMenuOptions.append(["title":"Home", "icon":"sideHome.png","vc_Str":"ViewController"])//0
        arrayMenuOptions.append(["title":"Chats", "icon":"sideChat.png","vc_Str":"Chating_Home_VContr"])//1
        arrayMenuOptions.append(["title":"Invoice", "icon":"history","vc_Str":"HistoryVC"])//6
        
        
        arrayMenuOptions1.append(["title":"My Bookings", "icon":"sideBooking.png","vc_Str":"BookingViewController"])//22
        arrayMenuOptions1.append(["title":"Post Job", "icon":"JObsB","vc_Str":"JobS_ViewCont"])//3
     
        arrayMenuOptions2.append(["title":"Wallet", "icon":"subScr_Img", "vc_Str":"Wallet_ViewCont"])//88
        arrayMenuOptions2.append(["title":"Profile Settings", "icon":"settingsProfile","vc_Str":"ProfileSettingViewController"])//8
        
        arrayMenuOptions3.append(["title":"Notifications", "icon":"sideNotification.png","vc_Str":"NotificationVC"])//5
        arrayMenuOptions3.append(["title":"Get Offer", "icon":"coupon","vc_Str":"DiscountVC"])//7
        arrayMenuOptions3.append(["title":"Support", "icon":"sideProfile.png","vc_Str":"SupportViewController"])//9
        
      
       tblMenuOptions.reloadData()
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!)
    {
        close_Menu_Mathod(button)
    }
    
    //Note - close menu mathod
    func close_Menu_Mathod(_ button:UIButton!)
    {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        navigationController?.view.layer.add(transition, forKey: nil)
        _ = navigationController?.popViewController(animated: false)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        }
        else if section == 1  {
            return arrayMenuOptions.count
        }
        else if section == 2  {
            return arrayMenuOptions1.count
        }
        else if section == 3  {
            return arrayMenuOptions2.count
        }
        else if section == 4  {
            return arrayMenuOptions3.count
        }
        return  0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0
        {
            let cell:MenuViewControllerProfileCell = tableView.dequeueReusableCell(withIdentifier: "MenuViewControllerProfileCell", for: indexPath) as! MenuViewControllerProfileCell
            
            // print(globel_variable.user_Login_dictionary)
            if SignUpDataClass.shareMngr.signUpData?.SignUdata?.image != ""
            {
                if  let image_url = SignUpDataClass.shareMngr.signUpData?.SignUdata?.image
                {
                    cell.image_Profile.sd_setImage(with: URL(string:image_url ), placeholderImage:UIImage(named: "profile-dummy") )
                    cell.image_Profile.layer.cornerRadius = cell.image_Profile.frame.width / 2;
                    cell.image_Profile.layer.masksToBounds = true;
                }
            }
            
            if let str_Name = SignUpDataClass.shareMngr.signUpData?.SignUdata?.name
            {
                cell.name_Label.text = str_Name.capitalized
                cell.email_Label.text =  SignUpDataClass.shareMngr.signUpData?.SignUdata?.email_id
            }
            
            return cell
        }
        else if indexPath.section == 1  {
            
            let cell:MenuViewControllerCell = tableView.dequeueReusableCell(withIdentifier: "MenuViewControllerCell", for: indexPath) as! MenuViewControllerCell
           
                
                
                cell.lblTitle.backgroundColor = UIColor.clear
                cell.lblline.isHidden = false
                
                if indexPath.row == 10
                {
                    cell.lblline.isHidden = true
                }
                cell.imageSide.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
                
            
            cell.lblTitle.text = defaultLocalizer.stringForKey(key: arrayMenuOptions[indexPath.row]["title"]! )
            return cell
        }        else if indexPath.section == 2  {
            
            let cell:MenuViewControllerCell = tableView.dequeueReusableCell(withIdentifier: "MenuViewControllerCell", for: indexPath) as! MenuViewControllerCell
                cell.lblTitle.backgroundColor = UIColor.clear
                cell.lblline.isHidden = false
                if indexPath.row == 10
                {
                    cell.lblline.isHidden = true
                }
                cell.imageSide.image = UIImage(named: arrayMenuOptions1[indexPath.row]["icon"]!)
                cell.lblTitle.text = defaultLocalizer.stringForKey(key: arrayMenuOptions1[indexPath.row]["title"]! )
            return cell
        }else if indexPath.section == 3  {
            let cell:MenuViewControllerCell = tableView.dequeueReusableCell(withIdentifier: "MenuViewControllerCell", for: indexPath) as! MenuViewControllerCell
                cell.lblTitle.backgroundColor = UIColor.clear
                cell.lblline.isHidden = false
                if indexPath.row == 10
                {
                    cell.lblline.isHidden = true
                }
                cell.imageSide.image = UIImage(named: arrayMenuOptions2[indexPath.row]["icon"]!)
                cell.lblTitle.text = defaultLocalizer.stringForKey(key: arrayMenuOptions2[indexPath.row]["title"]! )
                return cell
        }        else if indexPath.section == 4  {
            
            let cell:MenuViewControllerCell = tableView.dequeueReusableCell(withIdentifier: "MenuViewControllerCell", for: indexPath) as! MenuViewControllerCell
           
                cell.lblTitle.backgroundColor = UIColor.clear
                cell.lblline.isHidden = false
                if indexPath.row == 10
                {
                    cell.lblline.isHidden = true
                }
                cell.imageSide.image = UIImage(named: arrayMenuOptions3[indexPath.row]["icon"]!)
            
            cell.lblTitle.text = defaultLocalizer.stringForKey(key: arrayMenuOptions3[indexPath.row]["title"]! )
            return cell
        } else {
            
            let cell:MenuViewControllerCell = tableView.dequeueReusableCell(withIdentifier: "MenuViewControllerCell", for: indexPath) as! MenuViewControllerCell
                cell.lblTitle.backgroundColor = UIColor.clear
                cell.lblline.isHidden = false
                if indexPath.row == 10
                {
                    cell.lblline.isHidden = true
                }
                cell.imageSide.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
            
            cell.lblTitle.text = defaultLocalizer.stringForKey(key: arrayMenuOptions[indexPath.row]["title"]! )
            return cell
        }
      
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let myView = UIView()
        if section  == 1
        {
            head_Mathod(heder_Label_Str:"   " + defaultLocalizer.stringForKey(key:"Home Features"), header_View: myView, height_in: 30.0)
            
        }
        if section  == 2
        {
            
            head_Mathod(heder_Label_Str: "   " + defaultLocalizer.stringForKey(key:"Bookings & Jobs"), header_View: myView, height_in: 30.0)
            
        }
        if section  == 3
        {
            
            head_Mathod(heder_Label_Str: "   " + defaultLocalizer.stringForKey(key:"Personal"), header_View: myView, height_in: 30.0)
            
        }
        if section  == 4
        {
            head_Mathod(heder_Label_Str: "   " + defaultLocalizer.stringForKey(key:"Other"), header_View: myView, height_in: 30.0)
        }
        
        return myView
    }
    func head_Mathod(heder_Label_Str:String! , header_View:UIView! , height_in:CGFloat! )
    {
        
        let title_Header_Label = UILabel()
        title_Header_Label.font =  UIFont.boldSystemFont(ofSize: 18.0)
        title_Header_Label.frame = CGRect(x: 10, y: 1, width: self.view.frame.width-20, height: height_in)
        title_Header_Label.text  = heder_Label_Str// "  ANNIVERSERY"
        title_Header_Label.textColor =  UIColor.white
        title_Header_Label.backgroundColor =  UIColor.clear
        header_View.addSubview(title_Header_Label)
        let line_Label = UILabel()
        line_Label.textColor = UIColor.clear
        line_Label.font =  UIFont.boldSystemFont(ofSize: 0.0)
        line_Label.backgroundColor = UIColor.clear
        ///height_in+2
        line_Label.frame = CGRect(x: 5, y: height_in+2 , width: self.view.frame.width-10, height: 0.5)
        header_View.addSubview(line_Label)
        header_View.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height_in )
        header_View.backgroundColor = UIColor.clear
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myView = UIView()
        
        
        myView.frame = CGRect(x: 0, y: 0, width: 200, height: 10 )
        myView.backgroundColor = UIColor.clear
        
        let line_Label = UILabel()
        line_Label.textColor = UIColor.clear
        line_Label.font =  UIFont.boldSystemFont(ofSize: 0.0)
        line_Label.backgroundColor = Constant.line_Color
        ///height_in+2
        line_Label.frame = CGRect(x: 5, y: 2 , width: self.view.frame.width-10, height: 0.5)
        myView.addSubview(line_Label)
        
        
        return myView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        
        if section  == 0
        {
            return 10
        }
        else if section  == 1
        {
            return 10
        }
        else if section  == 3
        {
            return 10
        }
        else if section  == 2
        {
            return 10
        }
        
        return 00
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section  == 0
        {
            return 40
        }
        else if section  == 1
        {
            return 40
        }
        else if section  == 2
        {
            return 40
        }
        else if section  == 3
        {
            return 40
        }
        else if section  == 4
        {
            return 40
        }
        return 40
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
            return 122
        }
        else
        {
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
      //  var rootVC_Identifire =  ""
        // get in profile edit
        if indexPath.section == 0
        {
            
             moveNext( rootVC_Identifire : "ProfileSettingViewController" )
            
          
        }
        else if indexPath.section == 1
        {
            let dic = arrayMenuOptions[indexPath.row]
            
            if let vc_Str =  (dic["vc_Str"])
            {
                moveNext( rootVC_Identifire : vc_Str )
            }
            
        }
        else if indexPath.section == 2
        {
            let dic = arrayMenuOptions1[indexPath.row]
            
            if let vc_Str =  (dic["vc_Str"])
            {
                moveNext( rootVC_Identifire : vc_Str )
            }
        }
        else if indexPath.section == 3
        {
            let dic = arrayMenuOptions2[indexPath.row]
            
            if let vc_Str =  (dic["vc_Str"])
            {
                moveNext( rootVC_Identifire : vc_Str )
            }
        }
        else if indexPath.section == 4
        {
            let dic = arrayMenuOptions3[indexPath.row]
            
            if let vc_Str =  (dic["vc_Str"])
            {
                moveNext( rootVC_Identifire : vc_Str )
            }
        }
        
    }
    
    func moveNext( rootVC_Identifire : String! )
    {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainVC = SJSwiftSideMenuController()
        
        let sideVC_L : MenuViewController = (storyBoard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController)!
        
        let rootVC = storyBoard.instantiateViewController(withIdentifier: rootVC_Identifire) as UIViewController
        
        SJSwiftSideMenuController.setUpNavigation(rootController: rootVC, leftMenuController: sideVC_L,  leftMenuType: .SlideOver, rightMenuType: .SlideView)
        SJSwiftSideMenuController.enableSwipeGestureWithMenuSide(menuSide: .LEFT)
        SJSwiftSideMenuController.enableDimbackground = true
        //  SJSwiftSideMenuController.leftMenuWidth = self.view.frame.width-100
        //=======================================
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = mainVC
        appDelegate.window?.makeKeyAndVisible()
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
    
    @IBAction func artist_Action(_sender : UIButton)
    {
        let _VC:ViewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(_VC, animated: true)
    }
    
    func nOAction()
    {
        
    }
    
    func yesAction()
    {
        let LoginVC:LoginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(LoginVC, animated: true)
    }
    
}


