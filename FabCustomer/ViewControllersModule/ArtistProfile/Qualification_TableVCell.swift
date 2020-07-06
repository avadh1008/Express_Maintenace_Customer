//
//  Qualification_TableVCell.swift
//  FabArtist
//
//  Created by Samyotech on 19/03/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

protocol delete_edit_qualificationDelegate {
    func deleteQulification(cell : Qualification_TableVCell )
    func editQulification(cell : Qualification_TableVCell )
    
}

class Qualification_TableVCell: UITableViewCell {
    
    var deleagate : delete_edit_qualificationDelegate?
    @IBOutlet weak var delete_Button: UIButton!
    @IBOutlet weak var edit_Button: UIButton!
    @IBOutlet weak var title_Label: UILabel!
    @IBOutlet weak var description_Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editMathod(_ sender : UIButton)
    {
        deleagate?.editQulification(cell: self)
    }
    @IBAction func deleteMathod(_ sender : UIButton)
    {
        deleagate?.deleteQulification(cell: self)
    }
    

}


