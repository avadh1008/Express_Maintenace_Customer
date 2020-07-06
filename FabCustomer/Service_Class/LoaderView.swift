//
//  LoaderView
//  JobPortal
//
//  Created by samyotech on 11/09/17.
//  Copyright © 2017 samyotech. All rights reserved.
//

import UIKit
import CoreFoundation
import Foundation

var loader: LoaderView! = LoaderView()

class LoaderView: UIView {
    
    var img_loader: UIImageView! = UIImageView()
    var view_loader: UIView! = UIView()
    
    let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect.init(x: UIScreen.main.bounds.width/2 - 90/2, y: UIScreen.main.bounds.height/2 - 90/2, width: 90, height: 90)
        //self.frame = CGRect.init(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: Int(UIScreen.main.bounds.height))
        self.backgroundColor = UIColor.clear
        
        /* let img_bg = UIImageView.init(frame: self.frame)
         img_bg.backgroundColor = UIColor.clear
         //img_bg.alpha = 0.7*/
        
        /*img_loader.frame = CGRect.init(x: self.frame.width/2 - 90/2, y: self.frame.height/2 - 90/2, width: 90, height: 90)*/
        view_loader.frame = CGRect.init(x: 0, y: 0, width: 90, height: 90)
        
        //  view_loader.frame = CGRect.init(x: self.frame.width/2 - 90/2, y: self.frame.height/2 - 90/2, width: 90, height: 90)
        
        view_loader.backgroundColor =  UIColor.black.withAlphaComponent(0.4) //Constant.Wall_Boder_Color_D
        //        self.loaderImageAnimation()
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view_loader.center
        //        myActivityIndicator.color = .white
        myActivityIndicator.style = .whiteLarge
        
        // self.addSubview(img_bg)
        self.addSubview(view_loader)
        //        self.addSubview(img_loader)
        self.addSubview(myActivityIndicator)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //for Animation
    /* func loaderImageAnimation(){
     let arrImg = [UIImage.init(named: "a1"), UIImage.init(named: "a2"), UIImage.init(named: "a3"), UIImage.init(named: "a4"), UIImage.init(named: "a5"), UIImage.init(named: "a6"), UIImage.init(named: "a7"), UIImage.init(named: "a8"), UIImage.init(named: "a9"), UIImage.init(named: "a10"), UIImage.init(named: "a11"), UIImage.init(named: "a12"), UIImage.init(named: "a13"), UIImage.init(named: "a14"), UIImage.init(named: "a15"), UIImage.init(named: "a16"), UIImage.init(named: "a17"), UIImage.init(named: "a18"), UIImage.init(named: "a19"), UIImage.init(named: "a20"), UIImage.init(named: "a21"), UIImage.init(named: "a22"), UIImage.init(named: "a23"), UIImage.init(named: "a24"), UIImage.init(named: "a25"), UIImage.init(named: "a26"), UIImage.init(named: "a27"), UIImage.init(named: "a28"), UIImage.init(named: "a29"), UIImage.init(named: "a30"), UIImage.init(named: "a31"), UIImage.init(named: "a32"), UIImage.init(named: "a33"), UIImage.init(named: "a34"), UIImage.init(named: "a35"), UIImage.init(named: "a36"), UIImage.init(named: "a37"), UIImage.init(named: "a38"), UIImage.init(named: "a39"), UIImage.init(named: "a40"), UIImage.init(named: "a41"), UIImage.init(named: "a42"), UIImage.init(named: "a43")]
     img_loader.animationImages = arrImg as? [UIImage]
     img_loader.animationDuration = 0.5
     img_loader.startAnimating()
     }
     */
    
    func showLoader() {
        
        UIApplication.shared.keyWindow?.addSubview(loader)
        myActivityIndicator.startAnimating()
    }
    
    func hideLoader() {
        // Call stopAnimating() when need to stop activity indicator
        myActivityIndicator.stopAnimating()
        loader.removeFromSuperview()
        
    }
    
    
}
