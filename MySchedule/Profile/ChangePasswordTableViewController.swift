//
//  ChangePasswordTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 06/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit
import MessageUI

class ChangePasswordTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    //Setup Data
    
    let numberOfRows = [3]
    
    let alertHelp = CreateAlert()
    
    let defaults = UserDefaults.standard
    
    
    //Outlets
    
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword1: UITextField!
    @IBOutlet weak var newPassword2: UITextField!
    
    
    //Functions
    
    func checkOldPassword() -> Bool{
        let defaults = UserDefaults.standard
        let passwordx = defaults.value(forKey: "Login") as! [String]
        if oldPassword.text == passwordx[1]{
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
    
    func sendEmail(sender: UIViewController) {
        let mailComposeViewController = mailNewPassWord()
        if MFMailComposeViewController.canSendMail() {
            sender.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            alertHelp.alert(message: "Something went wrong, try again later.", title: "Error")
        }
    }
    
    func mailNewPassWord() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        
        let name = defaults.value(forKey: "Name") as! [String]
        
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([(defaults.value(forKey: "Emailadress") as! String)])
        mailComposerVC.setSubject("New Password")
        mailComposerVC.setMessageBody("Dear " + name[0] + " " +  name[1] + ",\n\n" + "Recently you changed your password, your new password is now:\n\n" + newPassword1.text! + "\n\n" + "Greetings,\n\nMySchedule" , isHTML: false)
        return mailComposerVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "changePassword", sender: self)
    }
    
    @objc func changePasswords(){
        if checkPasswords() == true{
            if checkOldPassword() == true{
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
        self.navigationItem.title = "Change password"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.done, target:self, action: #selector(changePasswords))
        self.tableView.allowsSelection = false
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "Background home"))
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
