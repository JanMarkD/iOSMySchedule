//
//  HomeViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 08/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//
import UIKit


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
    
    func refreshData(){
        let startTime = dateHelper.getStartOfCurrentWeek()
        let endTime = startTime + 3*7*24*3600
        let studentCode = defaults.value(forKey: "Student code") as! String
        
        retriever.getAllData(studentCode: studentCode, startTime: String(startTime), endTime: String(endTime), completion: {(schedule, error) in
            for x in 0..<schedule.count{
                let lesson = schedule[x]
                let week = lesson["weekNumber"]
                if Int(week!) == self.dateHelper.getWeekNumber(date: NSDate()){
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
            }
        })
        let currentHour = dateHelper.timeToHour(date: Date())
        let dayNumber = dateHelper.getDayOfWeek(date: NSDate())
        if dayNumber != 0 && dayNumber != 1 {
            let currentDay = classesPerDayWeek1[dayNumber-2]
            for i in 0..<currentDay.count{
                let lesson = currentDay[i]
                if Int(lesson["hour"]!)! == currentHour{
                    let currentLocation = lesson["location"]
                    let currentSubject = lesson["subject"]
                    classRightNow.text = "You have " + currentSubject! + ", in " + currentLocation!
                }else if Int(lesson["hour"]!)! == currentHour + 1{
                    let nextLocation = lesson["location"]
                    let nextSubject = lesson["subject"]
                    classNext.text = "Your next lesson is " + nextSubject! + ", in " + nextLocation!
                }
            }
        }else{
            classNext.text = "No upcoming classes today."
            classRightNow.text = "You don't have a lesson right now."
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loginSet = defaults.value(forKey: "Login") as? [String]{
            welcomeUser.text = "Welcome, " + loginSet[0] + "!"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refreshData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
