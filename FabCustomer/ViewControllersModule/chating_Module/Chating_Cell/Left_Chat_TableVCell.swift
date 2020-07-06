//
//  Chat_TableVCell.swift
//  FabArtist
//
//  Created by Samyotech on 02/04/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit
protocol leftCellDelegate {
    
    func openImageAction(cell : Left_Chat_TableVCell )
}


class Left_Chat_TableVCell: UITableViewCell {

    //Chat_TableVCell
    var delegate : leftCellDelegate?
    
    @IBOutlet weak var imageLeftHeight: NSLayoutConstraint!
    @IBOutlet weak var imageLeft: UIImageView!
    @IBOutlet weak var laft_View: UIView!
    @IBOutlet weak var left_Date_Lab: UILabel!
    @IBOutlet weak var left_Mess_Lab: UILabel!
    @IBOutlet weak var left_ImgButton : UIButton!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func openImageAction(_ sender : UIButton!)
    {
        delegate?.openImageAction(cell: self)
    }
    
}
