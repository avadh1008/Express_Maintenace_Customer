//
//  CategorySelectionViewController.swift
//  FabArtist
//
//  Created by AmitSharma on 27/06/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit

protocol updateCategoreyDelegate {
    
    func updateCategoryMathod(val : CategoryOptionData?)
}

protocol FilterDelegate {
    func filterMethod(type : Int? )
}



class CategorySelectionViewController: UIViewController {

    class func viewController() -> CategorySelectionViewController? {
        return "Main".viewController("CategorySelectionViewController") as? CategorySelectionViewController
    }
    
     @IBOutlet weak var serviceTV : UITableView!
    var cateDic =  CategoryOptionStruct()
    var skill_seleced_Arr =   CategoryOptionData()
    var  delegate : updateCategoreyDelegate?
    var filterDelegate : FilterDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if dataTag == 1 {
            updateDataArr()
        } else {
             getCateGory()
           
        }
        
        Register_Nib_With_Delegate.sharedInstance.register_Mathod(vc: self, tableV_Name: serviceTV, cell_Identity: "ServiceSelectTableViewCell")
    }
    
    
    
    var dataTag = 0
    var dataArr = [Dictionary<String,String>]()
    func updateDataArr(){
        dataArr.removeAll()
        dataArr.append(["title":"Price(Low to High)","type":"1"])
        dataArr.append(["title":"Jobs Done","type":"2"])
        dataArr.append(["title":"Featured","type":"3"])
        dataArr.append(["title":"Favourite","type":"4"])
        loader.hideLoader()
        self.serviceTV.reloadData()
    }
    
    func getCateGory()
    {
          dataArr.removeAll()
        loader.showLoader()
        let parameters : [String : String] = ["user_id":  (SignUpDataClass.shareMngr.signUpData?.SignUdata!.user_id)!]
        
        Revoke_Service_Class.sharedInstance.createReqest(vc: self, dictPram:  parameters , methodName: Constant.kTo_getAllCaegory, img_pram: nil, imageUpload_Arr: nil , media_pram: nil  , video_url_Up_Arr : nil, with: CategoryOptionStruct.self  , completion : {(success, modelVal) -> Void in if success
        {
           
            self.cateDic = modelVal!
            loader.hideLoader()
            self.serviceTV.reloadData()
        }
        else
        {
            loader.hideLoader()
            }
        })
        
        
    }
    
    @IBAction func left_Mathod_Action( _ sender : UIButton!)
    {
       // self.delegate?.updateCategoryMathod(val: skill_seleced_Arr)
        self.dismiss(animated:true )
        
      /*  if let count = app_delegate.navi_obj?.viewControllers.count
        {
           /* if count > 1 {
                
                for (_ , vc) in (app_delegate.navi_obj?.viewControllers.enumerated())!
                {
                    if let setVC = vc as? EditPersonalViewController {
                        if skill_seleced_Arr.categoryArr.count != 0
                        {
                            setVC.categoryDic = skill_seleced_Arr
                        }
                       
                        //  self.navigationController?.popViewController(animated: false)
                    }
                }
               
            }*/
        }
       */
    }
}
extension CategorySelectionViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataTag == 1 {
          return self.dataArr.count
        } else {
            return self.cateDic.categoryArr.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataTag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceSelectTableViewCell", for: indexPath) as! ServiceSelectTableViewCell
            let dic = dataArr[indexPath.row]
            cell.serviceLabel.text = dic["title"]
             cell.service_select_Img.image = UIImage(named: "icon")
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceSelectTableViewCell", for: indexPath) as! ServiceSelectTableViewCell
                   
            
            if indexPath.row == 0{
                cell.serviceLabel.text = "All Category"
                 cell.service_select_Img.image = UIImage(named: "icon")
                
            }else {
                
                let dic = self.cateDic.categoryArr[indexPath.row-1]
                      
                       
                       let val = skill_seleced_Arr
                       
                       /*for (_ , val ) in skill_seleced_Arr.categoryArr.enumerated()
                       {*/
                           if val.id == dic.id
                           {
                               cell.service_select_Img.image = UIImage(named: "check")
                               //break;
                           }
                           else
                           {
                               cell.service_select_Img.image = UIImage(named: "icon")
                           }
                      /* }
                       if skill_seleced_Arr.categoryArr.count == 0
                       {
                           cell.service_select_Img.image = UIImage(named: "icon")
                       }*/
                       
                       
                       cell.serviceLabel.text = dic.cat_name.capitalized /// "  \(dic.cat_name ) /n  \( self.corency) - \( dic.price) "
                
            }
            
         
       
         return cell
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if dataTag == 1 {
            let dic = dataArr[indexPath.row]
      //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateFilter"), object:nil, userInfo: dic)
       
        filterDelegate?.filterMethod(type: Int(dic["type"]!)!)
        self.dismiss(animated:true )
        }
        else
        {
            
            if indexPath.row == 0{
                
                skill_seleced_Arr =    CategoryOptionData()
                self.delegate?.updateCategoryMathod(val: nil)
                serviceTV.reloadData()
                self.dismiss(animated:true )
                           
            }else {
                if self.cateDic.categoryArr.count > indexPath.row {
                    let dic = self.cateDic.categoryArr[indexPath.row-1]
                            skill_seleced_Arr = dic
                            serviceTV.reloadData()
                           
                           self.delegate?.updateCategoryMathod(val: skill_seleced_Arr)
                           self.dismiss(animated:true )
                           
                           
                }
            }
            

       
        /*
        if let  cell = tableView.cellForRow(at: indexPath) as? ServiceSelectTableViewCell
        {
            
            if cell.service_select_Img.image == UIImage(named: "check")
            {
                for (ind , val ) in skill_seleced_Arr.categoryArr.enumerated()
                {
                    
                    if val.id == dic.id
                    {
                        
                        skill_seleced_Arr.categoryArr.remove(at: ind)
                        serviceTV.reloadData()
                        break;
                    }
                    
                }
            }
            else
            {
                
                //skill_seleced_Arr.categoryArr = [dic]
                skill_seleced_Arr.categoryArr.append(dic)
                serviceTV.reloadData()
            }
        }*/
        
       /* if let count = app_delegate.navi_obj?.viewControllers.count
        {
            
            if count > 1 {
                
                for (ind , vc) in (app_delegate.navi_obj?.viewControllers.enumerated())!
                {
                    if let setVC = vc as? EditPersonalViewController {
                        setVC.categoryArr = skill_seleced_Arr.categoryArr
                        
                        self.dismiss(animated:true )
                        
                        
                        //  self.navigationController?.popViewController(animated: false)
                    }
                }
                
            }
        }*/
        }
    }
    
    
    
}

