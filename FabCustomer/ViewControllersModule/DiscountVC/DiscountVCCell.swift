//
//  DiscountVCCell.swift
//  FabCustomer
//
//  Created by Samyotech on 02/03/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class DiscountVCCell: UITableViewCell {
    
    @IBOutlet weak var lblapplycode: UILabel!
    @IBOutlet weak var lbldiscription: UILabel!
    @IBOutlet weak var lblcode: UILabel!
    @IBOutlet weak var btncopycode: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbldiscription.lineBreakMode = .byWordWrapping
        lbldiscription.numberOfLines = 0;
        //  lbldiscription.adjustsFontSizeToFitWidth = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func copyMathodAction(_ sender : UIButton!)
    {
        if lblcode.text?.isEmpty == false
        {
            UIPasteboard.general.string = lblcode.text! // or use  sender.titleLabel.text
         //   Alert.showH( titleStr:"Message", messageStr:"Code Copy Done")
            let vc = UIViewController()
            
            Alert.showMiddleToast(message: "Code Copy", view_VC: vc)
            
            
        }
        
    }
}
