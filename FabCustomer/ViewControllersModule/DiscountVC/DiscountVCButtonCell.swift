//
//  DiscountVCButtonCell.swift
//  FabCustomer
//
//  Created by Samyotech on 02/03/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

@objc protocol InvitefriendDelegates {
    func Signupnewuser(cell: DiscountVCButtonCell)
    
}


class DiscountVCButtonCell: UITableViewCell {
    
      @IBOutlet weak var btninvitefrnd: UIButton!
    
      var delegate:InvitefriendDelegates?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:-New User Register
    @IBAction func btninvitefrnd(_ sender: Any) {
        
        delegate?.Signupnewuser(cell: self)
        
    }

}
