//
//  ProfileTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 06/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    let numberOfRows = [6,6,4,1]
    
    //Outlets
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAdress: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var studentCode: UITextField!
    
    @IBOutlet weak var friend1: UITextField!
    @IBOutlet weak var friend2: UITextField!
    @IBOutlet weak var friend3: UITextField!
    @IBOutlet weak var friend4: UITextField!
    @IBOutlet weak var friend5: UITextField!
    
    @IBOutlet weak var subject1: UITextField!
    @IBOutlet weak var subject2: UITextField!
    @IBOutlet weak var subject3: UITextField!
    
    
    //Functions
    func checkFields() -> Bool{
        let firstname = firstName.text!
        let lastname = lastName.text!
        let emailadress = emailAdress.text!
        let username = userName.text!
        let studentcode = studentCode.text!
        
        if (firstname == "")||(lastname == "")||(username == "")||(emailadress == "")||(studentcode == ""){
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
    
    @IBAction func changePassword(_ sender: UIButton) {
        
    }
    
    @IBAction func saveChanges(_ sender: UIButton) {
        let check = checkFields()
        if check == true{
            alert(message: "Please fill in all fields", title: "Empty Fields")
        }else{
            let defaults = UserDefaults.standard
            
            let firstname = firstName.text!
            let lastname = lastName.text!
            let emailadress = emailAdress.text!
            let username = userName.text!
            let studentcode = studentCode.text!
            
            let login = defaults.value(forKey: "Login") as! [String]
            let loginSet = [username, login[1]]
            
            defaults.set([firstname, lastname], forKey: "Name")
            defaults.set(emailadress,forKey: "Emailadress")
            defaults.set(loginSet,forKey: "Login")
            defaults.set(studentcode, forKey: "Student code")
            
            
            alert(message: "", title: "Changes were made succesful")
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let name = defaults.value(forKey: "Name") as? [String]{
            firstName.text = name[0]
            lastName.text = name[1]
        }
        
        if let login = defaults.value(forKey: "Login") as? [String]{
            userName.text = login[0]
        }
        
        if let email = defaults.value(forKey: "Emailadress") as? String{
            emailAdress.text = email
        }
        
        if let studentcode = defaults.value(forKey: "Student code") as? String{
            studentCode.text = studentcode
        }
        
        
        //bestaande gegevens inladen.

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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "saveChanges"{
            let check = checkFields()
            if check == true{
                return true
            }else{
                return false
            }
        }else{
            return true
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
