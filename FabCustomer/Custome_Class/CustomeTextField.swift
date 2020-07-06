 
import Foundation
 
import UIKit

@IBDesignable
class CustomeTextField : UITextField {
  
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            layer.masksToBounds = true
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            layer.masksToBounds = true
            return layer.borderWidth
        }
        set {
            layer.masksToBounds = true
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                layer.masksToBounds = true
                return UIColor(cgColor: color)
            }
            return nil
        } set {
            if let color = newValue {
                layer.masksToBounds = true
                layer.borderColor = color.cgColor
            } else {
                layer.masksToBounds = true
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var montMedium  : Bool {
        
        get {
            
            return false
        }
        set {
            if newValue == true {
              //  self.font = UIFont(name: montserratMedium, size: self.font?.pointSize ?? 14)
                contentScaleFactor = 0.5
            }
        }
        
    }
    
    @IBInspectable
    var montLight   : Bool {
        
        get {
            
            return false
        }
        set {
            if newValue == true {
                
              
                
              //  self.font = UIFont(name: montserratLight, size: self.font?.pointSize ?? 14)
                contentScaleFactor = 0.5
                
            }
        }
        
    }
    
    
    @IBInspectable
    var montRegular   : Bool {
        
        get {
            
            return false
        }
        set {
            if newValue == true {
             
                //self.font = UIFont(name: montserratRegular, size: self.font?.pointSize ?? 14)
                contentScaleFactor = 0.5
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addDoneButtonOnKeyboard()
      
    }
    
    override internal func awakeFromNib() {
        super.awakeFromNib()
        
        self.text = AMPLocalizeUtils.defaultLocalizer.stringForKey(key: (text!))
        
        self.placeholder = AMPLocalizeUtils.defaultLocalizer.stringForKey(key: self.placeholder ?? "")
       
    }
    
    
       @IBInspectable var alignMentEnabel   : Bool {
           
           get {
               
               return false
           }
           set {
               if newValue == true {
                
                           /*  if     let langTy = UserDefaults.standard.getLanguageType()  ,  "ar" == langTy {
                              self.textAlignment = .right
                          } else {
                              self.textAlignment = .left
                          }*/
               }
           }
       }
       
    
    
    private struct Constants {
        static let defaultiOSPlaceholderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
    }
    
    
    
    
    
    
    
 
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50)) //CGRectMake(0, 0, 320, 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    
}
