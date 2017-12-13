//
//  ProfileTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 06/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

// TODO: Design tableviewcells and text colors.

class ProfileTableViewController: UITableViewController {
    
    
    //Properties
    
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
    
    
    //Actions
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background of tableview, no selection and cell height.
        
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
            subject1.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.8)
            subject2.text = favouriteSubjects[1]
            subject2.textColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 0.8)
            subject3.text = favouriteSubjects[2]
            subject3.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.8)
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
