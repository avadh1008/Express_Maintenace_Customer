//
//  ExtentionFabCustomer.swift
//  FabCustomer
//
//  Created by Samyotech on 04/10/19.
//

import Foundation
extension String {
    func viewController (_ vc: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: self, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vc)
        
        app_delegate.story_obj = storyboard
        
        return vc
    }
}
