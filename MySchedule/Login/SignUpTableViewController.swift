//
//  SignUpTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 29/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class SignUpTableViewController: UITableViewController {
    
    
    //Layout Data
    
    let numberOfRows = [3,3,3,1]
    
    let alertHelp = CreateAlert()
    
    
    //Outlets
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAdress: UITextField!
    @IBOutlet weak var domainName: UITextField!
    @IBOutlet weak var activationCode: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord1: UITextField!
    @IBOutlet weak var passWord2: UITextField!
    @IBOutlet weak var studentCode: UITextField!
    
    
    //Functions
    
    func checkPasswords(password1:String, password2:String) -> Bool{
        if (password1 == password2){
            return true
        }else{
            return false
        }
    }
    
    func checkFields() -> Bool {
        let firstNameX = firstName.text ?? "Nothing"
        let lastNameX = lastName.text ?? "Nothing"
        let emailAdressX = emailAdress.text ?? "Nothing"
        let domainNameX = domainName.text ?? "Nothing"
        let activationCodeX = activationCode.text ?? ""
        let studentCodeX = studentCode.text ?? "Nothing"
        let userNameX = userName.text ?? "kdjfkj"
        let password1 = passWord1.text ?? "Nothingx"
        let password2 = passWord2.text ?? "Nothing"
        if (firstNameX == "")||(lastNameX == "")||(emailAdressX == "")||(domainNameX == "")||(activationCodeX == "")||(password1 == "")||(password2 == "")||(userNameX == "")||(studentCodeX == ""){
            return false
        }else{
            return true
        }
    }

    
    //Actions
    
    @IBAction func passwordEditingDidEnd(_ sender: UITextField) {
        let password1 = passWord1.text ?? "Geen wachwoord1"
        let password2 = passWord2.text ?? "Geen wachtwoord2"
        let check = checkPasswords(password1: password1, password2: password2)
        if (check == false){
            passWord2.backgroundColor = UIColor.red
        }else{
            print("Passwords match")
        }
    }
    

    @IBAction func signUp(_ sender: UIButton) {
        let password1 = passWord1.text ?? "Nothingx"
        let password2 = passWord2.text ?? "Nothing"
        let check = checkPasswords(password1: password1, password2: password2)
        if (check == true){
            let firstNameX = firstName.text ?? "Nothing"
            let lastNameX = lastName.text ?? "Nothing"
            let emailAdressX = emailAdress.text ?? "Nothing"
            let domainNameX = domainName.text ?? "Nothing"
            let activationCodeX = activationCode.text ?? ""
            let userNameX = userName.text ?? "kdjfkj"
            let studentCodeX = studentCode.text ?? ""
            if (checkFields() == false) {
                alertHelp.alert(message: "Please fill in all fields", title: "Empty fields")
            }else{
                let nameList = [firstNameX,lastNameX]
                let loginSet = [userNameX, password1]
                let defaults = UserDefaults.standard
                defaults.set(nameList, forKey: "Name")
                defaults.set(emailAdressX,forKey: "Emailadress")
                defaults.set(loginSet,forKey: "Login")
                defaults.set(domainNameX, forKey: "Domain name")
                defaults.set(activationCodeX, forKey: "Activation code")
                defaults.set(studentCodeX, forKey: "Student code")
                performSegue(withIdentifier: "SignUp", sender: nil)
            }
        }else{
            alertHelp.alert(message: "Passwords don't match", title: "Password")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "Background1"))

        self.navigationItem.title = "Sign Up"
        self.tableView.allowsSelection = false
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "SignUp"{
            let password1 = passWord1.text ?? "Nothingx"
            let password2 = passWord2.text ?? "Nothing"
            if checkFields() == true{
                if checkPasswords(password1: password1, password2: password2) == true{
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        }else{
            return true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfRows.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows[section]
    }
}
