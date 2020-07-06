//
//  ServiceGalleryCollectionView_Cell_Cell.swift
//  FabArtist
//
//  Created by AmitSharma on 14/06/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit

class ServiceGalleryCollectionView_Cell_Cell: UICollectionViewCell {

    @IBOutlet weak var deleteButton : UIButton!
    @IBOutlet weak var typeImgView : UIImageView!
    @IBOutlet weak var typeLabel : UILabel!
    @IBOutlet weak var amontLabel : UILabel!
    @IBOutlet weak var backView : UIView!
    
    @IBOutlet weak var blueView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
