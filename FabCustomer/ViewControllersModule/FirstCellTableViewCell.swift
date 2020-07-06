//
//  FirstCellTableViewCell.swift
//  FabCustomer
//
//  Created by Apple on 03/07/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit

class FirstCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cancel_Pay_ButtonConstraint : NSLayoutConstraint!
    @IBOutlet weak var cancel_Pay_View: UIView!
    @IBOutlet weak var cancel_Pay_Button : UIButton!
    @IBOutlet weak var btnPercentageComplete: UIButton!
    @IBOutlet weak var btnJobComplete: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var address_label: UILabel!
    @IBOutlet weak var date_label: UILabel!
    @IBOutlet weak var response_label: UILabel!
    @IBOutlet weak var pay_label: UILabel!
    @IBOutlet weak var payResponse_label: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCatName: UILabel!
    @IBOutlet weak var imgeArtist: UIImageView!
    
    @IBOutlet weak var viewInvoice_Button : UIButton!
    
    @IBOutlet weak var viewInvoice_Height : NSLayoutConstraint!
    
    var counter = 0.0
    var timer = Timer()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func stopTimer(){
        timer.invalidate()
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.timerAction1)), userInfo: nil, repeats: false)
        
        counter = 0
        
    }
    
    @objc func timerAction1() {
    }
    
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.timerAction)), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        counter += 1
        
        lblTimer.text = timeString(time: TimeInterval(counter)) + "Working Time"
        lblTimer.textColor = Constant.Feb_Bas_Col
        
        //count_Label.text = "\(counter)"
    }
    func timeString(time:TimeInterval) -> String {
        
        
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
