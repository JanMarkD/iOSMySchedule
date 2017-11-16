//
//  ScheduleRetriever.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 26/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import Foundation
import UIKit

class scheduleRetriever: NSObject{
    
    let dateHelper = DateHelp()

    
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
    
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }

    
    func unwrapSchedule(totalSchedule: Array<Dictionary<String, Any>>) -> Array<Dictionary<String,String>>{
        var mySchedule = Array<Dictionary<String,String>>()
        for x in 0..<totalSchedule.count{
            var myLesson = Dictionary<String, String>()
            let lesson = totalSchedule[x]
            
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
            
            print(change)
            
            myLesson["time"] = time
            myLesson["date"] = (String(describing: startDate))
            myLesson["hour"] = String(hour)
            myLesson["weekNumber"] = String(weekNumber)
            myLesson["day"] = String(self.dateHelper.getDayOfWeek(date: startDate as NSDate))
            
            myLesson["teacher"] = (teacher[0] as! String)
            myLesson["subject"] = (subject[0] as! String)
            myLesson["location"] = (location[0] as! String).uppercased()
            
            myLesson["remark"] = remark
            myLesson["change"] = change
            myLesson["changeDescription"] = changeDescription
        
            mySchedule.append(myLesson)
        }
        return mySchedule
    }
    
    func getAllData(studentCode: String, startTime: String, endTime: String, completion:@escaping (_ mySchedule:Array<Dictionary<String,String>>,_ error:Error?) ->()){
        
        let defaults = UserDefaults.standard
        
        let domainName = defaults.value(forKey: "Domain name") as! String
        
        if let accesToken = (defaults.value(forKey: "Accestoken") as? String){

            let url = URL(string: "https://"+domainName+".zportal.nl/api/v3/appointments?user="+studentCode+"&start="+startTime+"&end="+endTime+"&access_token="+accesToken)!
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
                    let mySchedule = self.unwrapSchedule(totalSchedule: totalSchedule)
                    completion(mySchedule, nil)
                }
            }
            task.resume()
        }else{
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
                    
                    defaults.set(accestoken, forKey: "Accestoken")
                    
                    let url = URL(string: "https://driestarcollege.zportal.nl/api/v3/appointments?user="+studentCode+"&start="+startTime+"&end="+endTime+"&access_token="+accestoken)!
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
                            let mySchedule = self.unwrapSchedule(totalSchedule: totalSchedule)
                            completion(mySchedule, nil)
                        }
                    }
                    task.resume()
                }
            }
            task.resume()
        }
    }
}
