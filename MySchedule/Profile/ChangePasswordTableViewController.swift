//
//  ChangePasswordTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 06/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit
import MessageUI

// TODO: Design tableviewcells and text colors.

class ChangePasswordTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    
    //Properties
    
    let numberOfRows = [3]
    
    let alertHelp = CreateAlert()
    
    let defaults = UserDefaults.standard
    
    
    //Outlets
    
    @IBOutlet weak var oldPassword: UITextField!
    
    @IBOutlet weak var newPassword1: UITextField!
    
    @IBOutlet weak var newPassword2: UITextField!
    
    
    //Functions
    
    //Checks if old passwords matches with filled in password.
    
    func checkOldPassword() -> Bool{
        let passwordx = defaults.value(forKey: "Login") as! [String]
        if oldPassword.text == passwordx[1]{
            return true
        }else{
            return false
        }
    }
    
    //Checks if the two new passwords match.
    
    func checkPasswords() -> Bool{
        if (newPassword1.text == "")||(newPassword1.text != newPassword2.text){
            return false
        }else{
            return true
        }
    }
    
    //Calls and creates a MFMailComposeViewController and presents it to the user.
    
    func sendEmail(sender: UIViewController) {
        let mailComposeViewController = mailNewPassWord()
        if MFMailComposeViewController.canSendMail() {
            sender.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            alertHelp.alert(message: "Something went wrong, try again later.", title: "Error")
        }
    }
    
    //Creates a MFMailComposeViewController and sets message,subject and recipients.
    
    func mailNewPassWord() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        
        let name = defaults.value(forKey: "Name") as! [String]
        
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([(defaults.value(forKey: "Emailadress") as! String)])
        mailComposerVC.setSubject("New Password")
        mailComposerVC.setMessageBody("Dear " + name[0] + " " +  name[1] + ",\n\n" + "Recently you changed your password, your new password is now:\n\n" + newPassword1.text! + "\n\n" + "Greetings,\n\nMySchedule" , isHTML: false)
        return mailComposerVC
    }
    
    //Dismisses MFMailComposeViewController after message is send, or cancelled.
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "changePassword", sender: self)
    }
    
    //Selector that is activated by "Save" button in navigation controller, saves password and calles sendEmail().
    
    @objc func changePasswords(){
        if checkPasswords(){
            if checkOldPassword(){
                let username = (defaults.value(forKey: "Login") as! [String])[0]
                let newLogin = [username, newPassword1.text!]
                defaults.set(newLogin, forKey: "Login")
                sendEmail(sender: self)
            }else{
                alertHelp.alert(message: "Please fill in your correct current password", title: "Password not correct")
            }
        }else{
            alertHelp.alert(message: "Your new passwords don't match", title: "Non-matching passwords")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up navigation bar button and title. Background of tableview, no selection and cell height.
        
        self.navigationItem.title = "Change password"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.done, target:self, action: #selector(changePasswords))
        
        self.tableView.allowsSelection = false
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "Background home"))
    }
    
    //If all filled in data is correct performs unwind segue to ChangeProfile.
    
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
    
    //Set up tableview sections, rows, headers and footers.
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfRows.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = UIColor.white
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = UIColor.white
        }
    }
}
