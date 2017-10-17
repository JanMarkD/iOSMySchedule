//
//  ChangePasswordTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 06/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class ChangePasswordTableViewController: UITableViewController {
    
    let numberOfRows = [3,1,1]
    
    //Outlets
    
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword1: UITextField!
    @IBOutlet weak var newPassword2: UITextField!
    
    
    //Functions
    
    func checkOldPassword() -> Bool{
        let defaults = UserDefaults.standard
        let passwordx = defaults.value(forKey: "Login") as! String
        if oldPassword.text == passwordx{
            return true
        }else{
            return false
        }
    }
    
    func checkPasswords() -> Bool{
        if (newPassword1.text == "")||(newPassword1.text != newPassword2.text){
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
        if checkPasswords() == true{
            if checkOldPassword() == true{
                // change passwords
                
                alert(message: "Changes were succesfully made", title: "Password changed")
            }else{
                alert(message: "Please fill in your correct current password", title: "Password not correct")
            }
        }else{
            alert(message: "Your new passwords don't match", title: "Non-matching passwords")
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Change password"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        if identifier == "changePassword"{
            if checkPasswords() == true{
                if checkOldPassword() == true{
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
