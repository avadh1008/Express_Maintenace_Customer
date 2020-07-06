//
//  TapOptionCollectionViewCell.swift
//  FabArtist
//
//  Created by AmitSharma on 14/06/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit

/*protocol tapColorChange {
    
    
    func tabselectMathod(cell :  TapOptionCollectionViewCell )
    
}
*/
class TapOptionCollectionViewCell: UICollectionViewCell {

    
    //var delegate : tapColorChange?
    @IBOutlet weak var nameLabel : UILabel!
     @IBOutlet weak var lineLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /*override var isSelected: Bool {
        didSet {
            nameLabel.textColor = .red
        }
    }*/
    
   /* @IBAction func tabAction(_ sender : UIButton)
    {
        delegate?.tabselectMathod(cell: self)
    }*/
}
