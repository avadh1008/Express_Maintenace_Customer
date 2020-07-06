//
//  Applied_TableVCell.swift
//  FabCustomer
//
//  Created by Samyotech on 25/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class Applied_TableVCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var getInvoice: UIButton!
    @IBOutlet weak var viewInvoice: UIView!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var mobileAddres: UIImageView!
    @IBOutlet weak var mobileEmail: UIImageView!
    @IBOutlet weak var mobileImage: UIImageView!
    @IBOutlet weak var pro_ImgV  : UIImageView!
    @IBOutlet weak var job_id_Label  : UILabel!
    @IBOutlet weak var date_Label  : UILabel!
    @IBOutlet weak var name_Label  : UILabel!
    @IBOutlet weak var service_Label  : UILabel!
    @IBOutlet weak var address_Label  : UILabel!
    @IBOutlet weak var stuts_Label  : UILabel!
    @IBOutlet weak var dec_Label  : UILabel!
    @IBOutlet weak var email_Label  : UILabel!
    @IBOutlet weak var mobile_Label  : UILabel!
    
    @IBOutlet weak var rating_View  : FloatRatingView!
    @IBOutlet weak var rating_Label  : UILabel!
    @IBOutlet weak var reject_Button  : UIButton!
    @IBOutlet weak var getTouch_Button  : UIButton!
    @IBOutlet weak var complete_Button  : UIButton!
    @IBOutlet weak var complete_View : UIView!
    @IBOutlet weak var option_View : UIView!
    @IBOutlet weak var height_Constrent   : NSLayoutConstraint!
    
    //Deepak
     @IBOutlet weak var imgMobile   : NSLayoutConstraint!
     @IBOutlet weak var imgEmail   : NSLayoutConstraint!
     @IBOutlet weak var imgAddres   : NSLayoutConstraint!
    
    
    @IBOutlet weak var lblMobileHeigt   : NSLayoutConstraint!
    @IBOutlet weak var lblEmailHeigt   : NSLayoutConstraint!
    @IBOutlet weak var lblAddresHeigt   : NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
