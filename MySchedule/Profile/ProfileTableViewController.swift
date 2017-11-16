//
//  ProfileTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 06/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    //Setup Data
    
    let numberOfRows = [5,3]
    
    let alertHelp = CreateAlert()
    
    let defaults = UserDefaults.standard
    
    
    //Outlets
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var emailAdress: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var studentCode: UILabel!
    
    @IBOutlet weak var subject1: UILabel!
    @IBOutlet weak var subject2: UILabel!
    @IBOutlet weak var subject3: UILabel!
    
    
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

    
    //Actions
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
            subject1.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            subject2.text = favouriteSubjects[1]
            subject2.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            subject3.text = favouriteSubjects[2]
            subject3.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
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
}
