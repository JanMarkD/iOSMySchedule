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
    
    let noClassesToday = ["subject": "No classes.", "Location": " "]
    
    let headerForSection = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
    
    let retriever = scheduleRetriever()
    
    let dateHelper = DateHelp()
    
    let alertHelp = CreateAlert()
    
    let defaults = UserDefaults.standard
    
    var whichWeek = 1
    
    
    //Actions
    
    @IBAction func previousButton(_ sender: UIBarButtonItem) {
        let thisWeek = (self.navigationItem.title?.components(separatedBy: " "))![1]
        
        if Int(thisWeek) == dateHelper.getWeekNumber(date: NSDate()){
            alertHelp.alert(message: "Can't fetch data from past.", title: "No Data")
            return
        }
        if (self.navigationItem.title?.components(separatedBy: " "))![1] == "1" {
            self.navigationItem.title? = "MySchedule 52"
            if whichWeek == 2{
                self.classesPerDay = self.classesPerDayWeek1
                whichWeek = 1
            }else if whichWeek == 3{
                self.classesPerDay = self.classesPerDayWeek2
                whichWeek = 2
            }
        }else{
            let previousWeek = Int(thisWeek)! - 1
            self.navigationItem.title? = "MySchedule "+String(previousWeek)
            if whichWeek == 2{
                self.classesPerDay = self.classesPerDayWeek1
                whichWeek = 1
            }else if whichWeek == 3{
                self.classesPerDay = self.classesPerDayWeek2
                whichWeek = 2
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        let thisWeek = (self.navigationItem.title?.components(separatedBy: " "))![1]
        if Int(thisWeek) == dateHelper.getWeekNumber(date: NSDate()) + 2{
            alertHelp.alert(message: "Can't fetch data in more than three weeks in advance.", title: "No Data")
            return
        }
        if (self.navigationItem.title?.components(separatedBy: " "))![1] == "52" {
            self.navigationItem.title? = "MySchedule 1"
            if whichWeek == 1{
                self.classesPerDay = self.classesPerDayWeek2
                whichWeek = 2
            }else if whichWeek == 2{
                self.classesPerDay = self.classesPerDayWeek3
                whichWeek = 3
            }
        }else{
            let nextWeek = Int(thisWeek)!+1
            self.navigationItem.title? = "MySchedule "+String(nextWeek)
            if whichWeek == 1{
                self.classesPerDay = self.classesPerDayWeek2
                whichWeek = 2
            }else if whichWeek == 2{
                self.classesPerDay = self.classesPerDayWeek3
                whichWeek = 3
            }
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
        self.navigationItem.title = "MySchedule " + String(weeknumber)
        
        let startTime = dateHelper.getStartOfCurrentWeek()
        let endTime = startTime + 3*7*24*3600
        
        let studentCode = defaults.value(forKey: "Student code") as! String
        
        retriever.getAllData(studentCode: studentCode, startTime: String(startTime), endTime: String(endTime), completion: {(schedule, error) in
            for x in 0..<schedule.count{
                let lesson = schedule[x]
                if lesson["change"] == "" && lesson["changeDescription"] != ""{
                    continue
                }
                let week = lesson["weekNumber"]
                if Int(week!) == self.dateHelper.getWeekNumber(date: NSDate()){
                    let day = lesson["day"]
                    if day == "2"{
                        self.classesPerDayWeek1[0].append(lesson)
                    }else if day == "3"{
                        self.classesPerDayWeek1[1].append(lesson)
                    }else if day == "4"{
                        self.classesPerDayWeek1[2].append(lesson)
                    }else if day == "5"{
                        self.classesPerDayWeek1[3].append(lesson)
                    }else if day == "6"{
                        self.classesPerDayWeek1[4].append(lesson)
                    }
                }
                if Int(week!) == self.dateHelper.getWeekNumber(date: NSDate())+1{
                    let day = lesson["day"]
                    if day == "2"{
                        self.classesPerDayWeek2[0].append(lesson)
                    }else if day == "3"{
                        self.classesPerDayWeek2[1].append(lesson)
                    }else if day == "4"{
                        self.classesPerDayWeek2[2].append(lesson)
                    }else if day == "5"{
                        self.classesPerDayWeek2[3].append(lesson)
                    }else if day == "6"{
                        self.classesPerDayWeek2[4].append(lesson)
                    }
                }
                if Int(week!) == self.dateHelper.getWeekNumber(date: NSDate())+2{
                    let day = lesson["day"]
                    if day == "2"{
                        self.classesPerDayWeek3[0].append(lesson)
                    }else if day == "3"{
                        self.classesPerDayWeek3[1].append(lesson)
                    }else if day == "4"{
                        self.classesPerDayWeek3[2].append(lesson)
                    }else if day == "5"{
                        self.classesPerDayWeek3[3].append(lesson)
                    }else if day == "6"{
                        self.classesPerDayWeek3[4].append(lesson)
                    }
                }
                self.classesPerDayWeek1[0].sort {$0["date"]! < $1["date"]!}
                self.classesPerDayWeek1[1].sort {$0["date"]! < $1["date"]!}
                self.classesPerDayWeek1[2].sort {$0["date"]! < $1["date"]!}
                self.classesPerDayWeek1[3].sort {$0["date"]! < $1["date"]!}
                self.classesPerDayWeek1[4].sort {$0["date"]! < $1["date"]!}
                
                self.classesPerDayWeek2[0].sort {$0["date"]! < $1["date"]!}
                self.classesPerDayWeek2[1].sort {$0["date"]! < $1["date"]!}
                self.classesPerDayWeek2[2].sort {$0["date"]! < $1["date"]!}
                self.classesPerDayWeek2[3].sort {$0["date"]! < $1["date"]!}
                self.classesPerDayWeek2[4].sort {$0["date"]! < $1["date"]!}
                
                self.classesPerDayWeek3[0].sort {$0["date"]! < $1["date"]!}
                self.classesPerDayWeek3[1].sort {$0["date"]! < $1["date"]!}
                self.classesPerDayWeek3[2].sort {$0["date"]! < $1["date"]!}
                self.classesPerDayWeek3[3].sort {$0["date"]! < $1["date"]!}
                self.classesPerDayWeek3[4].sort {$0["date"]! < $1["date"]!}
            }
            DispatchQueue.main.async {
                self.classesPerDay = self.classesPerDayWeek1
                self.tableView.reloadData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        if currentCell?.textLabel?.text != "No classes."{
            performSegue(withIdentifier: "classTapped", sender: self)
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return classesPerDay.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if classesPerDay[section].count == 0{
            return 1
        }else{
            return classesPerDay[section].count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerForSection[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        if classesPerDay[indexPath.section].count == 0{
            cell.textLabel?.text = noClassesToday["subject"]
            cell.detailTextLabel?.text = noClassesToday["location"]
        }else{
            let one = #imageLiteral(resourceName: "1hour")
            let two = #imageLiteral(resourceName: "2hour")
            let three = #imageLiteral(resourceName: "3hour")
            let four = #imageLiteral(resourceName: "4hour")
            let five = #imageLiteral(resourceName: "5hour")
            let six = #imageLiteral(resourceName: "6hour")
            let seven = #imageLiteral(resourceName: "7hour")
            let eight = #imageLiteral(resourceName: "8hour")
            let cancelled = #imageLiteral(resourceName: "cancelledFilled")
            let modified = #imageLiteral(resourceName: "modifiedClassFilled")
            
            if let favouriteSubjects = defaults.value(forKey: "Favourite Subjects") as? [String]{
                for i in 0..<favouriteSubjects.count{
                    let subject = favouriteSubjects[i]
                    if classesPerDay[indexPath.section][indexPath.row]["subject"] == subject{
                        switch(i){
                        case 0: cell.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                        case 1: cell.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                        case 2: cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                        default: cell.textLabel?.textColor = UIColor.black
                        }
                    }
                }
            }
            cell.textLabel?.text = classesPerDay[indexPath.section][indexPath.row]["subject"]
            cell.detailTextLabel?.text = classesPerDay[indexPath.section][indexPath.row]["location"]
            switch(Int(classesPerDay[indexPath.section][indexPath.row]["hour"]!)){
            case 1?: cell.imageView?.image = one
            case 2?: cell.imageView?.image = two
            case 3?: cell.imageView?.image = three
            case 4?: cell.imageView?.image = four
            case 5?: cell.imageView?.image = five
            case 6?: cell.imageView?.image = six
            case 7?: cell.imageView?.image = seven
            case 8?: cell.imageView?.image = eight
            default: print("")
            }
            switch(classesPerDay[indexPath.section][indexPath.row]["change"]){
            case "new"?, "modified"?, "moved"?: cell.accessoryView = UIImageView(image: modified)
            case "cancelled"?: cell.accessoryView = UIImageView(image: cancelled); cell.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            default: print("")
            }
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow!
        
        if (segue.identifier == "classTapped"){
            let viewController = segue.destination as! ClassTableViewController
            if Int((self.navigationItem.title?.components(separatedBy: " "))![1]) == dateHelper.getWeekNumber(date: NSDate()){
                viewController.classData = classesPerDayWeek1[indexPath.section][indexPath.row]
            }else if Int((self.navigationItem.title?.components(separatedBy: " "))![1]) == dateHelper.getWeekNumber(date: NSDate()) + 1{
                viewController.classData = classesPerDayWeek2[indexPath.section][indexPath.row]
            }else if Int((self.navigationItem.title?.components(separatedBy: " "))![1]) == dateHelper.getWeekNumber(date: NSDate()) + 2{
                viewController.classData = classesPerDayWeek3[indexPath.section][indexPath.row]
            }
        }
    }
}



