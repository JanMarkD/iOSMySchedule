//
//  ChangePasswordTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 06/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class ChangePasswordTableViewController: UITableViewController {
    
    //Setup Data
    
    let numberOfRows = [3,1]
    
    let alertHelp = CreateAlert()
    
    
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
    
    @objc func changePasswords(){
        
        //changepassword
        
        performSegue(withIdentifier: "changePassword", sender: self)
    }
    
    
    //Actions
    
    @IBAction func changePassword(_ sender: UIButton) {
        if checkPasswords() == true{
            if checkOldPassword() == true{
                changePasswords()
                alertHelp.alert(message: "Changes were succesfully made", title: "Password changed")
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
