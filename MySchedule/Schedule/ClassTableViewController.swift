//
//  ClassTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 27/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class ClassTableViewController: UITableViewController {
    
    var classData = Dictionary<String, String>()
    
    let numberOfRowsInSection = [4,1,2]
    
    //Outlets
    
    @IBOutlet weak var subject: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var teacher: UILabel!
    
    @IBOutlet weak var hour: UILabel!
    
    
    @IBOutlet weak var remark: UILabel!
    
    
    
    @IBOutlet weak var change: UILabel!
    
    @IBOutlet weak var descriptionChange: UILabel!
    
    
    //Functions
    
    
    
    
    //Actions
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let subjectString = classData["subject"]{
            subject.text = subjectString
        }
        
        if let locationString = classData["location"]{
            location.text = locationString
        }
        
        if let teacherString = classData["teacher"]{
            teacher.text = teacherString
        }
        
        if let hourString = classData["hour"]{
            hour.text = hourString
        }
        
        if let remarkString = classData["remark"]{
            remark.text = remarkString
        }
        
        if let descriptionString = classData["changeDescription"]{
            descriptionChange.text = descriptionString
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfRowsInSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberOfRowsInSection[section]
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
