//
//  ViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 08/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //Layout data
    
    
    
    //Functions
    
    func checkUsernamePassword(username:String, password: String) -> Bool{
        
        
        
        return true
    }
    
    func topMostController() -> UIViewController {
        var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        return topController!
    }
    
    func alert(message:String, title:String){
        let alert=UIAlertController(title: title, message: message, preferredStyle: .alert);
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            
        }
        alert.addAction(cancelAction)
        topMostController().present(alert, animated: true, completion: nil);
    }
    
    
    //Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    //Actions
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let check = checkUsernamePassword(username:username, password:password)
        
        if check == true{
            // set up new view
        }else{
            alert(message: "Please fill in correct username and password", title: "Incorrect password or username")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.ddd
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "Login"{
            let username = usernameTextField.text ?? ""
            let password = passwordTextField.text ?? ""
        
            let check = checkUsernamePassword(username: username, password: password)
            
            if check == true{
                return true
            }else{
                return false
            }
        }else{
            return true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

