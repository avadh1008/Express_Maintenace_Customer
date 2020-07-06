//
//  MapMarkerWindow.swift
//  FabCustomer
//
//  Created by Aditya on 08/08/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

protocol MapMarkerDelegate: class {
    func didTapInfoButton(data: AllArtists_DataStruct?)
}


class MapMarkerWindow: UIView {
    
    let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var imgArtist: UIImageView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCatName: UILabel!
    @IBOutlet weak var lblArtistNAme: UILabel!
    weak var delegate: MapMarkerDelegate?
    var spotData: AllArtists_DataStruct??
    @IBAction func didTapInfoButton(_ sender: UIButton) {
        if let spotData = spotData{
            delegate?.didTapInfoButton(data: spotData)
        }
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "MapMarkerWindowView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }

}
