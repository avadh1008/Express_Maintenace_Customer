//
//  Validation.swift
//  Pixel eCommerce
//
//  Created by samyotech on 23/11/17.
//  Copyright © 2017 samyotech. All rights reserved.
//

import UIKit

extension UIViewController {
//class Validation : NSObject {
    
    
    
    
    //Check url valid or not
    func isValidUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    func generateRandomDigits(_ digitNumber: Int) -> String {
        var number = ""
        for i in 0..<digitNumber {
            var randomNumber = arc4random_uniform(10)
            while randomNumber == 0 && i == 0 {
                randomNumber = arc4random_uniform(10)
            }
            number += "\(randomNumber)"
        }
        return number
    }
    
    func rating_Mathod(ratingStr : String!)  -> String!
    {
        
        if let rat_double = Double(ratingStr!)
        {
            let desimal_Str = String(format:"%.1f", rat_double )
            return   "("+"\(desimal_Str)"+"/5)"
        }
        else
        {
            return   "("+"\(0)"+"/5)"
        }
        
    }
    func rat_Mathod(ratingStr : String!)  -> Double!
    {
        
        if let rat_double = Double(ratingStr!) {
            let desimal_Str = String(format:"%.1f", rat_double)
            return Double(desimal_Str)!
        }
        else
        {
            return 0.0
        }
        
        
        
        
    }
    
    //Email Validation
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //Username Validation
    func isValidUsername(Input:String) -> Bool {
        let RegEx = "\\A\\w{7,18}\\z"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
    }
    
    
    /*Password Validation
     1 - Password length is 8.
     2 - One Alphabet in Password.
     3 - One Special Character in Password.
     
     ^                                          -Start Anchor.
     (?=.*[A-Z].*[A-Z])                         -Ensure string has two uppercase letters.
     (?=.[$@$#!%?&])                            -Ensure string has one special character.
     (?=.*[0-9].*[0-9])                         -Ensure string has two digits.
     (?=.*[a-z].*[a-z].?*[a-z])                 -Ensure string has three lowercase letters.
     {8,}                                       -Ensure password length is 8.
     $                                          -End Anchor. */
    func isPasswordValid( password : String) -> Bool
    {
        if password.count >= 6
        {
            return true
        }
        else
        {
            return false
        }
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*(a-z))(?=.*[$@$#!%*?&])(A-Za-z\\d$@$#!%*?&]){6,}")
//        return passwordTest.evaluate(with: password)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize.init(width: newWidth, height: newHeight))
        image.draw(in: CGRect.init(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    func RBSquareImage(image: UIImage) -> UIImage {
        let originalWidth  = image.size.width
        let originalHeight = image.size.height
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        var edge: CGFloat = 0.0
        
        if (originalWidth > originalHeight) {
            // landscape
            edge = originalHeight
            x = (originalWidth - edge) / 2.0
            y = 0.0
            
        } else if (originalHeight > originalWidth) {
            // portrait
            edge = originalWidth
            x = 0.0
            y = (originalHeight - originalWidth) / 2.0
        } else {
            // square
            edge = originalWidth
        }
        
        let cropSquare = CGRect.init(x: x, y: y, width: edge, height: edge)
        let imageRef = image.cgImage!.cropping(to: cropSquare);
        
        return UIImage.init(cgImage: imageRef!, scale: UIScreen.main.scale, orientation: image.imageOrientation)
    }
    
    func randomString(length: Int) -> String {
        
        
        let letters : String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = letters.count
        var randomString:String = ""
        for _ in 0 ..< length {
            let rand = Int.random(in: 0..<len)
            randomString += letters.map { String($0) }[rand]
        }
        return randomString
    }
    
    func conv_Str_Int_Mathod(str_In_V : String!)  -> Int!
    {
        if  let Int_Str = Int(str_In_V)
        {
            return Int_Str
        }
        else
        {
            return 0
        }
        
    }
    func double_Convert_Mathod(dobStr : String!)  -> Double!
    {
        
        if let doudle_val = Double(dobStr) {
            
            return doudle_val
            
        } else {
            
            return 0.0
        }
    }
    
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        
        if let frame = frame {
            child.view.frame = frame
        }
        
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    
    func timeStamp_Str_Mathod( timeSt : String! )  -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat =  "dd MMM yyyy hh:mm a"
        if let timeStr = timeSt
        {
            if let time_double = Double(timeStr) {
                let dateTimeStamp = Date(timeIntervalSince1970:time_double  ) //UTC time
                let dateString = dateFormatter.string(from:dateTimeStamp )
                return dateString
            }
            else
            {
                let dateString = dateFormatter.string(from:Date() )
                return dateString
            }
        }else
        {
            let dateString = dateFormatter.string(from:Date() )
            return dateString
        }
        
        
        
    }
    
    func timeStamp_Str_MathodGMT( timeSt : String! )  -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
        dateFormatter.dateFormat =  "dd MMM yyyy hh:mm a"
        if let timeStr = timeSt
        {
            if let time_double = Double(timeStr) {
                let dateTimeStamp = Date(timeIntervalSince1970:time_double  ) //UTC time
                let dateString = dateFormatter.string(from:dateTimeStamp )
                return dateString
            }
            else
            {
                let dateString = dateFormatter.string(from:Date() )
                return dateString
            }
        }else
        {
            let dateString = dateFormatter.string(from:Date() )
            return dateString
        }
        
        
        
    }
    
}

extension UserDefaults {
    
//    //MARK: Check Login
    func setLoggedIn(value: Bool) {
        set(value, forKey:"Login_User_bool")
        //synchronize()
    }

    func isLoggedIn()-> Bool {
        return bool(forKey:"Login_User_bool")
    }
    
    //MARK: Save User Data
    func setUserID(value: Int){
        set(value, forKey:"Login_User_id")
        //synchronize()
    }
    
    //MARK: Retrieve User Data
    func getUserID() -> Int{
        return integer(forKey:"Login_User_id")
    }
}

extension Date {
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year" :
                "\(year)" + " " + "years"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month" :
                "\(month)" + " " + "months"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day" :
                "\(day)" + " " + "days"
        } else {
            return "A moment ago"
            
        }
        
    }
}
