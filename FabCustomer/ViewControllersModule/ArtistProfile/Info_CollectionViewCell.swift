//
//  Info_CollectionViewCell.swift
//  FabArtist
//
//  Created by AmitSharma on 12/06/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit
//import  BetterSegmentedControl


//import UIKit
//import BetterSegmentedControl

protocol updateRateDelegate {
    func updateRateMathod(cell : Info_CollectionViewCell )
  
}


protocol updatePersonalInfoDelegate {
    
    func updatePersonalInfoMathod(cell : Info_CollectionViewCell)
    func updatePersonalInfo_save_Mathod(cell : Info_CollectionViewCell)
    func qualificationMathod(cell:Info_CollectionViewCell)

}


class Info_CollectionViewCell: UICollectionViewCell {
    
    
    /*@IBAction func rateSelectionSegment(_ segMnetIng : BetterSegmentedControl)
    {
        if segMnetIng.index == 0
        {
            // online_Off_Sell.titles = ["" , "Hourly Rate"]
            delegate?.updateRateMathod(cell: self)
            
        }
        else
        {
            //online_Off_Sell.titles = ["Fixed Rate" , ""]
            delegate?.updateRateMathod(cell: self)
        }
    }
    */
    
    var gender_Str = ""
    
    
    var delegate1 : updatePersonalInfoDelegate?
    
    @IBOutlet weak var  nameTF      : HoshiTextField!
    @IBOutlet weak var  emailTF     : HoshiTextField!
    @IBOutlet weak var  numberTF    : HoshiTextField!
    
    
    
    @IBOutlet weak var   maleButton : UIButton!
    @IBOutlet weak var   femaleButton : UIButton!
    @IBOutlet weak var   ratingView : FloatRatingView!
    
    
    @IBOutlet weak var   addressLabel : UILabel!
    
    
    
    
    
    @IBOutlet weak var   saveButton : UIButton!
    
    @IBOutlet weak var   maleImgV : UIImageView!
    @IBOutlet weak var   femaleImgV : UIImageView!
    
    
    
    var delegate  : updateRateDelegate?
    @IBOutlet weak var ratingLabel : UILabel!
    @IBOutlet weak var rateLabel : UILabel!
    @IBOutlet weak var job_comeletedLabel : UILabel!
    @IBOutlet weak var persentaegComLabel : UILabel!
   // @IBOutlet weak var online_Off_Sell: BetterSegmentedControl!
    
    @IBOutlet weak var  aboutLabel : UILabel!
    
    @IBOutlet weak var  qualificationTableV : UITableView!
    
    @IBOutlet weak var  qualificationTableVHeight : NSLayoutConstraint!

    @IBOutlet weak var Info_TableView : UITableView!
    @IBOutlet weak var info_ScrollView : UIScrollView!
    
    //var artist_TableV : UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       app_delegate.infoScroll = info_ScrollView
        ratingView.type = .halfRatings
        ratingView.minRating = Int(0.0)
        ratingView.maxRating =  Int(5.0)
        maleImgV.image      =   UIImage(named: "icon")
        femaleImgV.image    =   UIImage(named: "icon")
        let nib1 = UINib(nibName: "Qualification_TableVCell" , bundle: nil)
        qualificationTableV.register(nib1, forCellReuseIdentifier: "Qualification_TableVCell")
        qualificationTableV.delegate = self
        qualificationTableV.dataSource = self
        info_ScrollView.delegate = self
        
       /*
        let nib1 = UINib(nibName: "RatingTableViewCell" , bundle: nil)
        Info_TableView.register(nib1, forCellReuseIdentifier: "RatingTableViewCell")
        
        let nib2 = UINib(nibName: "About_TableViewCell" , bundle: nil)
        Info_TableView.register(nib2, forCellReuseIdentifier: "About_TableViewCell")
        
        let nib3 = UINib(nibName: "QualificationTableViewCell" , bundle: nil)
        Info_TableView.register(nib3, forCellReuseIdentifier: "QualificationTableViewCell")
        
        let nib4 = UINib(nibName: "EditTableViewCell" , bundle: nil)
        Info_TableView.register(nib4, forCellReuseIdentifier: "EditTableViewCell")
        
        let nib5 = UINib(nibName: "SaveTableViewCell" , bundle: nil)
        Info_TableView.register(nib5, forCellReuseIdentifier: "SaveTableViewCell")
        
        Info_TableView.delegate = self
        Info_TableView.dataSource = self
         */
        
    }
    @IBAction func editAction(_ sender : UIButton)
    {
        delegate1?.qualificationMathod(cell: self)
    }
    @IBAction func genderSelectionAction(_ sender : UIButton!)
    {
        switch sender {
        case maleButton :
            maleImgV.image      = UIImage(named: "check")
            femaleImgV.image    = UIImage(named: "icon")
            gender_Str = "1"
            delegate1?.updatePersonalInfoMathod(cell: self)
            break;
        case femaleButton :
            gender_Str = "0"
            maleImgV.image      = UIImage(named: "icon")
            femaleImgV.image    = UIImage(named: "check")
            delegate1?.updatePersonalInfoMathod(cell: self)
        case saveButton :
            delegate1?.updatePersonalInfo_save_Mathod(cell: self)
            
            break;
        default:
            break;
        }
        
    }
}

extension Info_CollectionViewCell : UITableViewDataSource , UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  app_delegate.tap_collectionVC?.artistDis.data.qualifications?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        self.qualificationTableVHeight.constant = tableView.contentSize.height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let qali_cell:Qualification_TableVCell = tableView.dequeueReusableCell(withIdentifier: "Qualification_TableVCell", for: indexPath) as! Qualification_TableVCell
        
        qali_cell.deleagate = app_delegate.tap_collectionVC
        qali_cell.delete_Button.tag = indexPath.row
        qali_cell.edit_Button.tag   = indexPath.row
        
        
        if let val_dic =  app_delegate.tap_collectionVC?.artistDis.data.qualifications![indexPath.row]
        {
            print(val_dic)
            qali_cell.title_Label.text = val_dic.title
            qali_cell.description_Label.text = val_dic.description
            
            
            
            /*qali_cell.edit_Button.tag  = indexPath.row
             qali_cell.edit_Button.addTarget(self, action: #selector(self.edit_Qualification_Action(_:)), for: .touchUpInside)
             
             
             qali_cell.delete_Button.tag  = indexPath.row
             qali_cell.delete_Button.addTarget(self, action: #selector(self.delete_qulification_Action(_:)), for: .touchUpInside)*/
        }
        return qali_cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight  = UITableView.automaticDimension
        return tableView.rowHeight
    }
  /*  func load_Switch( switch_Obj : BetterSegmentedControl! )
    {
        //Switch_Button_Class.sharedInstance.Switch_Mathod( switch_Obj: switch_Obj)
    }*/
    
}




extension Info_CollectionViewCell    : UIScrollViewDelegate
{
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = scrollView.contentOffset.y
        
        print(y)
        if y <= -1
        {
            app_delegate.infoScroll?.isScrollEnabled = false
           // app_delegate.tap_collectionVC?.artistTableView.scrollToTop(animated: true)
        }
        if y >= 150
        {
            app_delegate.infoScroll?.isScrollEnabled = true
            app_delegate.tap_collectionVC?.artistTableView.scrollToLastCall(animated: true)
        }
    }
}

extension UITableView {
    /*func scrollToFirstCall(animated : Bool) {
        let lastSectionIndex = self.numberOfSections - 1 // last section
        
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .top, animated: animated)
    }*/
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
    func scrollToTop(animated: Bool) {
        let indexPath = IndexPath(row: 0, section: 0)
        if self.hasRowAtIndexPath(indexPath: indexPath) {
            self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
    
    
}
/*extension Info_CollectionViewCell : UITableViewDataSource , UITableViewDelegate
 {
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return 4
 }
 func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
 if indexPath.row == 0
 {
 if let cell = cell as? RatingTableViewCell
 {//dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell
 
 
 
 
 }
 
 
 }
 else if indexPath.row == 1
 {
 if let cell = cell as? About_TableViewCell
 {
 
 }
 }
 else if indexPath.row == 2
 {
 if let cell = cell as? QualificationTableViewCell {
 
 
 cell.qualificationTableV.reloadData()
 }
 
 
 }
 
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
 if indexPath.row == 0
 {
 let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell", for: indexPath) as! RatingTableViewCell
 /*if let avrageRat  = app_delegate.tap_collectionVC?.artistDis.data.ava_rating
 {
 cell.persentaegComLabel.text = String( app_delegate.tap_collectionVC!.artistDis.data.completePercentages!) + "% Completion "
 cell.ratingLabel.text = "( \( avrageRat)/5 ) "
 
 if let  currency_type = app_delegate.tap_collectionVC?.artistDis.data.currency_type
 {
 if let  price = app_delegate.tap_collectionVC?.artistDis.data.price
 {
 cell.rateLabel.text =  "( Rate \( currency_type) \(price )/hr ) "
 }
 }
 
 
 if let val = app_delegate.tap_collectionVC?.artistDis.data.completion_rate
 {
 
 cell.job_comeletedLabel.text = val + " Jobs Completed "
 }
 }*/
 
 /*if let payMent = app_delegate.tap_collectionVC?.artistDis.data.artist_commission_type
 {
 
 load_Switch( switch_Obj : cell.online_Off_Sell )
 if payMent == "0"
 {
 cell.online_Off_Sell.index  = 0
 // cell.online_Off_Sell.titles = ["" , "Hourly Rate"]
 }
 else
 {
 cell.online_Off_Sell.index  = 1
 //cell.online_Off_Sell.titles = ["Fixed Rate" , ""]
 }
 }*/
 return cell
 }
 else if indexPath.row == 1
 {
 let cell = tableView.dequeueReusableCell(withIdentifier: "About_TableViewCell", for: indexPath) as! About_TableViewCell
 if let about_us = app_delegate.tap_collectionVC?.artistDis.data.about_us
 {
 cell.aboutLabel.text = about_us
 
 }
 return cell
 }
 else if indexPath.row == 2
 {
 let cell = tableView.dequeueReusableCell(withIdentifier: "QualificationTableViewCell", for: indexPath) as! QualificationTableViewCell
 cell.delegate = app_delegate.tap_collectionVC
 cell.qualificationTableV.reloadData()
 return cell
 }
 else if indexPath.row == 3
 {
 let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableViewCell", for: indexPath) as! EditTableViewCell
 
 cell.delegate = app_delegate.tap_collectionVC
 
 
 return cell
 }
 else
 {
 let cell = tableView.dequeueReusableCell(withIdentifier: "SaveTableViewCell", for: indexPath) as! SaveTableViewCell
 return cell
 }
 }
 
 
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 
 
 if indexPath.row == 0
 {
 
 tableView.estimatedRowHeight = 200
 tableView.rowHeight  = UITableView.automaticDimension
 }
 else if indexPath.row == 1
 {
 
 tableView.estimatedRowHeight = 100
 tableView.rowHeight  = UITableView.automaticDimension
 }
 else if indexPath.row == 2
 {
 tableView.estimatedRowHeight = 220
 tableView.rowHeight  = UITableView.automaticDimension
 }
 else if indexPath.row == 3
 {
 
 tableView.estimatedRowHeight = 400
 //tableView.rowHeight  = UITableView.automaticDimension
 }
 /*else
 {
 
 tableView.estimatedRowHeight = 50
 tableView.rowHeight  = UITableView.automaticDimension
 }*/
 
 return tableView.rowHeight
 }
 }
 */
