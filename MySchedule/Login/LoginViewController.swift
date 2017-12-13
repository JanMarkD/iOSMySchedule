//
//  ViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 08/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

// TODO: Design tableviewcells and text colors.

class LoginViewController: UIViewController {
    
    
    //Properties
    
    let alertHelp = CreateAlert()
    
    let defaults = UserDefaults.standard
    
    var keyboardAdjusted = false
    
    var lastKeyboardOffset: CGFloat = 0.0
    
    
    //Functions
    
    //Checks if username and password are correct.
    
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
    
    //Resigns keyboard if "Done" is tapped.
    
    @objc func resignKeyboard(){
        self.view.endEditing(true)
    }
    
    //Makes view move a little up, to provide space for keyboard.
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if keyboardAdjusted == false {
            lastKeyboardOffset = getKeyboardHeight(notification: notification)
            view.frame.origin.y -= lastKeyboardOffset
            keyboardAdjusted = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if keyboardAdjusted == true {
            view.frame.origin.y += lastKeyboardOffset
            keyboardAdjusted = false
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height - 200
    }
    
    
    //Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //Actions
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {}
    
    @IBAction func loginButton(_ sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let check = checkUsernamePassword(username:username, password:password)
        switch(check){
        case 1: print("Succesful Login")
        case 2: alertHelp.alert(message: "Please fill in correct username and password", title: "Incorrect password or username")
        case 3: alertHelp.alert(message: "Please sign up", title: "No Account")
        default: alertHelp.alert(message: "Something went wrong", title: "Error")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Checks if user wants his username and password automatically filled in and does according to that value.
        
        if let autoFillLogin = defaults.value(forKey: "Autofill Login") as? Bool{
            if autoFillLogin{
                if let login = defaults.value(forKey: "Login") as? [String]{
                    usernameTextField.text = login[0]
                    passwordTextField.text = login[1]
                }
            }
        }else{
            defaults.set(true, forKey: "Autofill Login")
            if let login = defaults.value(forKey: "Login") as? [String]{
                usernameTextField.text = login[0]
                passwordTextField.text = login[1]
            }
        }
        
        //Configures toolbar above keyboard with "Done" button.
        
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.barStyle = UIBarStyle.default
        keyboardToolBar.isTranslucent = true;
        let doneBtn = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target:self, action: #selector(resignKeyboard))
        keyboardToolBar.setItems([doneBtn], animated: true)
        keyboardToolBar.sizeToFit()
        
        usernameTextField.inputAccessoryView = keyboardToolBar
        passwordTextField.inputAccessoryView = keyboardToolBar
        
        //Makes view move a little up, to provide space for keyboard.
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //Makes view move a little up, to provide space for keyboard.
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //Makes sure NavigationBar is hidden in this view.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //Checks if login data is correct and performs segue if so.

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "Login"{
            let username = usernameTextField.text!
            let password = passwordTextField.text!
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
}

