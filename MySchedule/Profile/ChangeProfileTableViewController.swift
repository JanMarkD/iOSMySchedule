//
//  ChangeProfileTableViewController.swift
//  MySchedule
//
//  Created by Jan-Hermen Dannenberg on 15/11/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

// TODO: Design tableviewcells and text colors, separator.
struct cellData {
    
    let cell : Int!
}

class ChangeProfileTableViewController: UITableViewController {
    
    //Properties
    
    let numberOfRowsInSection = [5,1,1,3]
    
    let alertHelp = CreateAlert()
    
    let defaults = UserDefaults.standard
    
    
    //Outlets
    
    @IBOutlet var allTextFields: [UITextField]!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var emailAdress: UITextField!
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var studentCode: UILabel!
    
    @IBOutlet weak var subject1: UITextField!
    
    @IBOutlet weak var subject2: UITextField!
    
    @IBOutlet weak var subject3: UITextField!
    
    @IBOutlet weak var autoFillLogin: UISwitch!
    
    
    //Functions
    
    //Check if neccesary fields are all filled in.
    
    func checkFields() -> Bool{
        for textField in allTextFields{
            if textField.text == ""{
                return false
            }
        }
        return true
    }
    
    //Function that is selector for save button in navigation bar, checks fields and saves data. Performs unwind segue to profile tab.
    
    @objc func changeProfile(){
        if checkFields() == false{
            alertHelp.alert(message: "Please fill in all fields", title: "Empty Fields")
        }else{
            let firstname = firstName.text!
            let lastname = lastName.text!
            let emailadress = emailAdress.text!
            let username = userName.text!
            let studentcode = studentCode.text!
            
            var favouriteSubjects = [String]()
            if subject1.text != nil || subject1.text == ""{
                favouriteSubjects.append(subject1.text!)
            }
            if subject2.text != nil || subject2.text == ""{
                favouriteSubjects.append(subject2.text!)
            }
            if subject3.text != nil || subject3.text == ""{
                favouriteSubjects.append(subject3.text!)
            }
            
            let login = defaults.value(forKey: "Login") as! [String]
            let loginSet = [username, login[1]]
            
            defaults.set([firstname, lastname], forKey: "Name")
            defaults.set(emailadress,forKey: "Emailadress")
            defaults.set(loginSet,forKey: "Login")
            defaults.set(studentcode, forKey: "Student code")
            defaults.set(favouriteSubjects, forKey: "Favourite Subjects")
            
            performSegue(withIdentifier: "saveChanges", sender: self)
            
            alertHelp.alert(message: "", title: "Changes were made succesful")
        }
    }

    
    //Actions
    
    @IBAction func unwindToChangeProfile(segue: UIStoryboardSegue) {}
    
    //Saves new value of Autofill Login to UserDefaults.
    
    @IBAction func autoFillLoginChanged(_ sender: UISwitch) {
        let autofilllogin = autoFillLogin.isOn
        defaults.set(autofilllogin, forKey: "Autofill Login")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up navigation bar buttons and title. Background of tableview, no selection and cell height.
        
        self.navigationItem.title = "Change Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.done, target:self, action: #selector(changeProfile))
        
        self.tableView.allowsSelection = false
        
        tableView.rowHeight = 46
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "Background home"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Get all user data and set text of labels.
        
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
        if let favouriteSubjects = defaults.value(forKey: "Favourite Subjects") as? [String]{
            subject1.text = favouriteSubjects[0]
            subject2.text = favouriteSubjects[1]
            subject3.text = favouriteSubjects[2]
        }
        
        //Get current state of Autofill Login and set switch.
        
        if let autofilllogin = defaults.value(forKey: "Autofill Login") as? Bool{
            autoFillLogin.isOn = autofilllogin
        }
    }

    //Set up tableview sections, rows, headers and footers.

    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfRowsInSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection[section]
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
