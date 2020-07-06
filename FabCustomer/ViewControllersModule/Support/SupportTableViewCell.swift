//
//  SupportTableViewCell.swift
//  FabArtist
//
//  Created by Aditya on 02/05/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class SupportTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblstatus: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDay: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
