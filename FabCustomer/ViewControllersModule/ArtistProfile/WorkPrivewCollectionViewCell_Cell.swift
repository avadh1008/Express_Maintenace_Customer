//
//  WorkPrivewCollectionViewCell_Cell.swift
//  FabArtist
//
//  Created by AmitSharma on 14/06/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit

class WorkPrivewCollectionViewCell_Cell: UICollectionViewCell {

    
    @IBOutlet weak var day_Ago_Label: UILabel!
    
    @IBOutlet weak var review_Dec_Label: UILabel!
    @IBOutlet weak var name_Label: UILabel!
    
    @IBOutlet weak var review_Rating_View: FloatRatingView!
    
    @IBOutlet weak var rating_Label: UILabel!
    
    @IBOutlet weak var Review_cat_Label: UILabel!
    
    @IBOutlet weak var review_User_Image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
