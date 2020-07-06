//
//  ServiceSelectTableViewCell.swift
//  FabCustomer
//
//  Created by AmitSharma on 20/06/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit

class ServiceSelectTableViewCell: UITableViewCell {

    
     @IBOutlet weak var serviceLabel : UILabel!
    @IBOutlet weak var service_select_Img : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
