//
//  Money_Wlet_TableVCell.swift
//  FabArtist
//
//  Created by apple on 02/11/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class Money_Wlet_TableVCell: UITableViewCell {

    
    @IBOutlet weak var back_ground_V : UIView!
    @IBOutlet weak var left_ImgV : UIImageView!
   
    @IBOutlet weak var by_Label : UILabel!
    @IBOutlet weak var Amont_Label : UILabel!
    @IBOutlet weak var date_Label : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
