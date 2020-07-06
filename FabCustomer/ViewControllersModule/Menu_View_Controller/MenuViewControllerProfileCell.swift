//
//  MenuViewControllerProfileCell.swift
//  FabCustomer
//
//  Created by Samyotech on 03/03/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class MenuViewControllerProfileCell: UITableViewCell {

    @IBOutlet weak var artist_Button: UIButton!
    
    @IBOutlet weak var image_Profile: UIImageView!
    
    @IBOutlet weak var name_Label: UILabel!
    
    @IBOutlet weak var email_Label: UILabel!
    
    @IBOutlet weak var role_Type: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
