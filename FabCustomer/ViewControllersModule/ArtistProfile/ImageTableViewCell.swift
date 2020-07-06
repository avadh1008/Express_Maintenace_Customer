//
//  ImageTableViewCell.swift
//  FabArtist
//
//  Created by AmitSharma on 14/06/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit

protocol  updateImageDelegate {
    func deleteImageMathod(cell : ImageTableViewCell )
    func saveImageMathod(cell : ImageTableViewCell )
    func onlineOffLineSegment(cell : ImageTableViewCell )
    func editMathod(cell : ImageTableViewCell )
}

class ImageTableViewCell: UITableViewCell {
    
    var updateImageDelegate  : updateImageDelegate?
    
    @IBOutlet weak var status_Label: UILabel!
    
    
    @IBOutlet weak var favImgView : UIImageView!
    
 
    @IBOutlet weak var profileView : UIView!
    @IBOutlet weak var profileViewHeight : NSLayoutConstraint!
    @IBOutlet weak var profileImgView : UIImageView!
    @IBOutlet weak var imageViewHeight : NSLayoutConstraint!
    @IBOutlet weak var bannerImgView : UIImageView!
    
    @IBOutlet weak var editButton : UIButton!
    @IBOutlet weak var deleteButton : UIButton!
    @IBOutlet weak var changeButton : UIButton!
    
    
    @IBOutlet weak var typeLabel : UILabel!
    @IBOutlet weak var typeDescriptionLabel : UILabel!
    @IBOutlet weak var addLabel : UILabel!
    @IBOutlet weak var infoLabel : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
        
    }

   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteMathod(_ sender : UIButton)
    {
        updateImageDelegate?.deleteImageMathod(cell: self)
    }
    
    @IBAction func changeMathod(_ sender : UIButton)
    {
        updateImageDelegate?.saveImageMathod(cell: self)
    }
    
    @IBAction func editMathod(_ sender : UIButton)
    {
        updateImageDelegate?.editMathod(cell: self)
    }
    
   /* @IBAction func segCont_Profile_Val_Chan(_ sender: BetterSegmentedControl) {
        
        if sender.index == 1
        {
           updateImageDelegate?.onlineOffLineSegment(cell: self)
        }
        else if sender.index == 0
        {
            updateImageDelegate?.onlineOffLineSegment(cell: self)
        }
       
        
    }*/
    
}
