//
//  AppUtils.swift
//  FastSell
//
//  Created by HYUBYN on 4/6/16.
//  Copyright © 2016 hyubyn. All rights reserved.
//

import UIKit

final class AppUtils {
    static let shareInstance = AppUtils()
    
    class func addRadius(view: UIView, radius: CGFloat = 5) {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }
    
    class func showAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
}
