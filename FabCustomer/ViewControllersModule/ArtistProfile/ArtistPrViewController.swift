//
//  ArtistPrViewController.swift
//  FabArtist
//
//  Created by AmitSharma on 14/06/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit

protocol udpateFebMathod {
    func mathodFeavUpdate()
    
}


class ArtistPrViewController: UIViewController {
    
    class func viewController() -> ArtistPrViewController {
        return "Main".viewController("ArtistPrViewController") as! ArtistPrViewController
    }

    var delegate : udpateFebMathod?
     var get_artist_id : String!
    
    var artistDis =  ArtistProfileStruct2()
    
    
    var tapOptionArr = [Dictionary<String,String>]()
     var profileViewHeight : NSLayoutConstraint!
    
     var imageViewHeight : NSLayoutConstraint!
    
     var profileView : UIView!

    @IBOutlet weak var artistTableView: UITableView!
    var selectedInd = 0
    var tabCollectionView  : UICollectionView!
    
    var menuCollectionView  : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mathodLoadOptionArray()
        let nib = UINib(nibName: "info_TableViewCell" , bundle: nil)
        artistTableView.register(nib, forCellReuseIdentifier: "info_TableViewCell")
        let nib2 = UINib(nibName: "ImageTableViewCell" , bundle: nil)
        artistTableView.register(nib2, forCellReuseIdentifier: "ImageTableViewCell")

        artistTableView.dataSource = self
        artistTableView.delegate = self
        
        load_MainData()
        
        
        app_delegate.navi_obj =  self.navigationController
        app_delegate.story_obj = self.storyboard
        
    }
    
    func mathodLoadOptionArray()
    {
        
        tapOptionArr.removeAll()
        tapOptionArr.append(["title":"Info" ])
        //tapOptionArr.append(["title":"Services" ])
        tapOptionArr.append(["title":"Gallery" ])
        tapOptionArr.append(["title":"Works" ])
        tapOptionArr.append(["title":"Reviews" ])
    }
    
    
    
    override  func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         //create_Navigation_Bar_Mathod()
        if let image : UIImage = UIImage(named: "menu") {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
            //  SJSwiftSideMenuController .showRightMenuNavigationBarButton(image: image)
        }
        //navigationbarSetUp()
        create_Navigation_Bar_Mathod()
    }
    let titleLabel = UILabel()
    
    //MARK:- Custom Method
    func navigationbarSetUp() {
        
        
        self.navigationController?.navigationBar.isTranslucent = false
       // self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        
        let image = UIImage(named: "Header_bar")
        self.navigationController?.navigationBar.setBackgroundImage(image,for: .default)
        
       
        titleLabel.text = "Artist Profile"
        titleLabel.font =  UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.sizeToFit()
        titleLabel.textColor =  UIColor.white
        titleLabel.backgroundColor =  UIColor.clear
        
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
       
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.setHidesBackButton(true, animated:false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let image : UIImage = UIImage(named: "menu") {
            SJSwiftSideMenuController .showLeftMenuNavigationBarButton(image: image, sh_Bool: false)
            //  SJSwiftSideMenuController .showRightMenuNavigationBarButton(image: image)
        }
        
    }
    
    
    
    let left_B = UIButton()
    let right_B = UIButton()
    func create_Navigation_Bar_Mathod()
    {
        
        left_B.addTarget(self, action: #selector(self.left_Mathod_Action(_:)), for: .touchUpInside)
        Set_Navigation_Bar_Class.sharedInstance.navigation_bar_Set_Up(vc: self, left_B_Img:UIImage(named: "back2"), left_title_Str: nil, right_B_Img:nil, right_title_Str: nil, title_Str: "Artist Profile", hidden_Nav: false, left_Button: left_B , right_Button: nil)
        
    }
    
    @IBAction func left_Mathod_Action( _ sender : UIButton!)
    {
        if let image : UIImage = UIImage(named: "menu")
        {
            SJSwiftSideMenuController.showLeftMenuNavigationBarButton(image: image, sh_Bool: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func load_MainData()
    {
        let parameters : [String : String] = ["artist_id":  get_artist_id , "user_id":  GlobalVariables.sharedManager.user_id]
        
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getArtistByid, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: ArtistProfileStruct2.self  , completion : {(success, modelVal) -> Void in if success
        {
            self.artistDis = modelVal!
            print(modelVal!)
            loader.hideLoader()
            self.artistTableView.reloadData()
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })
        
    }
    
    func createTabBarMathod(header_View: UIView , height_in : CGFloat!  )
    {
        if tabCollectionView == nil
        {
            
            header_View.frame = CGRect(x: 10, y: 0, width: self.view.frame.width-20, height: height_in )
            header_View.backgroundColor = UIColor.white
            
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: self.view.frame.width/4, height: 40)
            
            tabCollectionView = UICollectionView(frame: header_View.frame, collectionViewLayout: layout)
            /*tabCollectionView.showsHorizontalScrollIndicator = true
            tabCollectionView.showsVerticalScrollIndicator = true
            tabCollectionView.indicatorStyle =  UIScrollViewIndicatorStyle.black*/
            
           // tabCollectionView = UICollectionView(frame: header_View.frame)
            tabCollectionView?.frame = CGRect(x: 10, y: 0, width: header_View.frame.width, height: header_View.frame.height)
            
            header_View.backgroundColor = UIColor.white
            tabCollectionView.backgroundColor = UIColor.white
            header_View.addSubview(tabCollectionView!)
            Register_Nib_With_Delegate.sharedInstance.register_Collection_Mathod(vc: self, collectionV_Name: tabCollectionView!, Coll_cell_Iden: "TapOptionCollectionViewCell")
            app_delegate.tap_collectionVC = self
        }
        else
        {
            header_View.frame = CGRect(x: 10, y: 0, width: self.view.frame.width-20, height: height_in )
            header_View.backgroundColor = UIColor.white
            
            let layout = UICollectionViewFlowLayout()
            
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.itemSize = CGSize(width: self.view.frame.width/4, height: 40)
            tabCollectionView = UICollectionView(frame: header_View.frame, collectionViewLayout: layout)
            // tabCollectionView = UICollectionView(frame: header_View.frame)
            tabCollectionView?.frame = CGRect(x: 10, y: 0, width: header_View.frame.width, height: header_View.frame.height)

            header_View.addSubview(tabCollectionView!)
            header_View.backgroundColor = UIColor.white
            header_View.backgroundColor = UIColor.white
            tabCollectionView.backgroundColor = UIColor.white
            Register_Nib_With_Delegate.sharedInstance.register_Collection_Mathod(vc: self, collectionV_Name: tabCollectionView!, Coll_cell_Iden: "TapOptionCollectionViewCell")
        }
    }
    @IBOutlet weak var chatBT : UIButton!
    @IBOutlet weak var bookBT : UIButton!
    @IBOutlet weak var servicesBT : UIButton!
   
    @IBAction func chat_book_services_Action(_ sender : UIButton!)
    {
        switch sender {
        case chatBT:
            let ch_VC:Chat_VCont = Chat_VCont.viewController()
            if let ids = self.artistDis.data.user_id
            {
                ch_VC.artist_id = ids
                ch_VC.user_id = GlobalVariables.sharedManager.user_id
                ch_VC.sender_name = self.artistDis.data.name!
                self.navigationController?.pushViewController(ch_VC, animated: true)
            }
            
            break;
        case bookBT:
             let ch_VC:BookingInfoViewController = BookingInfoViewController.viewController()
             
             self.navigationController?.pushViewController(ch_VC, animated: true)
            break;
        case servicesBT:
            
            
            let nextVC:ServicesBookViewController = ServicesBookViewController.viewController()
            
            self.navigationController?.pushViewController(nextVC, animated: true)
            
            break;
        default:
            break;
        }
    }
    
}

extension ArtistPrViewController : UITableViewDataSource , UITableViewDelegate
{
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
          return 1
            
        }
        else
        {
           return 1
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            cell.updateImageDelegate = self
            
            if let gender = app_delegate.tap_collectionVC?.artistDis.data.fav_status//app_delegate.tap_collectionVC?.artistDis.data.gender
            {
                if  gender == "0"
                {
                    cell.favImgView.image      = UIImage(named: "heart_Emty")
                }
                else
                {
                    cell.favImgView.image    = UIImage(named: "heart_Ful")
                }
            }
            
            
            if let img = self.artistDis.data.banner_image
            {
                cell.bannerImgView.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "imagePLaceHolder"))
            }
            if  self.artistDis.data.is_online == "1"
            {
                cell.status_Label.text = "Online"
                //  cell.online_Off_Sell.isSelected = true
                cell.status_Label.text = "Online"
                // cell.online_Off_Sell.index = 1
                //    load_Switch( switch_Obj : cell.online_Off_Sell)
                // cell.online_Off_Sell.backgroundColor = UIColor.lightGray
                
            }
            else
            {
                // cell.online_Off_Sell.isSelected = false
                cell.status_Label.text = "Offline"
                // cell.online_Off_Sell.index = 0
                // cell.online_Off_Sell.isSelected = false
                cell.status_Label.text = "Offline"
                //   load_Switch( switch_Obj : cell.online_Off_Sell)
                //  cell.online_Off_Sell.backgroundColor = UIColor.darkGray
            }

            if let image = self.artistDis.data.image
            {
                cell.profileImgView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "profile-dummy"))
            }
            
            cell.deleteButton.tag = indexPath.row
            cell.changeButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(self.delete_Action(_:)), for: .touchUpInside)
            cell.changeButton.addTarget(self, action: #selector(self.change_Action(_:)), for: .touchUpInside)
            profileViewHeight   = cell.profileViewHeight
            imageViewHeight     = cell.imageViewHeight
            profileView         = cell.profileView
            cell.typeLabel.text = self.artistDis.data.name
            cell.typeDescriptionLabel.text = self.artistDis.data.category_name
            cell.addLabel.text = self.artistDis.data.location
            cell.infoLabel.text = self.artistDis.data.bio
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "info_TableViewCell", for: indexPath) as! info_TableViewCell
            
            cell.menu_CollectionView.reloadData()
            cell.artist_TableV = artistTableView
            self.menuCollectionView  = cell.menu_CollectionView
            return cell
        }
        

    }
    
    /*func load_Switch( switch_Obj : BetterSegmentedControl! )
    {
        Switch_Button_Class.sharedInstance.Switch_Mathod2( switch_Obj: switch_Obj)
    }*/
    @IBAction func delete_Action( _ sender : UIButton!)
    {
        
    }
    @IBAction func change_Action( _ sender : UIButton!)
    {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let myView = UIView()
        if section  == 1
        {
            createTabBarMathod(header_View: myView , height_in : 40.0  )
            //head_Mathod(heder_Label_Str: "   Bookings & Jobs", header_View: myView, height_in: 30.0)
        }
        /*if section  == 2
        {
            head_Mathod(heder_Label_Str: "   Home Features", header_View: myView, height_in: 30.0)
        }
        if section  == 3
        {
            head_Mathod(heder_Label_Str: "   Personal  ", header_View: myView, height_in: 30.0)
        }
        if section  == 4
        {
            head_Mathod(heder_Label_Str: "   Other ", header_View: myView, height_in: 30.0)
        }*/
        return myView
    }
    
    /*func head_Mathod(heder_Label_Str:String! , header_View:UIView! , height_in:CGFloat! )
    {
        
        let title_Header_Label = UILabel()
        title_Header_Label.font =  UIFont.boldSystemFont(ofSize: 18.0)
        title_Header_Label.frame = CGRect(x: 10, y: 1, width: self.view.frame.width-20, height: height_in)
        title_Header_Label.text  = heder_Label_Str// "  ANNIVERSERY"
        title_Header_Label.textColor =  UIColor.blue
        title_Header_Label.backgroundColor =  UIColor.red
        header_View.addSubview(title_Header_Label)
        let line_Label = UILabel()
        line_Label.textColor = UIColor.clear
        line_Label.font =  UIFont.boldSystemFont(ofSize: 0.0)
        line_Label.backgroundColor = UIColor.red
        ///height_in+2
        line_Label.frame = CGRect(x: 5, y: height_in+2 , width: self.view.frame.width-10, height: 0.5)
        header_View.addSubview(line_Label)
        header_View.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height_in )
        header_View.backgroundColor = UIColor.blue
        
    }*/
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section  == 0
        {
            return 0
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
        
        if indexPath.section  == 0
        {
            tableView.rowHeight = 360
            tableView.rowHeight = UITableView.automaticDimension
           if tableView.rowHeight < 360
           {
             tableView.rowHeight = 360
           
           }
            return tableView.rowHeight
            
        }
        else
        {
            tableView.rowHeight = self.view.frame.height-20
             return tableView.rowHeight
        }
       
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // tableView.parallaxHeader.height = CGFloat(indexPath.row * 10)
    }
    
    
}


extension ArtistPrViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    
    /*func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? Info_CollectionViewCell
        {
            self.menu_CollectionView_height.constant = collectionView.contentSize.height //cell.infoTableView.frame.height //...contentSize.height
        }
    }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         return tapOptionArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TapOptionCollectionViewCell", for: indexPath) as!  TapOptionCollectionViewCell
        
        //cell.delegate = self
        
        if  let title =  tapOptionArr[indexPath.row]["title"]
        {
            cell.nameLabel.text = title
           
            
           if selectedInd == indexPath.row
           {
            cell.nameLabel.textColor = UIColor.blue
            
            cell.lineLabel.backgroundColor = UIColor.blue
            
            }
            else
           {
             cell.nameLabel.textColor = UIColor.black
            cell.lineLabel.backgroundColor = UIColor.clear
            }
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return CGSize(width: collectionView.bounds.width/4, height: collectionView.bounds.height)// Set your item size here
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      
        print(indexPath.row)
        selectedInd  = indexPath.row
        self.menuCollectionView.scrollToItem(at:IndexPath(item: indexPath.row, section: 0), at: .right, animated: true)
        
        tabCollectionView.reloadData()
       // artistTableView.reloadData()
    }
    
}



/*extension ArtistPrViewController    : tapColorChange
{
    func tabselectMathod(cell: TapOptionCollectionViewCell) {
        //tabCollectionView.reloadData()
        cell.isSelected = true
    }
    

}*/


extension ArtistPrViewController    : UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = scrollView.contentOffset.y
        
        if y >= 350
        {
            app_delegate.infoScroll?.isScrollEnabled = true
            app_delegate.workreviCollection?.isScrollEnabled = true
            app_delegate.serviceCollection?.isScrollEnabled = true
            
            //app_delegate.tap_collectionVC?.artistTableView.scrollToLastCall(animated: true)
        }
        
        if imageViewHeight != nil
        {
            
            print(y/2)
            print(y/3)
            if y > 0
            {
                imageViewHeight.constant = 200 - (scrollView.contentOffset.y / 4)
            }
            else if y <= 0
            {
                imageViewHeight.constant = 200
                
            }
            
            if y > 0
            {
                profileViewHeight.constant = 160 - (scrollView.contentOffset.y / 3)
                
                if profileViewHeight.constant <= 110
                {
                     profileView.isHidden = true
                }
                else
                {
                     profileView.isHidden = false
                }
            }
            else if y <= 0
            {
                profileViewHeight.constant = 160
                
            }
            
        }
    }
}



/*extension ArtistPrViewController    : updatequalificationDelegate
{
    func updateQualificationMathod() {
        load_MainData()
    }
}
 */

extension ArtistPrViewController    : updatePersonalInfoDelegate
{
    func qualificationMathod(cell: Info_CollectionViewCell) {

        /* if let nextVc : QulificationViewController = self.storyboard?.instantiateViewController(withIdentifier: "QulificationViewController") as? QulificationViewController
            {
                nextVc.delegate  = self
                self.navigationController?.present(nextVc,animated: true  )
            }
        */
        
    }
    
    func updatePersonalInfo_save_Mathod(cell: Info_CollectionViewCell) {
        
        updatePertionalProfile(cell: cell)
    }
    
    func updatePersonalInfoMathod(cell: Info_CollectionViewCell) {
        
        
        if cell.femaleImgV.image == UIImage(named: "check")
        {
            
        }
        else
        {
            
        }
    }
    
    
}
extension ArtistPrViewController    : updateRateDelegate
{
    
    func updateRateMathod(cell: Info_CollectionViewCell) {
        
        
        
        
        /*
        if cell.online_Off_Sell.index == 0
        {
            let parameters : [String : String]  = ["artist_id": GlobalVariables.sharedManager.user_id , "artist_commission_type" :"1" ]
            loader.showLoader()
          
            rateMathodUpdate(key : Constant.kTo_changeCommissionArtist , parameters :parameters  )
           /* DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_changeCommissionArtist)*/
            
             load_MainData()
        }
        else
        {
            let parameters : [String : String]  = ["artist_id": GlobalVariables.sharedManager.user_id , "artist_commission_type" :"0"]
            
           
            rateMathodUpdate(key : Constant.kTo_changeCommissionArtist , parameters :parameters  )
            loader.showLoader()
           /* DPKWebOperation.WebServiceCalling(vc: self, dictPram: parameters, methodName: Constant.kTo_changeCommissionArtist)*/
        }*/
        
    /*
        
    }else{
   
    }*/
        
        
        
        
    }
    
    
    
    func updatePertionalProfile(cell: Info_CollectionViewCell)
    {
        
     /*
            
        if cell.nameTF.text?.isEmpty == true
        {
            Alert.showMiddleToast(message: Alert.kEmpty_Name, view_VC: self)
            return;
        }else if  cell.emailTF.text?.isEmpty == true
        {
            Alert.showMiddleToast(message: Alert.kEmpty_Email, view_VC: self)
            return;
        }
        else if  cell.numberTF.text?.isEmpty == true
        {
            Alert.showMiddleToast(message: Alert.kEmpty_num, view_VC: self)
            return;
        }
        else if  cell.gender_Str.isEmpty == true
        {
            
            Alert.showMiddleToast(message: Alert.gender_msg, view_VC: self)
            return;
        }
            else
            {
                
              let parameters  = ["user_id":  GlobalVariables.sharedManager.user_id, "name" : cell.nameTF.text! , "email_id" :cell.emailTF.text! ,"gender":cell.gender_Str ,"mobile":cell.numberTF.text! ]
                
                Revoke_Service_Class.sharedInstance.create_SignUp_Reqest(vc: self, dictPram: parameters, methodName: Constant.kTo_editPersonalInfo , img_pram: nil , imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil  , completion : {(success) -> Void in if success
                {
                    
                    
                    Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                
                    loader.hideLoader()
                    
                }
                else
                {
                      Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                    loader.hideLoader()
                    
                    }
                })
                
                
            }
            */
        
    }
    func rateMathodUpdate(key : String , parameters : [String : String])
    {
       
        
       /* Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: key, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            
          
            
            print(modelVal!)
            loader.hideLoader()
            self.load_MainData()
          //  self.artistTableView.reloadData()
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })*/
        
    }
    
}
/*extension ArtistPrViewController    : qualificationAddDelegate
{
   
    
}*/

extension ArtistPrViewController    :  updateImageDelegate
{
    
    func editMathod(cell: ImageTableViewCell) {
        
        
        if cell.favImgView.image == UIImage(named: "heart_Emty")
        {
            if app_delegate.tap_collectionVC?.artistDis.data.user_id != nil
            {
                fav_Mathod_Action(api_Key : Constant.kTo_add_favorites , artistId: app_delegate.tap_collectionVC?.artistDis.data.user_id! )
            }
        }
        else  if cell.favImgView.image == UIImage(named: "heart_Ful")
        {
            if app_delegate.tap_collectionVC?.artistDis.data.user_id != nil
            {
            fav_Mathod_Action(api_Key : Constant.kTo_remove_favorites , artistId: app_delegate.tap_collectionVC?.artistDis.data.user_id! )
            }
        }
        
       /* if feb_Check == true
        {
            fav_Mathod_Action(api_Key: Constant.kTo_remove_favorites, celll: cell)
            
        }
        else if feb_Check == false
        {
            fav_Mathod_Action(api_Key: Constant.kTo_add_favorites, celll: cell)
            
        }
        */
    /*    if   let nextVc : EditPersonalViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditPersonalViewController") as? EditPersonalViewController
        {
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.moveIn;
            transition.subtype = CATransitionSubtype.fromTop
            navigationController?.view.layer.add(transition, forKey: CATransitionSubtype.fromTop.rawValue)
            navigationController?.pushViewController(nextVc, animated: false)
            
            //self.navigationController?.present(nextVc, animated: true)
        }*/
    }
    
   
    
    func fav_Mathod_Action(api_Key : String! , artistId: String! )
    {
        
        let parameters : [String : String] = [ "user_id":GlobalVariables.sharedManager.user_id, "artist_id" : artistId]
        
        loader.showLoader()
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: api_Key , img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_Stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            self.load_MainData()
            GlobalVariables.sharedManager.get_Status = modelVal!
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            self.delegate?.mathodFeavUpdate()
            self.artistTableView.reloadData()
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })
        
       /* if let id_str  = dataFromServerDict.value(forKey: "user_id") as? String
        {
         
            self.post_job_Request(vc: self, dictPram: parameters, methodName: api_Key, img_pram:nil , imageUpload_Arr: nil , media_pram: nil, video_url_Up_Arr: nil, completion : { (success) -> Void in // ,
                print("Second line of code executed")
                if success
                {
                    if self.feb_Check == true
                    {
                        celll.fav_ImageV.image = #imageLiteral(resourceName: "heart_Emty")
                        self.feb_Check = false
                        
                    }
                    else if self.feb_Check == false
                    {
                        celll.fav_ImageV.image = #imageLiteral(resourceName: "heart_Ful")
                        self.feb_Check = true
                        
                    }
                }
                else
                {
                    print("false")
                }
            })
        }*/
        
    }
    
    func onlineOffLineSegment(cell: ImageTableViewCell) {
        
      /*
        
        
        if  cell.online_Off_Sell.isSelected == true
        {
          
            cell.online_Off_Sell.isSelected = false
            cell.status_Label.text = "Offline"
            cell.online_Off_Sell.index = 0
            self.profile_Update(status: "0", api_key: Constant.kTo_onlineOffline)
            load_Switch( switch_Obj : cell.online_Off_Sell)
              cell.online_Off_Sell.backgroundColor = UIColor.darkGray
           
        }
        else
        {
            cell.online_Off_Sell.isSelected = true
            cell.online_Off_Sell.index = 1
            
            cell.status_Label.text = "Online"
            
            self.profile_Update(status: "1", api_key: Constant.kTo_onlineOffline)
            load_Switch( switch_Obj : cell.online_Off_Sell)
             cell.online_Off_Sell.backgroundColor = UIColor.lightGray
            
        }*/
    }
    
    
   
    
    
    
    func profile_Update( status : String!  , api_key : String! )
    {
       /* let parameters : [String : String] = ["user_id":GlobalVariables.sharedManager.user_id  , "is_online":status ]
        
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: api_key, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_stutas.self  , completion : {(success, modelVal) -> Void in if success
        {
            GlobalVariables.sharedManager.get_Status = modelVal!
             Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
        }
        else
        {
            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
            loader.hideLoader()
            
            }
        })*/
    }
    
    func deleteImageMathod(cell: ImageTableViewCell) {
       // cell.deleteButton.backgroundColor = UIColor.gray
       // cell.changeButton.setTitleColor(UIColor.white, for: .normal)
        
       /* Alert.alert_PopMathod(vc: self, title: Alert.msg, message_Str: Alert.msgDeleteProfile, action_Title: ["Ok" , "Cancel"], action_Style: [.default,.cancel] , action: [
            
            { ok in
                
                cell.profileImgView.image = UIImage(named: "profile-dummy")
                
                //  cell.deleteButton.backgroundColor =  UIColor(red: 0/255, green: 107/255, blue: 212/255, alpha: 1)
                // cell.deleteButton.setTitleColor(UIColor.white, for: .normal)
                
                let  parameters  = ["user_id":  GlobalVariables.sharedManager.user_id ]
                loader.showLoader()
                Revoke_Service_Class.sharedInstance.create_SignUp_Reqest(vc: self, dictPram: parameters, methodName: Constant.kTo_deleteProfileImage , img_pram: "image" , imageUpload_Arr: [cell.profileImgView.image] , media_pram: nil  , video_url_Up_Arr : nil  , completion : {(success) -> Void in if success
                {
                    
                    
                    loader.hideLoader()
                    
                }
                else
                {
                    
                    loader.hideLoader()
                    
                    }
                })
            },
            {
                Cancel in
                print("Cancel")
                
            }
            ]
            
            
        )*/
        
        
        
    }
    
    func saveImageMathod(cell: ImageTableViewCell) {
      //  cell.changeButton.backgroundColor = UIColor(red: 0/255, green: 107/255, blue: 212/255, alpha: 1)
     //   cell.changeButton.setTitleColor(UIColor.white, for: .normal)
        
     //   cell.deleteButton.backgroundColor = UIColor.gray
     //   cell.deleteButton.setTitleColor(UIColor.white, for: .normal)
        
       
        ImageAction.instance.cropFigureType = 1
        ImageAction.instance.cornerRadiousType = 30
        ImageAction.instance.showFullActionSheet(on: self){ (image) in
            
            cell.profileImgView.image = image
            
            
             let parameters  = ["user_id":   GlobalVariables.sharedManager.user_id ]
            loader.showLoader()
            
          
            if cell.profileImgView.image == UIImage(named: "profile-dummy")
            {
                Alert.show(vc: self, titleStr: "Message", messageStr:"Please select image to change.")
                
            }
            else
            {
                
                Revoke_Service_Class.sharedInstance.create_SignUp_Reqest(vc: self, dictPram: parameters, methodName: Constant.kTo_editPersonalInfo , img_pram: "image", imageUpload_Arr: [cell.profileImgView.image] , media_pram: nil  , video_url_Up_Arr : nil  , completion : {(success) -> Void in if success
                {
                    
                    
                  
                    loader.hideLoader()
                    
                }
                else
                {
                    
                    loader.hideLoader()
                    
                    }
                })
               
            }
            
        }
    }
    
}
extension ArtistPrViewController    :   deleteServiceGalleryDelegate
{
    func service_add_Mathod(cell: ServiceGallryCollectionViewCell) {
        
        /*if let nextVc : AddProduct_ViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddProduct_ViewController") as? AddProduct_ViewController
        {
            nextVc.delegate = self
            
            self.navigationController?.present(nextVc, animated: true)
        }*/
    }
    
    func gallery_add_Mathod(cell: ServiceGallryCollectionViewCell) {
        
        
       /* if let nextVc : AddGalleryViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddGalleryViewController") as? AddGalleryViewController
        {
             nextVc.delegate = self
            self.navigationController?.present(nextVc, animated: true)
        }*/
    }
    
    func serviceMathod(cell: ServiceGallryCollectionViewCell) {
        
        
        /*Alert.alert_PopMathod(vc: self, title: Alert.msg, message_Str: Alert.msgDeleteProduct, action_Title: ["Ok" , "Cancel"], action_Style: [.default,.cancel] , action: [
            
            {
                Ok in
                if let indVal = cell.slectdInd
                {
                    if let dic = app_delegate.tap_collectionVC?.artistDis.data.products?[indVal]
                    {
                        
                        let parameters : [String : String] = ["product_id":dic.id!]
                        loader.showLoader()
                        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_deleteProduct, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_stutas.self  , completion : {(success, modelVal) -> Void in if success
                        {
                            self.load_MainData()
                            GlobalVariables.sharedManager.get_Status = modelVal!
                            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                            loader.hideLoader()
                            self.artistTableView.reloadData()
                        }
                        else
                        {
                            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                            loader.hideLoader()
                            
                            }
                        })
                    }
                }
            },
            {
                Cancel in
                print("Cancel")
                
            }
            ]
            
            
        )
        */

        
    }
    
    func galleryMathod(cell: ServiceGallryCollectionViewCell) {
      
       /* Alert.alert_PopMathod(vc: self, title: Alert.msg, message_Str: Alert.deleteGallery, action_Title: ["Ok" , "Cancel"], action_Style: [.default,.cancel] , action: [
            
            {
                Ok in
                if let  indVal = cell.slectdInd
                {
                    if let dic = app_delegate.tap_collectionVC?.artistDis.data.gallery?[indVal]
                    {
                        let parameters : [String : String] =   ["id":dic.id!]
                        loader.showLoader()
                        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_deleteGallery, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_stutas.self  , completion : {(success, modelVal) -> Void in if success
                        {
                            self.load_MainData()
                            GlobalVariables.sharedManager.get_Status = modelVal!
                            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                            loader.hideLoader()
                            self.artistTableView.reloadData()
                        }
                        else
                        {
                            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                            loader.hideLoader()
                            
                            }
                        })
                    }
                }
            },
            {
                Cancel in
                print("Cancel")
                
            }
            ]
            
            
        )*/
        

    }
    

}
extension ArtistPrViewController    :   delete_edit_qualificationDelegate
{
    func deleteQulification(cell: Qualification_TableVCell) {
        
        /*Alert.alert_PopMathod(vc: self, title: Alert.kDelete_Qualification, message_Str: Alert.kQualification_Not_Select, action_Title: ["Ok" , "Cancel"], action_Style: [.default,.cancel] , action: [
            
            { ok in
                if let val_dic   =  app_delegate.tap_collectionVC?.artistDis.data.qualifications?[cell.delete_Button.tag]
                {
                    if let id_dele  = val_dic.id
                    {
                        
                        let parameters : [String : String] = ["qualification_id":id_dele]
                        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_deleteQualification, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_stutas.self  , completion : {(success, modelVal) -> Void in if success
                        {
                            self.load_MainData()
                            GlobalVariables.sharedManager.get_Status = modelVal!
                            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                            loader.hideLoader()
                            self.artistTableView.reloadData()
                        }
                        else
                        {
                            Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                            loader.hideLoader()
                            
                            }
                        })
                        
                        
                        
                        
                    }
                }
            },
            {
                Cancel in
                print("Cancel")
                
            }
            ]
            
            
        )
        */

        
        
    }
    
    func editQulification(cell: Qualification_TableVCell) {
        
        
        if let val_dic  =  app_delegate.tap_collectionVC?.artistDis.data.qualifications?[cell.edit_Button.tag]
        {
            if let id_dele  = val_dic.id
            {
               
              /*  if let nextVc : QulificationViewController = self.storyboard?.instantiateViewController(withIdentifier: "QulificationViewController") as? QulificationViewController
                {
                    
                    
                   nextVc.titleStr = cell.title_Label.text!
                   nextVc.desOb = cell.description_Label.text!
                   nextVc.qualiId = id_dele
                    
                   nextVc.mesengerObj = 1
                    
                    nextVc.delegate  = self
                    self.navigationController?.present(nextVc,animated: true  )
                }*/
                
                
                /*let parameters : [String : String] = [:]
                switch api_key {
                    
                case Constant.kTo_updateQualification:
                    
                    parameters = ["qulification_id":qulification_id , "title":title,"description":desc] as! [String : String]
                    break;
                case Constant.kTo_deleteQualification:
                    
                    parameters = ["qualification_id":qulification_id]
                    break;
                default:break;
                    
                }*/
                
               /* Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getArtistByid, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: Get_stutas.self  , completion : {(success, modelVal) -> Void in if success
                {
                    self.load_MainData()
                    GlobalVariables.sharedManager.get_Status = modelVal!
                    Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                    loader.hideLoader()
                    self.artistTableView.reloadData()
                }
                else
                {
                    Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                    loader.hideLoader()
                    
                    }
                })*/
                
                
        }
       
        }
        
    }
    
    
}

