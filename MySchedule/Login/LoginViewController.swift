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
    
    func checkUsernamePassword(username:String, password: String) -> Int{
        let defaults = UserDefaults.standard
        if let login = defaults.value(forKey: "Login") as? Array<String>{
            let usernamex = login[0]
            let passwordx = login[1]
            if (usernamex == username) && (passwordx == password){
                return 1
            }else{
                return 2
            }
        
        }else{
            return 3
        }
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
        
        switch(check){
        case 1: print("Succesful Login")
        case 2: alert(message: "Please fill in correct username and password", title: "Incorrect password or username")
        case 3: alert(message: "Please sign up", title: "No Account")
        default: alert(message: "Something went wrong", title: "Error")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let login = defaults.value(forKey: "Login") as! [String]
        let username = login[0]
        let password = login[1]

        self.passwordTextField.text = password
        self.usernameTextField.text = username
        
//        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "Login"{
            let username = usernameTextField.text ?? ""
            let password = passwordTextField.text ?? ""
        
            let check = checkUsernamePassword(username: username, password: password)
            
            if check == 1{
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

