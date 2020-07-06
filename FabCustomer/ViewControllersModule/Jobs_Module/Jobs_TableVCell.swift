//
//  Jobs_TableVCell.swift
//  FabCustomer
//
//  Created by Samyotech on 24/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class Jobs_TableVCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnMarkAsComplete: UIButton!
    @IBOutlet weak var pro_ImgV  : UIImageView!
    @IBOutlet weak var job_id_Label  : UILabel!
    @IBOutlet weak var date_Label  : UILabel!
    @IBOutlet weak var name_Label  : UILabel!
    @IBOutlet weak var service_Label  : UILabel!
    @IBOutlet weak var address_Label  : UILabel!
    @IBOutlet weak var stuts_Label  : UILabel!
    @IBOutlet weak var dec_Label  : UILabel!
    
    @IBOutlet weak var edit_View  : UIView!
    
    @IBOutlet weak var delete_Button  : UIButton!
    @IBOutlet weak var edit_Button  : UIButton!
    
    @IBOutlet weak var height_Constrent   : NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
