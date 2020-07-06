//
//  HistoryVCCell.swift
//  FabArtist
//
//  Created by iMac on 09/03/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class HistoryVCCell: UITableViewCell {
    
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet var imgProfile    :   UIImageView!
    @IBOutlet var btnview       :   UIButton!
    @IBOutlet var btnreport     :   UIButton!
    @IBOutlet var lblName       :   UILabel!
    @IBOutlet var lblservicetype    :   UILabel!
    @IBOutlet var lblservicetype1   :   UILabel!
    @IBOutlet var lblprice      :   UILabel!
    @IBOutlet var lbldate       :   UILabel!
    @IBOutlet var lblservice    :   UILabel!
    
    @IBOutlet var payButton : UIButton!
    @IBOutlet var payViewHeight   : NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
        imgProfile.layer.borderWidth = 0.3
        imgProfile.layer.borderColor = UIColor.lightGray.cgColor
        imgProfile.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
