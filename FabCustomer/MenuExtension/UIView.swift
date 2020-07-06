//
//  UIView.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 11/5/15.
//  Copyright © 2015 Yuji Hato. All rights reserved.
//

import UIKit

extension UIView {
    class func loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = String.className(viewType)
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
    
    class func loadNib() -> Self {
        return loadNib(self)
    }
}

//[END ios_10_message_handling]
extension String {
    var timeZone : String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier:"GMT+5:30")
        dateFormatter.dateFormat = "OOOO"
        let zone = dateFormatter.string(from: Date())
        return zone
    }
}
extension UIApplication {
    typealias BackgroundTaskCompletion = () -> Void
    func executeBackgroundTask(f: (BackgroundTaskCompletion) -> Void) {
        let identifier = beginBackgroundTask {
            // nothing to do here
        }
        f() { [unowned self] in
            self.endBackgroundTask(identifier)
        }
    }
}
extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
extension UITableView {
    func scrollToLastCall(animated : Bool) {
        let lastSectionIndex = self.numberOfSections - 1 // last section
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: animated)
    }
}
