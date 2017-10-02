//
//  SignUpTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 29/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class SignUpTableViewController: UITableViewController {
    
    
    //TableView Setup
    
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
    
    
    //Actions
    
    @IBAction func passwordEditingDidEnd(_ sender: UITextField) {
        let password1 = passWord1.text ?? "Geen wachwoord1"
        let password2 = passWord2.text ?? "Geen wachtwoord2"
        let check = checkPasswords(password1: password1, password2: password2)
        
    }
    

    @IBAction func signUp(_ sender: UIButton) {
        
        let password1 = passWord1.text ?? "Nothing"
        let password2 = passWord2.text ?? "Nothing"
        let check = checkPasswords(password1: password1, password2: password2)
        
        if (check == true){
            let firstNameX = firstName.text ?? "Nothing"
            let lastNameX = lastName.text ?? "Nothing"
            let emailAdressX = emailAdress.text ?? "Nothing"
            let domainNameX = domainName.text ?? "Nothing"
            let activationCodeX = activationCode.text ?? "Nothing"
            let userNameX = userName.text ?? "Nothing"
            
            if firstNameX == "Nothing"||lastNameX == "Nothing"||emailAdressX == "Nothing"||domainNameX == "Nothing"||activationCodeX == "Nothing"||userNameX == "Nothing"||password2 == "Nothing"||password1 == "Nothing"{
                let alertController = UIAlertController(title: "Non-matching Passwords", message:
                    "Please use the same passwords", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }else{
                let nameList = [firstNameX,lastNameX]
                let loginSet = [userNameX, password1]
                let defaults = UserDefaults.standard
                defaults.set(nameList, forKey: "Name")
                defaults.set(emailAdressX,forKey: "Emailadress")
                defaults.set(loginSet,forKey: "Login")
                defaults.set(domainNameX, forKey: "Domain name")
                defaults.set(activationCodeX, forKey: "Activation code")}
            
        }else{
            let alertController = UIAlertController(title: "Missing Data", message:
                "Please fill in all the fields", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)        }
    }
    
    
    //Functions

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
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
