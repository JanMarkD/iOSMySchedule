//
//  HomeViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 08/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//
import UIKit
import CoreData

// TODO: Darker Navigation bar and transparanter tabbar, next lesson label must be bigger to fit text.

class HomeViewController: UIViewController {
    
    
    //Properties
    
    let retriever = scheduleRetriever()
    
    let dateHelper = DateHelp()
    
    let defaults = UserDefaults.standard
    
    
    //Outlets
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var welcomeUser: UILabel!
    
    @IBOutlet weak var classRightNow: UILabel!
    
    @IBOutlet weak var classNext: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gets data needed for HTTP request, checks if device is connected, if true performs request.
        
        let startTime = dateHelper.getStartOfCurrentWeek()
        let endTime = startTime + 3*7*24*3600
        let studentCode = defaults.value(forKey: "Student code") as! String
        
        if Reachability.isConnectedToNetwork(){
            retriever.getAllData(studentCode: studentCode, startTime: String(startTime), endTime: String(endTime))
        }
        
        //Set text of "Welcome" label.
        
        if let loginSet = defaults.value(forKey: "Login") as? [String]{
            welcomeUser.text = "Welcome, " + loginSet[0] + "!"
        }
    }
    
    //Every time the view appears its labels will be updated.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Gets saved Lessons and goes through them to check if one is right now and/or next up, in order to set text of labels.
        
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        
        do {
            let lessons = try CoreData.context.fetch(fetchRequest)
            
            for i in 0..<lessons.count{
                
                if lessons[i].change == "cancelled"{
                    continue
                }
                
                let weekNumber = lessons[i].weekNumber
                let dayNumber = lessons[i].dayNumber
                let hour = lessons[i].hour
                let currentWeek = String(dateHelper.getWeekNumber(date: NSDate()))
                let currentDay = String(dateHelper.getDayOfWeek(date: NSDate()))
                let currentHour = dateHelper.timeToHour(date: Date())
                let nextHour = currentHour + 1
                
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
    }
}
