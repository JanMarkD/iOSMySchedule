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
    
    
    //Outlets
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var emailAdress: UITextField!
    @IBOutlet weak var domainName: UITextField!
    @IBOutlet weak var activationCode: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord1: UITextField!
    @IBOutlet weak var passWord2: UITextField!
    
    
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
        //let studentCodeX = studentCode.text ?? "Nothing"
        let userNameX = userName.text ?? "kdjfkj"
        let password1 = passWord1.text ?? "Nothingx"
        let password2 = passWord2.text ?? "Nothing"
        
        if (firstNameX == "")||(lastNameX == "")||(emailAdressX == "")||(domainNameX == "")||(activationCodeX == "")||(password1 == "")||(password2 == "")||(userNameX == ""){
            return false
        }else{
            return true
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
            
            if (checkFields() == false) {
                
                alert(message: "Please fill in all fields", title: "Empty fields")
                
            }else{
                
                let nameList = [firstNameX,lastNameX]
                let loginSet = [userNameX, password1]
                let defaults = UserDefaults.standard
                defaults.set(nameList, forKey: "Name")
                defaults.set(emailAdressX,forKey: "Emailadress")
                defaults.set(loginSet,forKey: "Login")
                defaults.set(domainNameX, forKey: "Domain name")
                defaults.set(activationCodeX, forKey: "Activation code")
                
                performSegue(withIdentifier: "SignUp", sender: nil)
                
            }
            
        }else{
            alert(message: "Passwords don't match", title: "Password")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
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
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfRows.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberOfRows[section]
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
