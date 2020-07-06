//
//  Category_ViewTableViewCell.swift
//  FabCustomer
//
//  Created by Samyotech on 09/03/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit


class Category_ViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var star_rating_view: FloatRatingView!
    @IBOutlet weak var artist_Name_Select_Button : UIButton!
    @IBOutlet var imgProfile:UIImageView!
    @IBOutlet var hourse_button: UIButton!
    @IBOutlet var artist_Name_Label:UILabel!
    @IBOutlet var artist_Type_Label:UILabel!
    @IBOutlet var artist_Star_Label:UILabel!
    @IBOutlet var artist_Job_stuts_Label:UILabel!
    @IBOutlet var artist_Houre_Label:UILabel!
    @IBOutlet var artist_distance_Label:UILabel!
    @IBOutlet var artist_address_Label:UILabel!
    @IBOutlet var artist_Rate_Label:UILabel!
    @IBOutlet var artist_Success_stuts_Label:UILabel!
    @IBOutlet var fav_ImageV:UIImageView!
    @IBOutlet var featured_ImageV:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnprofileview(_ sender: Any) {
        print("Signin")
    }
    
}
