//
//  ScheduleTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 27/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit
import CoreData

// TODO: Images of each cell colors etc.

class ScheduleTableViewController: UITableViewController {
    
    
    //Properties
    
    var lessonsThisWeek = [[Lesson](),[Lesson](),[Lesson](),[Lesson](),[Lesson]()]
    
    var lessonsWeek1 = [[Lesson](),[Lesson](),[Lesson](),[Lesson](),[Lesson]()]
    
    var lessonsWeek2 = [[Lesson](),[Lesson](),[Lesson](),[Lesson](),[Lesson]()]
    
    var lessonsWeek3 = [[Lesson](),[Lesson](),[Lesson](),[Lesson](),[Lesson]()]
    
    let noClassesToday = ["subject": "No classes", "Location": " "]
    
    let headerForSection = ["Monday","Tuesday","Wednesday","Thursday","Friday"]
    
    let retriever = scheduleRetriever()
    
    let dateHelper = DateHelp()
    
    let alertHelp = CreateAlert()
    
    let defaults = UserDefaults.standard
    
    var whichWeek = 1
    
    
    //Actions
    
    //Goes one week back, and refreshes data.
    
    @IBAction func previousButton(_ sender: UIBarButtonItem) {
        let thisWeek = (self.navigationItem.title?.components(separatedBy: " "))![1]
        
        //If week is current week, we don't have data of the past.
        
        if Int(thisWeek) == dateHelper.getWeekNumber(date: NSDate()){
            alertHelp.alert(message: "Can't load data from the past.", title: "No Data")
            return
        }
        
        //If week is 1, you don't want to go to week 0.
        
        if (self.navigationItem.title?.components(separatedBy: " "))![1] == "1" {
            self.navigationItem.title? = "Week 52"
            if whichWeek == 2{
                self.lessonsThisWeek = self.lessonsWeek1
                whichWeek = 1
            }else if whichWeek == 3{
                self.lessonsThisWeek = self.lessonsWeek2
                whichWeek = 2
            }
        }else{
            let previousWeek = Int(thisWeek)! - 1
            self.navigationItem.title? = "Week "+String(previousWeek)
            if whichWeek == 2{
                self.lessonsThisWeek = self.lessonsWeek1
                whichWeek = 1
            }else if whichWeek == 3{
                self.lessonsThisWeek = self.lessonsWeek2
                whichWeek = 2
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    //Goes to next week, and refreshes data.
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        let thisWeek = (self.navigationItem.title?.components(separatedBy: " "))![1]
        
        //If week is 3 weeks ahead, we don't have data of that far.
        
        if Int(thisWeek) == dateHelper.getWeekNumber(date: NSDate()) + 2{
            alertHelp.alert(message: "Can't load data from more than three weeks in advance.", title: "No Data")
            return
        }
        
        //If week is 52, you don't want to go to week 53.
        
        if (self.navigationItem.title?.components(separatedBy: " "))![1] == "52" {
            self.navigationItem.title? = "Week 1"
            if whichWeek == 1{
                self.lessonsThisWeek = self.lessonsWeek2
                whichWeek = 2
            }else if whichWeek == 2{
                self.lessonsThisWeek = self.lessonsWeek3
                whichWeek = 3
            }
        }else{
            let nextWeek = Int(thisWeek)!+1
            self.navigationItem.title? = "Week "+String(nextWeek)
            if whichWeek == 1{
                self.lessonsThisWeek = self.lessonsWeek2
                whichWeek = 2
            }else if whichWeek == 2{
                self.lessonsThisWeek = self.lessonsWeek3
                whichWeek = 3
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background and weeknumber label text.
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "Background home"))
        
        let weeknumber = dateHelper.getWeekNumber(date: NSDate())
        self.navigationItem.title = "Week " + String(weeknumber)
    }
    
    //Every time the view appears the saved lessons are retrieved and sorted by weeknumber and classhour. The tableview is refreshed.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        lessonsThisWeek = [[Lesson](),[Lesson](),[Lesson](),[Lesson](),[Lesson]()]
        
        lessonsWeek1 = [[Lesson](),[Lesson](),[Lesson](),[Lesson](),[Lesson]()]
        
        lessonsWeek2 = [[Lesson](),[Lesson](),[Lesson](),[Lesson](),[Lesson]()]
        
        lessonsWeek3 = [[Lesson](),[Lesson](),[Lesson](),[Lesson](),[Lesson]()]
        
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        
        do {
            let lessons = try CoreData.context.fetch(fetchRequest)
            
            for i in 0..<lessons.count{
                let lesson = lessons[i]
                
                if lesson.change == "" && lesson.changeDescription != ""{
                    continue
                }
                
                let weekNumber = dateHelper.getWeekNumber(date: NSDate())
                
                //Assigning lesson to correct list by weeknumber.
                
                if lesson.weekNumber == String(weekNumber){
                    lessonsWeek1[Int(lesson.dayNumber!)! - 2].append(lesson)
                }else if lesson.weekNumber == String(weekNumber + 1){
                    lessonsWeek2[Int(lesson.dayNumber!)! - 2].append(lesson)
                }else if lesson.weekNumber == String(weekNumber + 2){
                    lessonsWeek3[Int(lesson.dayNumber!)! - 2].append(lesson)
                }
            }
            
            //Sorting lessons by classhour.
            
            for i in 0..<lessonsWeek1.count{
                lessonsWeek1[i].sort { $0.hour! < $1.hour! }
            }
            for i in 0..<lessonsWeek3.count{
                lessonsWeek2[i].sort { $0.hour! < $1.hour! }
            }
            for i in 0..<lessonsWeek3.count{
                lessonsWeek3[i].sort { $0.hour! < $1.hour! }
            }
            
            DispatchQueue.main.async {
                let index = (Int((self.navigationItem.title?.components(separatedBy: " ")[1])!))! - self.dateHelper.getWeekNumber(date: NSDate())
                switch(index){
                case 0: self.lessonsThisWeek = self.lessonsWeek1
                case 1: self.lessonsThisWeek = self.lessonsWeek2
                case 2: self.lessonsThisWeek = self.lessonsWeek3
                default: self.lessonsThisWeek = self.lessonsWeek1
                }
                self.tableView.reloadData()
            }
            
        } catch {}
    }
    
    //Checks if selected cell is a class (and not a "No Classes" cell), if true, performs segue.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        if currentCell?.textLabel?.text != "No classes"{
            performSegue(withIdentifier: "classTapped", sender: self)
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
        
        }
    }
    
    //Set up sections and rows of tableview.

    override func numberOfSections(in tableView: UITableView) -> Int {
        return lessonsThisWeek.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lessonsThisWeek[section].count == 0{
            return 1
        }else{
            return lessonsThisWeek[section].count
        }
    }
    
    //Set up tableviewcells.

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5536036532)
        
        //Checks if there are classes at every section, if not gives back a "No Classes" cell.
        
        if lessonsThisWeek[indexPath.section].count == 0{
            cell.textLabel?.text = noClassesToday["subject"]
            cell.detailTextLabel?.text = noClassesToday["location"]
        }else{
            let lesson = lessonsThisWeek[indexPath.section][indexPath.row]
            
            //If the lesson is one of the users favourite, it gets a color.
            
            if let favouriteSubjects = defaults.value(forKey: "Favourite Subjects") as? [String]{
                for i in 0..<favouriteSubjects.count{
                    let subject = favouriteSubjects[i]
                    if lesson.subject == subject{
                        switch(i){
                        case 0: cell.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.8)
                        case 1: cell.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 0.8)
                        case 2: cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 0.8)
                        default: cell.textLabel?.textColor = UIColor.black
                        }
                    }
                }
            }
            
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
            
            //Assigns text to TextLabel and DetailTextLabel of cell and adds an number image according to the classhour.
            
            cell.textLabel?.text = lesson.subject
            cell.detailTextLabel?.text = lesson.location
            switch(Int(lesson.hour!)){
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
            
            //If the lesson has a change a corresponding image is added at the right corner of the cell.
            
            switch(lesson.change){
            case "new"?, "modified"?, "moved"?: cell.accessoryView = UIImageView(image: modified)
            case "cancelled"?: cell.accessoryView = UIImageView(image: cancelled); cell.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0.8)
            default: print("")
            }
        }
        
        //TextLabels get a color and cell is returned.
        
        cell.textLabel?.textColor = #colorLiteral(red: 0.327558428, green: 0.4575711489, blue: 0.6982613206, alpha: 1)
        cell.detailTextLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return cell
    }
    
    //Passes selected lesson data to next viewcontroller.

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow!
        if (segue.identifier == "classTapped"){
            let viewController = segue.destination as! ClassTableViewController
            viewController.classData = lessonsThisWeek[indexPath.section][indexPath.row]
        }
    }
    
    //Configure headers
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = UIColor.white
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerForSection[section]
    }
}



