//
//  ChangeProfileTableViewController.swift
//  MySchedule
//
//  Created by Jan-Hermen Dannenberg on 15/11/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class ChangeProfileTableViewController: UITableViewController {
    
    //Setup Data
    
    let numberOfRowsInSection = [6,3]
    
    let alertHelp = CreateAlert()
    
    let defaults = UserDefaults.standard
    
    
    //Outlets
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAdress: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var studentCode: UILabel!
    
    
    @IBOutlet weak var subject1: UITextField!
    @IBOutlet weak var subject2: UITextField!
    @IBOutlet weak var subject3: UITextField!
    
    
    //Functions
    
    @objc func changeProfile(){
        let check = checkFields()
        print(check)
        if check == false{
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
    
    
    //Actions
    
    @IBAction func unwindToChangeProfile(segue: UIStoryboardSegue) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Change Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.done, target:self, action: #selector(changeProfile))
        self.tableView.allowsSelection = false
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "Background home"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        super.viewWillAppear(true)
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


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
