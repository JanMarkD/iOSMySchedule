//
//  ScheduleRetriever.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 26/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import Foundation

class scheduleRetriever: NSObject{
    
    var mySchedule = Array<Dictionary<String,String>>()
    
    func convertJSON(data: Data, key: String, index: Int) -> Any{
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any]{
                return object[key]!
            }else if let object = json as? [Any]{
                print(object[index])
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
    
    
    
    func getAllData(studentCode: String, startTime: String, endTime: String) -> Array<Dictionary<String,String>>{
        
        let defaults = UserDefaults.standard
        
        let domainName = defaults.value(forKey: "Domain name") as! String
        
        if let accesToken = (defaults.value(forKey: "Accestoken") as? String){

            let url = URL(string: "https://"+domainName+".zportal.nl/api/v3/appointments?user="+studentCode+"&start="+startTime+"&end="+endTime+"&access_token="+accesToken)!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { scheduleData, response, error in
                guard let scheduleData = scheduleData, error == nil else {
                    // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
                self.mySchedule.removeAll()
                
                let json = self.convertJSON(data: scheduleData, key: "response", index: 0)
                if let schedule = json as? Dictionary<String, Any>{
                    let totalSchedule = schedule["data"]! as! Array<Dictionary<String, Any>>
                    for x in 0..<totalSchedule.count{
                        
                        var myLesson = Dictionary<String, String>()
                        
                        let lesson = totalSchedule[x]
                    
                        let teacher = lesson["teachers"] as! NSArray
                        let subject = lesson["subjects"] as! NSArray
                        let location = lesson["locations"] as! NSArray
                        
                        let remark = lesson["remark"] as! String
                        let changeDescription = lesson["changeDescription"] as! String
                        
                        let modified = lesson["modified"] as! Int
                        let moved = lesson["moved"] as! Int
                        let cancelled = lesson["cancelled"] as! Int
                        let new = lesson["new"] as! Int
                        let hour = lesson["endTimeSlot"] as! Int
                        
                        myLesson["teacher"] = (teacher[0] as! String)
                        myLesson["subject"] = (subject[0] as! String)
                        myLesson["location"] = (location[0] as! String)
                        
                        myLesson["remark"] = (remark)
                        myLesson["changeDescription"] = (changeDescription)
                        
                        myLesson["modified"] = (String(modified))
                        myLesson["moved"] = (String(moved))
                        myLesson["cancelled"] = (String(cancelled))
                        myLesson["new"] = (String(new))
                        myLesson["hour"] = (String(hour))
                        
                        print(myLesson)
                        
                        self.mySchedule.append(myLesson)
                    }
                }
            }
            return mySchedule
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
                    // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                }
                
               
                
                if let accestoken = self.convertJSON(data: tokenData, key: "access_token", index: 0) as? String{
                    
                    //Accestoken saving
                    defaults.set(accestoken, forKey: "Accestoken")
                    
                    let url = URL(string: "https://driestarcollege.zportal.nl/api/v3/appointments?user="+studentCode+"&start="+startTime+"&end="+endTime+"&access_token="+accestoken)!
                    var request = URLRequest(url: url)
                    request.httpMethod = "GET"
                    
                    let task = URLSession.shared.dataTask(with: request) { scheduleData, response, error in
                        guard let scheduleData = scheduleData, error == nil else {
                            // check for fundamental networking error
                            print("error=\(String(describing: error))")
                            return
                        }
                        
                        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                            // check for http errors
                            print("statusCode should be 200, but is \(httpStatus.statusCode)")
                            print("response = \(String(describing: response))")
                        }
                        
                        self.mySchedule.removeAll()
                        
                        let json = self.convertJSON(data: scheduleData, key: "response", index: 0)
                        if let schedule = json as? Dictionary<String, Any>{
                            let totalSchedule = schedule["data"]! as! Array<Dictionary<String, Any>>
                            for x in 0..<totalSchedule.count{
                                
                                var myLesson = Dictionary<String, String>()
                                
                                let lesson = totalSchedule[x]
                                
                                let teacher = lesson["teachers"] as! NSArray
                                let subject = lesson["subjects"] as! NSArray
                                let location = lesson["locations"] as! NSArray
                                
                                let remark = lesson["remark"] as! String
                                let changeDescription = lesson["changeDescription"] as! String
                                
                                let modified = lesson["modified"] as! Int
                                let moved = lesson["moved"] as! Int
                                let cancelled = lesson["cancelled"] as! Int
                                let new = lesson["new"] as! Int
                                let hour = lesson["endTimeSlot"] as! Int
                                
                                myLesson["teacher"] = (teacher[0] as! String)
                                myLesson["subject"] = (subject[0] as! String)
                                myLesson["location"] = (location[0] as! String)
                                
                                myLesson["remark"] = (remark)
                                myLesson["changeDescription"] = (changeDescription)
                                
                                myLesson["modified"] = (String(modified))
                                myLesson["moved"] = (String(moved))
                                myLesson["cancelled"] = (String(cancelled))
                                myLesson["new"] = (String(new))
                                myLesson["hour"] = (String(hour))
                                
                                print(myLesson)
                                
                                self.mySchedule.append(myLesson)

                                
                            }
                        }
                    }
                    task.resume()
                }
            }
            return mySchedule
            task.resume()
        }
    }
}
