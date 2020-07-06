//
//  AMPLocalizeUtils.swift
//  MyCatalogue
//
//  Created by anoopm on 09/02/17.
//  Copyright © 2017 anoopm. All rights reserved.
//

import UIKit

class AMPLocalizeUtils: NSObject {

    static let defaultLocalizer = AMPLocalizeUtils()
    var appbundle = Bundle.main
    
    func setSelectedLanguage(lang: String) {
        guard let langPath = Bundle.main.path(forResource: lang, ofType: "lproj") else {
            appbundle = Bundle.main
            return
        }
        appbundle = Bundle(path: langPath)!
    }
    
    func stringForKey(key: String) -> String {
        
       // let string = "    example  "
        let trimmed = key.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
        print(">" + trimmed + "<")
        
        
        return appbundle.localizedString(forKey: key, value: "", table: nil)
    }
}

extension String {
    var localation : String {
        return AMPLocalizeUtils.defaultLocalizer.stringForKey(key: self)
    }
}

/*
 func stringForKey(key: String) -> String {
 
 
 let separators = CharacterSet(charactersIn: " ")
 let address_Arr = key.components(separatedBy: separators)//.characters.split(separator: " ")//.map//.map(String)
 
 
 var address_Str = ""
 
 for arr_str  in address_Arr
 {
 address_Str += appbundle.localizedString(forKey: arr_str, value: "", table: nil)
 }
 
 return address_Str
 }
 */
