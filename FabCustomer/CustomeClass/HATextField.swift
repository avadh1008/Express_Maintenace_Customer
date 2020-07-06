import UIKit

@IBDesignable
class HATextField: UITextField {
     let defaultLocalizer = AMPLocalizeUtils.defaultLocalizer
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + iconWidth*2, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + iconWidth*2, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        layer.cornerRadius = radius
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    var iconWidth: CGFloat = 15
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var radius: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: iconWidth, height: iconWidth))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
       attributedPlaceholder = NSAttributedString(string: defaultLocalizer.stringForKey(key: placeholder != nil ?  placeholder! : "") , attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    
    @IBInspectable public var placeholderColor: UIColor? {
        get {
            if let attributedPlaceholder = attributedPlaceholder, attributedPlaceholder.length > 0 {
                var attributes = attributedPlaceholder.attributes(at: 0,
                                                                  longestEffectiveRange: nil,
                                                                  in: NSRange(location: 0, length: attributedPlaceholder.length))
                return attributes[NSAttributedString.Key.foregroundColor] as? UIColor
            }
            return nil
        }
        set {
            if let placeholderColor = newValue {
                attributedPlaceholder = NSAttributedString(string: defaultLocalizer.stringForKey(key: placeholder != nil ?  placeholder! : ""),
                                                           attributes:[NSAttributedString.Key.foregroundColor: placeholderColor])
            } else {
                // The placeholder string is drawn using a system-defined color.
                attributedPlaceholder = NSAttributedString(string: defaultLocalizer.stringForKey(key: placeholder != nil ?  placeholder! : ""))
            }
        }
    }
    
}
/*public extension UITextField
*/
