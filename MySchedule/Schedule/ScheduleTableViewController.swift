//
//  ScheduleTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 27/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {
    
    var mySchedule = Array<Dictionary<String,String>>()
    
    var classesPerDay = [[[String:String]](),[[String:String]](),[[String:String]](),[[String:String]](),[[String:String]]()]

    var classesPerDayWeek1 = [[[String:String]](),[[String:String]](),[[String:String]](),[[String:String]](),[[String:String]]()]
    
    var classesPerDayWeek2 = [[[String:String]](),[[String:String]](),[[String:String]](),[[String:String]](),[[String:String]]()]
    
    var classesPerDayWeek3 = [[[String:String]](),[[String:String]](),[[String:String]](),[[String:String]](),[[String:String]]()]
    
    let headerForSection = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
    
    
    
    let retriever = scheduleRetriever()
    
    let dateHelper = DateHelp()
    
    let createAlert = CreateAlert()
    
    //Outlets
    
    @IBOutlet weak var weekNumber: UILabel!
    

    
    
    
    
    //Functions

    
    
    
    //Actions
    
    @IBAction func nextWeek(_ sender: UIButton) {
        let nextWeek = Int(weekNumber.text!)!
        
        if nextWeek == dateHelper.getWeekNumber(date: NSDate()) + 2{
            return
        }
        if weekNumber.text == "52" {
            weekNumber.text = "1"
        }else{
            weekNumber.text = String(nextWeek+1)
            self.classesPerDay = self.classesPerDayWeek2
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func previousWeek(_ sender: UIButton) {
        let previousWeek = Int(weekNumber.text!)!
        
        if previousWeek == dateHelper.getWeekNumber(date: NSDate()){
            return
        }
        
        if weekNumber.text == "1"{
            weekNumber.text = "52"
        }else{
            weekNumber.text = String(previousWeek-1)
            self.classesPerDay = self.classesPerDayWeek1
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let weeknumber = dateHelper.getWeekNumber(date: NSDate())
        weekNumber.text = String(weeknumber)
        
        let startTime = dateHelper.getStartOfCurrentWeek()
        let endTime = startTime + 3*7*24*3600
        
        retriever.getAllData(studentCode: "163250", startTime: String(startTime), endTime: String(endTime), completion: {(schedule, error) in
            for x in 0..<schedule.count{
                let lesson = schedule[x]
                let week = lesson["weekNumber"]
                if Int(week!) == self.dateHelper.getWeekNumber(date: NSDate())+1{
                    let day = lesson["day"]
                    if day == "1"{
                        print("Sunday")
                    }else if day == "2"{
                        self.classesPerDayWeek1[0].append(lesson)
                    }else if day == "3"{
                        self.classesPerDayWeek1[1].append(lesson)
                    }else if day == "4"{
                        self.classesPerDayWeek1[2].append(lesson)
                    }else if day == "5"{
                        self.classesPerDayWeek1[3].append(lesson)
                    }else if day == "6"{
                        self.classesPerDayWeek1[4].append(lesson)
                    }else if day == "7"{
                        print("Saturday")
                    }
                }
                if Int(week!) == self.dateHelper.getWeekNumber(date: NSDate())+2{
                    let day = lesson["day"]
                    if day == "1"{
                        print("Sunday")
                    }else if day == "2"{
                        self.classesPerDayWeek2[0].append(lesson)
                    }else if day == "3"{
                        self.classesPerDayWeek2[1].append(lesson)
                    }else if day == "4"{
                        self.classesPerDayWeek2[2].append(lesson)
                    }else if day == "5"{
                        self.classesPerDayWeek2[3].append(lesson)
                    }else if day == "6"{
                        self.classesPerDayWeek2[4].append(lesson)
                    }else if day == "7"{
                        print("Saturday")
                    }
                }
                if Int(week!) == self.dateHelper.getWeekNumber(date: NSDate())+3{
                    let day = lesson["day"]
                    if day == "1"{
                        print("Sunday")
                    }else if day == "2"{
                        self.classesPerDayWeek3[0].append(lesson)
                    }else if day == "3"{
                        self.classesPerDayWeek3[1].append(lesson)
                    }else if day == "4"{
                        self.classesPerDayWeek3[2].append(lesson)
                    }else if day == "5"{
                        self.classesPerDayWeek3[3].append(lesson)
                    }else if day == "6"{
                        self.classesPerDayWeek3[4].append(lesson)
                    }else if day == "7"{
                        print("Saturday")
                    }
                }
            }
            DispatchQueue.main.async {
                self.classesPerDay = self.classesPerDayWeek1
                self.tableView.reloadData()
            }
        })
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return classesPerDay.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classesPerDay[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerForSection[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = classesPerDay[indexPath.section][indexPath.row]["subject"]

        return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
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
            let viewController = segue.destination as! ClassTableViewController

        }
    }


}



