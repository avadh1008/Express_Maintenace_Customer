//
//  Chat_Home_TableVCell.swift
//  FabArtist
//
//  Created by Samyotech on 02/04/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class Chat_Home_TableVCell: UITableViewCell {

    
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var name_Label: UILabel!
    @IBOutlet weak var chat_Home_ImageView: UIImageView!
    @IBOutlet weak var data_Label: UILabel!
    
    @IBOutlet weak var dec_Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
