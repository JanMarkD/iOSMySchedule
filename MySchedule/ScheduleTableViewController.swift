//
//  ScheduleTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 27/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {
    
    //Outlets
    
    @IBOutlet weak var weekNumber: UILabel!
    

    
    
    //Layout Data
    
    let headerForSection = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
    
    var valueToPass:String!
    
    
    
    //Functions
    
    func getWeekNumber() -> Int{
        let calendar = Calendar.current
        let weekNumber = calendar.component(.weekOfYear, from: Date.init(timeIntervalSinceNow: 0))
        return weekNumber
    }
    
    func getClassesDay(weekNumberX:Int)->Array<Int>{
        return [1,1,1,1,1]
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
    
    @IBAction func nextWeek(_ sender: UIButton) {
        let nextWeek = Int(weekNumber.text!)!
        
        if nextWeek == getWeekNumber() + 2{
            alert(message: "No data found" , title: "None")
            return
        }
        if weekNumber.text == "52" {
            weekNumber.text = "1"
        }else{
            weekNumber.text = String(nextWeek+1)
        }
    }
    
    
    @IBAction func previousWeek(_ sender: UIButton) {
        let previousWeek = Int(weekNumber.text!)!
        
        if previousWeek == getWeekNumber(){
            alert(message: "No data found" , title: "None")
            return
        }
        
        if weekNumber.text == "1"{
            weekNumber.text = "52"
        }else{
            weekNumber.text = String(previousWeek-1)
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let weeknumber = getWeekNumber()
        weekNumber.text = String(weeknumber)
        
        //lol
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrievingSchedule()->String{
        let domainName = "driestarcollege"
        let code = 671075443203
        let startTime = String(1388990000)
        let endTime = String(1388999999)
        let studentCode = String(163250)
        
        let tokenHTTPS = "https://"+domainName+".zportal.nl/api/v3/oauth/token"
     
        return "OK"
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfRowsInSection = getClassesDay(weekNumberX:1)
        return numberOfRowsInSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = getClassesDay(weekNumberX:1)
        return numberOfRowsInSection[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerForSection[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...

        return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! UITableViewCell
        
        let valueToPass = currentCell.textLabel?.text
        performSegue(withIdentifier: "classTapped", sender: self)
    }
    

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

    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "classTapped"){
            var viewController = segue.destination as! ClassTableViewController
            viewController.classData = valueToPass
        }
    }


}
