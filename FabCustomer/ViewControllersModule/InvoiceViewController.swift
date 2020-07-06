//
//  InvoiceViewController.swift
//  FabArtist
//
//  Created by AmitSharma on 02/07/19.
//  Copyright © 2019 Samyotech. All rights reserved.
//

import UIKit

class InvoiceViewController: UIViewController {
    
    class func viewController() -> InvoiceViewController {
        return "Main".viewController("InvoiceViewController") as! InvoiceViewController
    }

    
    var invoicePaid : InvoiceSrtuctArr?
    
    var current_booking : Get_current_booking_Data_Struct?
    

    @IBOutlet weak var userImgV         : UIImageView!
    @IBOutlet weak var inviceLabel          : UILabel!
    @IBOutlet weak var nameLabel            : UILabel!
    @IBOutlet weak var typeLabel            : UILabel!
    @IBOutlet weak var invoiceDateLabel     : UILabel!
    @IBOutlet weak var dueDateLabel         : UILabel!
    @IBOutlet weak var type2Label           : UILabel!
    @IBOutlet weak var amountLabel          : UILabel!
    @IBOutlet weak var priceLabel           : UILabel!
    
    @IBOutlet weak var discountLabel : UILabel!
    
    @IBOutlet weak var totalLabel : UILabel!
    @IBOutlet weak var nameCateLabel : UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMathod()
    }
    
    
    @IBAction func left_Mathod_Action( _ sender : UIButton!)
    {
       self.dismiss(animated: false)
    }
    
    func updateMathod()
    {
        if invoicePaid != nil
        {
            userImgV.sd_setImage(with: URL(string: (invoicePaid?.userImage)!), placeholderImage: UIImage(named: "profile"))
            
            inviceLabel     .text  = "Invoice Id # "+(invoicePaid?.invoice_id)!
            nameLabel       .text  = invoicePaid?.userName
            typeLabel       .text  = invoicePaid?.categoryName
            invoiceDateLabel.text  = invoicePaid?.booking_date
            dueDateLabel    .text  = invoicePaid?.booking_date
            invoiceDateLabel.text = invoicePaid?.booking_date
            dueDateLabel.text = invoicePaid?.booking_date
            
            type2Label      .text  = invoicePaid?.categoryName
            amountLabel     .text  = "\(invoicePaid?.currency_type! ?? "" ) \( invoicePaid?.total_amount! ?? "0")"
            priceLabel      .text  =  "\(invoicePaid?.currency_type! ?? "" ) \( invoicePaid?.total_amount! ?? "0")"
            discountLabel.text  =  "\(invoicePaid?.currency_type! ?? "" ) \( invoicePaid?.discount_amount! ?? "0")"
            if let disAmount = invoicePaid?.discount_amount
            {
                discountLabel.text  =  (invoicePaid?.currency_type!)! + disAmount
                
            }
            
            totalLabel.text = (invoicePaid?.currency_type!)! + (invoicePaid?.final_amount)!
            
        }
        else
        {
            if current_booking?.invoiceDic != nil
            {
                userImgV.sd_setImage(with: URL(string: (current_booking?.userImage)!), placeholderImage: UIImage(named: "profile"))
                
                inviceLabel     .text  = "Invoice id # "+(current_booking?.invoiceDic?.invoice_id)!
                nameLabel       .text  = current_booking?.invoiceDic?.userName
                typeLabel       .text  = current_booking?.invoiceDic?.categoryName
                invoiceDateLabel.text  = current_booking?.invoiceDic?.booking_date
                dueDateLabel    .text  = current_booking?.invoiceDic?.booking_date
                invoiceDateLabel.text = timeStamp_Str_Mathod(timeSt: current_booking?.invoiceDic?.booking_date)
                dueDateLabel.text = timeStamp_Str_Mathod(timeSt: current_booking?.invoiceDic?.booking_date)
                
                type2Label      .text  = current_booking?.invoiceDic?.categoryName
                amountLabel     .text  = "\(current_booking?.invoiceDic?.currency_type ?? "" ) \( current_booking?.invoiceDic?.total_amount ?? "0")"
                priceLabel      .text  =  "\(current_booking?.invoiceDic?.currency_type ?? "" ) \( current_booking?.invoiceDic?.total_amount ?? "0")"
                discountLabel.text  =  "\(current_booking?.invoiceDic?.currency_type ?? "" ) \( current_booking?.invoiceDic?.discount_amount ?? "0")"
                if current_booking?.invoiceDic?.discount_amount == ""
                {
                    discountLabel.text  =  (current_booking?.invoiceDic?.currency_type)! + " 0"
                    
                }
                
                totalLabel.text = (current_booking?.invoiceDic?.currency_type)! + (current_booking?.invoiceDic?.total_amount)!
                
            }
           
        }
       
        
    }
    
}
