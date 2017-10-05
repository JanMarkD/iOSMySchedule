//
//  ScheduleTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 27/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit
import Alamofire

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
    
    
    //Actions
    
    @IBAction func nextWeek(_ sender: UIButton) {
        let nextweek = Int(weekNumber.text!)!
        weekNumber.text = String(nextweek+1)
    }
    
    
    @IBAction func previousWeek(_ sender: UIButton) {
        let previousweek = Int(weekNumber.text!)!
        weekNumber.text = String(previousweek-1)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let weeknumber = getWeekNumber()
        weekNumber.text = String(weeknumber)
        
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
        
        let parameters: Parameters = [
            "grant_type": "authorization_code",
            "code":"671075443203"
        ]
        
        Alamofire.request(tokenHTTPS, method: .post, parameters: parameters).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value as? [String:Any]{
                
                print("JSON: \(json)") // serialized json response
            }
            
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string; gebeurt alleen als de server iets anders terugstuurt dan JSON
                let mySchedule = "Niet gelukt"
                print(mySchedule)
            }
        }
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
