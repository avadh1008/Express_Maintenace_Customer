
import UIKit

class CategoryNewViewController: UIViewController {
    
    class func viewController() -> CategoryNewViewController {
        return "Main".viewController("CategoryNewViewController") as! CategoryNewViewController
    }
    
    var artists_Dic = AllArtists_Struct()
    
    @IBOutlet weak var lblCat: UILabel!
    @IBOutlet weak var lblNoData: UILabel!
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    @IBOutlet weak var artist_TableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.blue
        
        return refreshControl
    }()
    
    var cat_id = ""
    let globel_variable = GlobalVariables.sharedManager
    
    var id_to_send : String!
    let  nextVc  =  CategorySelectionViewController.viewController()
    
    var dict:NSDictionary = NSDictionary()
    var timerLocationForCustomer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.shared.delegate = self
        LocationManager.shared.requestLocationAtOnce()
        
        
        lblNoData.isHidden = true
        let nib = UINib(nibName: "Category_ViewTableViewCell", bundle: nil)
        
        artist_TableView.register(nib, forCellReuseIdentifier: "Category_ViewTableViewCell")
        self.artist_TableView.addSubview(self.refreshControl)
        self.getCatoery()
        timerLocationForCustomer.invalidate() // just in case this button is tapped multiple times
        
        
        /*let notificationCenter = NotificationCenter.default
         notificationCenter.addObserver(self,
         selector: #selector(self.UpdateFilter(notification:)),
         name: NSNotification.Name(rawValue: "UpdateFilter"),
         object: nil)*/
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationManager.shared.requestLocationAtOnce()
        if let  nextVc  =  nextVc {
            
            nextVc.delegate =  self
            nextVc.filterDelegate = self
        }
    }
    
    @objc func UpdateFilter(notification: NSNotification) {
        if let userInfoDic = notification.userInfo  {
            if let dic = userInfoDic as? Dictionary<String,String> {
                if let type = dic["type"] {
                    sortingMathod(type: Int(type) ?? 0)
                }
            }
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        cat_id = ""
        self.getCatoery()
        lblCat.text = "ALL CATEGORIES"
        refreshControl.endRefreshing()
    }
    
    
    @IBAction func btnGetCat(_ sender: Any) {
        
        openSelectionType2()
        
        
        
    }
    func openSelectionType(){
        if let  nextVc  =  nextVc {
            
            nextVc.delegate =  self
            nextVc.filterDelegate = self
            nextVc.dataTag = 1
            
            app_delegate.window?.rootViewController?.present(nextVc,animated: true  )
        }
    }
    func openSelectionType2(){
        if let  nextVc  =  nextVc {
            
            nextVc.delegate =  self
            nextVc.filterDelegate = self
            nextVc.dataTag = 0
             
            app_delegate.window?.rootViewController?.present(nextVc,animated: true  )
        }
    }
    
    
    
    //Deepak Changes
    func getCatoery(){
        
        
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
            
            
            
            loader.showLoader()
            Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram: parameters, methodName: Constant.kTo_getAllArtists, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr :  nil, with: AllArtists_Struct.self  , completion : {(success, modelVal) -> Void in if success
            {
                
                self.artists_Dic = modelVal!
                self.artist_TableView.reloadData()
                loader.hideLoader()
                
            }
            else
            {
                loader.hideLoader()
                self.artists_Dic.artists_Arr.removeAll()
                self.artist_TableView.reloadData()
                Alert.showMiddleToast(message: GlobalVariables.sharedManager.get_Status.message, view_VC: self)
                
                }
            })
            
        }
        
    }
    
    
    // select action of atist name from artist table
    @IBAction func artist_Name_Action(_sender : UIButton)
    {
        
        let artist_Pro_VC:ArtistPrViewController = storyboard?.instantiateViewController(withIdentifier: "ArtistPrViewController") as! ArtistPrViewController
        artist_Pro_VC.delegate = self
        
        let val_dic  =  self.artists_Dic.artists_Arr[_sender.tag]
        
        if let id_to_send = val_dic.user_id
        {
            artist_Pro_VC.get_artist_id = id_to_send
            self.navigationController?.pushViewController(artist_Pro_VC, animated: true)
            
        }
        
    }
    
}



extension CategoryNewViewController : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artists_Dic.artists_Arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:Category_ViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Category_ViewTableViewCell", for: indexPath) as! Category_ViewTableViewCell
        
        let val_dic  =  self.artists_Dic.artists_Arr[indexPath.row]
        
        
        if let image_url = val_dic.image
        {
            
            cell.imgProfile.sd_setImage(with: URL(string:image_url ), placeholderImage: #imageLiteral(resourceName: "profile"))
            cell.imgProfile.clipsToBounds = true
            cell.imgProfile.layer.cornerRadius = cell.imgProfile.frame.height/2
            
            
        }
                
        
        
        
        if val_dic.fav_status == "0"
        {
            cell.fav_ImageV.image =  #imageLiteral(resourceName: "heart_Emty")
        }
        else
        {
            cell.fav_ImageV.image =  #imageLiteral(resourceName: "heart_Ful")
        }
        
        
        if val_dic.featured == "0"
        {
            cell.featured_ImageV.image =  nil
        }
        else
        {
            cell.featured_ImageV.image =  #imageLiteral(resourceName: "featured")
        }
        
        
        
        
        
        
        cell.star_rating_view.editable = false
        
        var  ava_rating = "0"
        
        ava_rating = String(val_dic.ava_rating )
        
        
        
        let desimal_Str = String(format:"%.1f", Double(ava_rating)!)
        cell.star_rating_view.type =  .halfRatings
        cell.star_rating_view.rating = Double(desimal_Str)!
        
        
        if val_dic.name != ""  {
            cell.artist_Name_Label.text = val_dic.name?.capitalized
        } else {
            cell.artist_Name_Label.text = "NA"
        }
        
        
        var stringOne = "\((val_dic.jobDone))"+" Job Done"
        var stringTwo = "\((val_dic.jobDone))"
        
        var range = (stringOne as NSString).range(of: stringTwo)
        
        var attributedText = NSMutableAttributedString.init(string: stringOne) // NSForegroundColorAttributeName
        attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        
        
        
        cell.artist_Job_stuts_Label.attributedText = attributedText
        
        
        let priceGet : String = val_dic.price ?? ""
        
        
        
        let commissionType : String = val_dic.commission_type ?? ""
        let artistCommissionType : String = val_dic.artist_commission_type ?? ""
        let flatType : String = val_dic.flat_type ?? "0"
        let currencyType: String = val_dic.currency_type ?? "0"
        if artistCommissionType == "0" {
            if commissionType == "0" {
                
                let add_on = currencyType + " " + "\(priceGet)" + "/hr"//+" Add On : " + currencyType + " " + category_price!
                cell.artist_Rate_Label.text = add_on
                
            } else if commissionType == "1" && flatType == "2" {
                
                let add_on = currencyType + " " + "\(priceGet)" + "/hr"//+" Add On : " + currencyType + " " + category_price!
                cell.artist_Rate_Label.text = add_on
                
            } else if commissionType == "1" && flatType == "1" {
                
                let add_on = currencyType + " " + "\(priceGet)" + "/hr"//+" Add On : "+category_price! + "%"
                cell.artist_Rate_Label.text = add_on
            } else {
                
                let add_on = currencyType + " " + "\(priceGet)" + "/hr"//+" Add On : "  + currencyType + " " +  category_price!
                cell.artist_Rate_Label.text = add_on
            }
        } else {
            if commissionType == "0" {
                let add_on = currencyType + " " + "\(priceGet) " + "\(self.defaultLocalizer.stringForKey(key:"fixed rate")) " //+ currencyType + " " + category_price!
                cell.artist_Rate_Label.text = add_on
                
            } else if commissionType == "1" && flatType == "2" {
                let add_on = currencyType + "\(priceGet) " + "\(self.defaultLocalizer.stringForKey(key:"fixed rate ")) " //+ currencyType + " " + category_price!
                cell.artist_Rate_Label.text = add_on
                
            } else if commissionType == "1" && flatType == "1" {
                
                
                
                let add_on = currencyType + " " + "\(priceGet) " + "\(self.defaultLocalizer.stringForKey(key:"fixed rate")) " //+ category_price! + "%"
                cell.artist_Rate_Label.text = add_on
                
                
                
            } else {
                
                let add_on = currencyType + " " + "\(priceGet) " + "\(self.defaultLocalizer.stringForKey(key:"fixed rate"))"//+category_price!
                cell.artist_Rate_Label.text = add_on
            }
        }
        
        
        cell.artist_Star_Label.text = "(" + "\(desimal_Str)" + "/5)"
        
        if let catN = val_dic.category_name
        {
            cell.artist_Type_Label.text = catN.uppercased()
        }
        
        
        if let dic = val_dic.distance
        {
            cell.artist_distance_Label.text = "\(dic) "+"KM From You"
        }
        if let loc  = val_dic.location
        {
            cell.artist_address_Label.text = loc
        }
        
        if let per_Com = (val_dic.percentages)
        {
            
            
            
            let trun   = Int(truncating: NSNumber(value: per_Com))
            
            
            
            stringOne = "\(String(trun))"+"% Success"
            stringTwo = "\(String(trun))"+"%"
            range = (stringOne as NSString).range(of: stringTwo)
            attributedText = NSMutableAttributedString.init(string: stringOne) // NSForegroundColorAttributeName
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
            
            cell.artist_Success_stuts_Label.attributedText =  attributedText
            
            if let updated_Str = val_dic.updated_at
            {
                let interval: TimeInterval? = Double( updated_Str )
                let date_get = Date(timeIntervalSince1970: interval!)
                
                
                // cell.hourse_button.setTitle( " "+"\(date_get.getElapsedInterval())", for: .normal)
                cell.artist_Houre_Label.text =  "\(date_get.getElapsedInterval())"
            }
            
            
            
        }
        
        cell.artist_Name_Select_Button.addTarget(self, action:  #selector(self.artist_Name_Action(_sender:)), for: .touchUpInside)
        cell.artist_Name_Select_Button.tag = indexPath.row
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        artist_TableView.rowHeight =  150
        artist_TableView.estimatedRowHeight = UITableView.automaticDimension
        
        
        return artist_TableView.rowHeight
    }
}

extension CategoryNewViewController : udpateFebMathod
{
    
    
    func mathodFeavUpdate() {
        
        lblCat.text = "ALL CATEGORIES"
        self.getCatoery()
        
    }
    
    
}

extension CategoryNewViewController : updateLoactionDelegate
{
    func updateLoacationMathod(locationClass: LocationManager) {
        getCatoery()
    }
    
}


extension CategoryNewViewController : updateCategoreyDelegate  , FilterDelegate
{
    func updateCategoryMathod(val: CategoryOptionData?) {
        
        if  val != nil {
            if let cat_id = val?.id
            {
                self.cat_id = cat_id
                self.lblCat.text = val?.cat_name
                self.getCatoery()
                
                
            }
        }else {
            cat_id = ""
              lblCat.text = "ALL CATEGORIES"
            self.getCatoery()
        }

        
    }
    func filterMethod(type: Int?) {
        if let intVal = type {
            let typeVal = Int(intVal)
            sortingMathod(type:typeVal )
            
        }
    }
    
}
extension CategoryNewViewController {
    
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
        artist_TableView.reloadData()
        
    }
}
