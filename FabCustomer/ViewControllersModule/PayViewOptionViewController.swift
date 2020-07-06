

import UIKit

class PayViewOptionViewController: UIViewController {

    class func viewController() -> PayViewOptionViewController {
        return "Main".viewController("PayViewOptionViewController") as! PayViewOptionViewController
    }
   
    var checkIndex  = 0
    var navTag = 0 
    var walletCheck = 0
    var amount_Str  = ""
    var otherUserId = ""
    var invoiceId = ""
     var finished_Booking_Dic  = Get_invoice_struct()
    
    // ------------PayMent Option  Outlet----------//
    
    
    @IBOutlet weak var payment_option_view : UIView!
    @IBOutlet weak var payment_paypal_Button : UIButton!
    @IBOutlet weak var payment_Stripe_Button : UIButton!
    @IBOutlet weak var payment_cancel_Button : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func selectionAction(_ seder : UIButton!)
    {
        switch seder {
        case payment_paypal_Button:
            
            
                let pay_WVC : Pay_WebViewCont  = Pay_WebViewCont.viewController()
                
                pay_WVC.finished_Booking_Dic =  finished_Booking_Dic
                
                if navTag == 1 {
                pay_WVC.checkIndex = 3
                } else {
                 pay_WVC.checkIndex = 1
                }
                
                pay_WVC.amount_Str = amount_Str
                 self.dismiss(animated: false )
            
                app_delegate.navi_obj?.pushViewController(pay_WVC , animated: true)
                
           
            break;
        case payment_Stripe_Button:
        
                let pay_WVC : Pay_WebViewCont  = Pay_WebViewCont.viewController()
                 pay_WVC.finished_Booking_Dic =  finished_Booking_Dic
                if navTag == 1 {
                pay_WVC.checkIndex = 4
                } else {
                pay_WVC.checkIndex = 2
                }
                pay_WVC.invoiceId = invoiceId 
                pay_WVC.otherUserId = otherUserId
                pay_WVC.amount_Str = amount_Str
                 self.dismiss(animated: false )
                app_delegate.navi_obj?.pushViewController(pay_WVC , animated: true)
            
            break;
            
        case payment_cancel_Button:
             self.dismiss(animated: false )
            break;
        default:
            break;
        }
        
    }
    
    


}
