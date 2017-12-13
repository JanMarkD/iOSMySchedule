//
//  CreateAlert.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 26/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import Foundation
import UIKit

class CreateAlert: NSObject{
    
    //Search for the viewcontroller that is currently on screen, in order to present alert on that viewcontroller.
    
    func topMostController() -> UIViewController {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        return topController!
    }
    
    //Creates an UIAlertController with a title, message and a default "OK" dismiss button and presents in on current viewcontroller.
    
    func alert(message:String, title:String){
        let alert=UIAlertController(title: title, message: message, preferredStyle: .alert);
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            
        }
        alert.addAction(cancelAction)
        topMostController().present(alert, animated: true, completion: nil);
    }
    
}
