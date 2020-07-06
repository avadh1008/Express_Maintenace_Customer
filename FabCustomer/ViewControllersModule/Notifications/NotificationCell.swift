//
//  NotificationCell.swift
//  FabArtist
//
//  Created by Samyotech on 03/03/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var lbltime : UILabel!
    @IBOutlet weak var lbldiscount : UILabel!
    @IBOutlet weak var lbldiscriptions : UILabel!
    @IBOutlet weak var lblday : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     }

 }
