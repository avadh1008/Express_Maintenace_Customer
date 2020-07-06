//
//  ProfileSettingTableViewCell.swift
//  FabCustomer
//
//  Created by Samyotech on 20/03/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

protocol ProfileSettingDelegate {
    func callBackDelete(cell: ProfileSettingTableViewCell)
    func callBackChange(cell: ProfileSettingTableViewCell)
    func callBackPersonalInfo(cell: ProfileSettingTableViewCell)
    func callBackChangePassword(cell: ProfileSettingTableViewCell)
    func callBackHomeAddress(cell: ProfileSettingTableViewCell)
    func callBackOfficeAssress(cell: ProfileSettingTableViewCell)
}

class ProfileSettingTableViewCell: UITableViewCell {
    
    var cellDelegate:ProfileSettingDelegate?
    
    //Cell1
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    //Cell2
    @IBOutlet weak var lblFullName  : UILabel!
    @IBOutlet weak var nameLastName : UILabel!
    @IBOutlet weak var lblEmail     : UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var btnEdit2: UIButton!
    
    //Cell3
    @IBOutlet weak var btnEdit3: UIButton!
    
    //Cell4
    @IBOutlet weak var btnHomeEdit: UIButton!
    @IBOutlet weak var btnOfficeEdit: UIButton!
    
    @IBOutlet weak var txtviewOfficalAddress: UITextView!
    
    @IBOutlet weak var txtAddress: UITextView!
    @IBOutlet weak var txtCity: UITextView!
    @IBOutlet weak var txtCountry: UITextView!
    
    @IBOutlet weak var btnSaveInfoCLick: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func deleteAction(_ sender: Any) {
        cellDelegate?.callBackDelete(cell: self)
    }
    @IBAction func changeAction(_ sender: Any) {
        cellDelegate?.callBackChange(cell: self)
    }
    @IBAction func editPersonalInfoAction(_ sender: Any) {
        cellDelegate?.callBackPersonalInfo(cell: self)
    }
    @IBAction func editPasswordAction(_ sender: Any) {
        cellDelegate?.callBackChangePassword(cell: self)
    }
    @IBAction func editHomeAddressAction(_ sender: Any) {
        cellDelegate?.callBackHomeAddress(cell: self)
    }
    @IBAction func editOfficeAction(_ sender: Any) {
        cellDelegate?.callBackOfficeAssress(cell: self)
    }
    
}
