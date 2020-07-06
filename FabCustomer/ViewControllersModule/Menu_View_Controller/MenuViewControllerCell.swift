//
//  MenuViewControllerCell.swift
//  FabCustomer
//
//  Created by Samyotech on 27/02/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class MenuViewControllerCell: UITableViewCell {

    @IBOutlet weak var imageSide: UIImageView!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var manu_v: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblline: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
