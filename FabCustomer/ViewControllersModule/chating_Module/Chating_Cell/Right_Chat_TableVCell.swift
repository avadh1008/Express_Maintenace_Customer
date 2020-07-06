//
//  Right_Chat_TableVCell.swift
//  FabArtist
//
//  Created by Samyotech on 04/04/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit


protocol rightCellDelegate {

    func openImageAction(cell : Right_Chat_TableVCell )
}

class Right_Chat_TableVCell: UITableViewCell
{
    var delegate : rightCellDelegate?
    @IBOutlet weak var imageRightHeight: NSLayoutConstraint!
    @IBOutlet weak var imageRight: UIImageView!
    @IBOutlet weak var right_View: UIView!
    @IBOutlet weak var right_Date_Lab: UILabel!
    @IBOutlet weak var right_Mess_Lab: UILabel!
    @IBOutlet weak var right_ImgButton : UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
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
