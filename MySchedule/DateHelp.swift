//
//  DateHelp.swift
//  MySchedule
//
//  Created by Jan-Hermen Dannenberg on 27/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import Foundation

class DateHelp: NSObject{
    
    //Returns current weeknumber.
    
    func getWeekNumber(date: NSDate) -> Int{
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.ISO8601)!
        let myComponents = myCalendar.components(.weekOfYear, from: date as Date)
        let weekNumber = myComponents.weekOfYear
        return weekNumber!
    }
    
    //Returns time of a certain date in this format: 00:00.
    
    func minutesAndHoursFromDate(date: Date) -> [String:Int]{
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        return ["hours": hour, "minutes": minute]
    }
    
    //Converts a date to into which class hour it is at that time.
    
    func timeToHour(date: Date) -> Int{
        let firstHour = (8 * 60)
        let secondHour = (9 * 60) + 5
        let thirdHour = (9 * 60) + 55
        let fourthHour = (10 * 60) + 45
        let fifthHour = (12 * 60) + 10
        let sixthHour = (13 * 60)
        let seventhHour = (13 * 60) + 50
        let eighthHour = (15 * 60) + 5
        let endOfSchool = (15 * 60) + 55
        let endOfDay = (24 * 60)
        
        let minutesAndHours = minutesAndHoursFromDate(date: date)
        let timeInMinutes = (minutesAndHours["hours"]! * 60) + minutesAndHours["minutes"]!
        
        if timeInMinutes >= firstHour && timeInMinutes <= secondHour{
            return 1
        }else if timeInMinutes >= secondHour && timeInMinutes <= thirdHour{
            return 2
        }else if timeInMinutes >= thirdHour && timeInMinutes <= fourthHour{
            return 3
        }else if timeInMinutes >= fourthHour && timeInMinutes <= fifthHour{
            return 4
        }else if timeInMinutes >= fifthHour && timeInMinutes <= sixthHour{
            return 5
        }else if timeInMinutes >= sixthHour && timeInMinutes <= seventhHour{
            return 6
        }else if timeInMinutes >= seventhHour && timeInMinutes <= eighthHour{
            return 7
        }else if timeInMinutes >= eighthHour && timeInMinutes <= endOfSchool{
            return 8
        }else if timeInMinutes >= endOfSchool && timeInMinutes<=endOfDay{
            return 9
        }else{
            return 0
        }
    }
    
    //Returns start of current week.
    
    func getStartOfCurrentWeek() -> Int{
        return getUnixTime(date: Date().startOfWeek! as NSDate)
    }
    
    //Returns Unix time of a certain date (time in seconds since 1970).
    
    func getUnixTime(date: NSDate) -> Int{
        let result = date.timeIntervalSince1970
        return Int(result)
    }
    
    //Returns current day (1 = Sunday, 2 = Monday, ...)
    
    func getDayOfWeek(date:NSDate) -> Int {
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let weekDay = myCalendar.component(.weekday, from: date as Date)
        return weekDay
    }
    
}
extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
}
extension Date {
    func dateAt(hours: Int, minutes: Int) -> Date{
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        var date_components = calendar.components(
            [NSCalendar.Unit.year,
             NSCalendar.Unit.month,
             NSCalendar.Unit.day],
            from: self)
        
        date_components.hour = hours
        date_components.minute = minutes
        date_components.second = 0
        
        let newDate = calendar.date(from: date_components)!
        return newDate
    }
}
