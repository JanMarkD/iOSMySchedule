//
//  HomeViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 08/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//
import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    var mySchedule = Array<Dictionary<String,String>>()
    
    var classesPerDayWeek1 = [[[String:String]](),[[String:String]](),[[String:String]](),[[String:String]](),[[String:String]]()]
    
    let retriever = scheduleRetriever()
    
    let dateHelper = DateHelp()
    
    let defaults = UserDefaults.standard
    
    
    //Outlets
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var welcomeUser: UILabel!
    @IBOutlet weak var classRightNow: UILabel!
    @IBOutlet weak var classNext: UILabel!
    
    
    //Functions
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startTime = dateHelper.getStartOfCurrentWeek()
        let endTime = startTime + 3*7*24*3600
        let studentCode = defaults.value(forKey: "Student code") as! String
        
        if Reachability.isConnectedToNetwork(){
            retriever.getAllData(studentCode: studentCode, startTime: String(startTime), endTime: String(endTime))
        }
        
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        
        do {
            let lessons = try CoreData.context.fetch(fetchRequest)
            
            for i in 0..<lessons.count{
                
                let weekNumber = lessons[i].weekNumber
                let dayNumber = lessons[i].dayNumber
                let hour = lessons[i].hour
                let currentWeek = String(dateHelper.getWeekNumber(date: NSDate()))
                let currentDay = String(dateHelper.getDayOfWeek(date: NSDate()))
                let currentHour = dateHelper.timeToHour(date: Date())
                let nextHour = currentHour + 1
                
                print(weekNumber)
                print(currentWeek)
                
                if weekNumber == currentWeek && dayNumber == currentDay && String(currentHour) == hour{
                    let currentLocation = lessons[i].location
                    let currentSubject = lessons[i].subject
                    classRightNow.text = "You have " + currentSubject! + ", in " + currentLocation!
                }
                if weekNumber == currentWeek && dayNumber == currentDay && String(nextHour) == hour{
                    let nextLocation = lessons[i].location
                    let nextSubject = lessons[i].subject
                    classNext.text = "Your next lesson is " + nextSubject! + ", in " + nextLocation!
                }
            }
            
        } catch {}
        
        if let loginSet = defaults.value(forKey: "Login") as? [String]{
            welcomeUser.text = "Welcome, " + loginSet[0] + "!"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
