//
//  ScheduleRetriever.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 26/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class scheduleRetriever: NSObject{
    
    
    //Properties
    
    let dateHelper = DateHelp()
    
    let defaults = UserDefaults.standard
    
    
    //Functions
    
    //Convert JSON into a Swift Dictionary or Array.
    
    func convertJSON(data: Data, key: String, index: Int) -> Any{
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any]{
                return object[key]!
            }else if let object = json as? [Any]{
                return object[index]
            }else{
                print("JSON Invalid")
                return "Oops"
            }
        }catch{
            print(error)
            return "Oops"
        }
    }
    
    //Check if value is Null, if true convert to Swift nil.
    
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }

    //Takes deserialized JSON schedule data and turns it into CoreData entities.
    
    func unwrapSchedule(totalSchedule: Array<Dictionary<String, Any>>){
        
        //Get currently saved lessons and deletes them.
        
        let fetchRequest: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        
        do {
            let allLessons = try CoreData.context.fetch(fetchRequest)
            for i in 0..<allLessons.count{
                CoreData.context.delete(allLessons[i])
            }
            
            var monday = [[String:String]]()
            var tuesday = [[String:String]]()
            var wednesday = [[String:String]]()
            var thursday = [[String:String]]()
            var friday = [[String:String]]()
            
            //Accesses each lesson in retrieved schedule data.
            
            for x in 0..<totalSchedule.count{
                
                let lesson = totalSchedule[x]
                
                //Get all information out of the lesson.
                
                let startInSeconds = lesson["start"] as! Int
                let endInSeconds = lesson["end"] as! Int
                let startDate = Date(timeIntervalSince1970: TimeInterval(startInSeconds))
                let endDate = Date(timeIntervalSince1970: TimeInterval(endInSeconds))
                let startTime = dateHelper.minutesAndHoursFromDate(date: startDate)
                let endTime = dateHelper.minutesAndHoursFromDate(date: endDate)
                let startTimeHours = String(describing: startTime["hours"]!)
                var startTimeMinutes = String(describing: startTime["minutes"]!)
                let endTimeHours = String(describing: endTime["hours"]!)
                var endTimeMinutes = String(describing: endTime["minutes"]!)

                if startTimeMinutes.count == 1{
                    startTimeMinutes = "0" + startTimeMinutes
                }
                if endTimeMinutes.count == 1{
                    endTimeMinutes = "0" + endTimeMinutes
                }

                let time = startTimeHours + ":" + startTimeMinutes + "-" + endTimeHours + ":" + endTimeMinutes

                let weekNumber = self.dateHelper.getWeekNumber(date: startDate as NSDate)

                var hour = Int()
                if (nullToNil(value: lesson["endTimeSlot"] as AnyObject) != nil){
                    hour = lesson["endTimeSlot"] as! Int
                }else{
                    hour = self.dateHelper.timeToHour(date: Date(timeIntervalSince1970: TimeInterval(startInSeconds)))
                }

                let teacher = lesson["teachers"] as! NSArray
                let subject = lesson["subjects"] as! NSArray
                let location = lesson["locations"] as! NSArray

                let remark = lesson["remark"] as! String
                let changeDescription = lesson["changeDescription"] as! String

                let modified = lesson["modified"] as! Int
                let moved = lesson["moved"] as! Int
                let cancelled = lesson["cancelled"] as! Int
                let new = lesson["new"] as! Int
                var change = String()
                if new == 1{
                    change = "new"
                }else if moved == 1{
                    change = "moved"
                }else if cancelled == 1{
                    change = "cancelled"
                }else if modified == 1{
                    change = "modified"
                }
                
                if weekNumber == dateHelper.getWeekNumber(date: NSDate()){
                    
                    var lessonWatch = [String:String]()
                    
                    if teacher.count != 0{
                        lessonWatch["teacher"] = (teacher[0] as! String)
                    }
                    if subject.count != 0{
                        lessonWatch["subject"] = (subject[0] as! String)
                    }
                    if location.count != 0{
                        lessonWatch["location"] = (location[0] as! String).uppercased()
                    }
                    
                    lessonWatch["time"] = time
                    lessonWatch["hour"] = String(hour)
                    lessonWatch["changeDescription"] = changeDescription
                    lessonWatch["remark"] = remark
                    lessonWatch["day"] = String(self.dateHelper.getDayOfWeek(date: startDate as NSDate))
                    lessonWatch["change"] = change
                    
                    if lessonWatch.isEmpty == false{
                        switch(lessonWatch["day"]!){
                        case "2": monday.append(lessonWatch)
                        case "3": tuesday.append(lessonWatch)
                        case "4": wednesday.append(lessonWatch)
                        case "5": thursday.append(lessonWatch)
                        case "6": friday.append(lessonWatch)
                        default: print("")
                        }
                    }
                }
                
                //Create new CoreData Lesson and assigns available information to this Lesson.
                
                let myLesson = Lesson(context: CoreData.context)

                myLesson.time = time
                myLesson.date = (String(describing: startDate))
                myLesson.hour = String(hour)
                myLesson.weekNumber = String(weekNumber)
                myLesson.dayNumber = String(self.dateHelper.getDayOfWeek(date: startDate as NSDate))

                if teacher.count != 0{
                    myLesson.teacher = (teacher[0] as! String)
                }
                if subject.count != 0{
                    myLesson.subject = (subject[0] as! String)
                }
                if location.count != 0{
                    myLesson.location = (location[0] as! String).uppercased()
                }

                myLesson.remarks = remark
                myLesson.change = change
                myLesson.changeDescription = changeDescription

                CoreData.saveContext()
            }
            
            monday.sort {$0["hour"]! < $1["hour"]!}
            tuesday.sort {$0["hour"]! < $1["hour"]!}
            wednesday.sort {$0["hour"]! < $1["hour"]!}
            thursday.sort {$0["hour"]! < $1["hour"]!}
            friday.sort {$0["hour"]! < $1["hour"]!}
            
            let classesThisWeek = [monday,tuesday,wednesday,thursday,friday]
            
        } catch {}
    }
    
    func getAllData(studentCode: String, startTime: String, endTime: String, enterDoStuff: @escaping (Bool) -> Void){
    
        //Get information (also from parameters) needed to make HTTP request.
        
        let domainName = defaults.value(forKey: "Domain name") as! String
        
        //Checks if user has a accestoken yet, if not the "else" part retrieves one and does the same thing.
        
        if let accesToken = (defaults.value(forKey: "Accestoken") as? String){
            
            //Create URL needed for HTTP request

            let url = URL(string: "https://"+domainName+".zportal.nl/api/v3/appointments?user="+studentCode+"&start="+startTime+"&end="+endTime+"&access_token="+accesToken)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            //Makes HTTP request
            
            let task = URLSession.shared.dataTask(with: request) { scheduleData, response, error in
                
                //Check for errors
                
                guard let scheduleData = scheduleData, error == nil else {
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                //Data sended back is processed in unwrapSchedule function.
                
                let json = self.convertJSON(data: scheduleData, key: "response", index: 0)
                if let schedule = json as? Dictionary<String, Any>{
                    let totalSchedule = schedule["data"]! as! Array<Dictionary<String, Any>>
                    self.unwrapSchedule(totalSchedule: totalSchedule)
                }
            }
            task.resume()
        }else{
            
            //Creates a accesstoken by making another HTTP request. After that does the same as above.
            
            let activationCode = defaults.value(forKey: "Activation code") as! String
            let url = URL(string: "https://driestarcollege.zportal.nl/api/v3/oauth/token")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let postString = "grant_type=authorization_code&code="+activationCode
            request.httpBody = postString.data(using: .utf8)
            
            let task = URLSession.shared.dataTask(with: request) { tokenData, response, error in
                guard let tokenData = tokenData, error == nil else {
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                if let accestoken = self.convertJSON(data: tokenData, key: "access_token", index: 0) as? String{
                    
                    self.defaults.set(accestoken, forKey: "Accestoken")
                    
                    let url = URL(string: "https://driestarcollege.zportal.nl/api/v3/appointments?user=" + studentCode + "&start=" + startTime + "&end=" + endTime + "&access_token=" + accestoken)!
                    var request = URLRequest(url: url)
                    request.httpMethod = "GET"
                    
                    let task = URLSession.shared.dataTask(with: request) { scheduleData, response, error in
                        guard let scheduleData = scheduleData, error == nil else {
                            print("error=\(String(describing: error))")
                            return
                        }
                        
                        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                            print("statusCode should be 200, but is \(httpStatus.statusCode)")
                            print("response = \(String(describing: response))")
                        }
                        
                        let json = self.convertJSON(data: scheduleData, key: "response", index: 0)
                        if let schedule = json as? Dictionary<String, Any>{
                            let totalSchedule = schedule["data"]! as! Array<Dictionary<String, Any>>
                            self.unwrapSchedule(totalSchedule: totalSchedule)
                        }
                    }
                    task.resume()
                }
            }
            task.resume()
        }
        print("0")
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false){ (timer) in
            print("3")
            enterDoStuff(true)
        }
    }
}
