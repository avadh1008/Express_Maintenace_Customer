//
//  sd.swift
//
//
//  Created by Samyotech on 22/05/18.
//  Copyright © 2018 Samyotech. All rights reserved.
//

import UIKit
extension NSDictionary {
    var json: Data {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            let str_val =  String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
            
            if str_val == "Not a valid JSON"
            {
                return invalidJson.data(using: .utf8)!
            }
            else
            {
                return jsonData
            }
            
            
        }
        catch
        {
            return  invalidJson.data(using: .utf8)!
        }
    }
    
    func dict2json() -> Data {
        return json
    }
}

extension NSArray {
    var json: Data {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            let str_val =  String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
            
            
         
            
            if str_val == "Not a valid JSON"
            {
                return invalidJson.data(using: .utf8)!
            }
            else
            {
                return jsonData
            }
            
            
        }
        catch
        {
            return  invalidJson.data(using: .utf8)!
        }
    }
    
    func arr2json() -> Data {
        return json
    }
}

extension NSArray {
    var json_Data :  [String: Any] {
       
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
           
            
            
            if  let JSONString = String(data: jsonData, encoding:          String.Encoding.utf8) {
                print(JSONString)
                
               if  let json_Val = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
               {
                return  json_Val
                }
                else
               {
                return ["String": "Any"]
                }
                
                
            }
            else
            {
                return  ["String": "Any"]
            }
            
            
            

        }
        catch
        {
            return   ["String": "Any"]
        }
    }
    
    func arr_Data_json() ->  [String: Any] {
        return json_Data
    }
}
