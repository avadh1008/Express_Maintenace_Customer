//
//  TestViewController.swift
//  FabCustomer
//
//  Created by Samyotech on 04/10/19.
//

import UIKit

class TestViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let vvc  = SplashViewController.viewController()
        self.navigationController?.pushViewController(vvc, animated: true)
    }
    


}
