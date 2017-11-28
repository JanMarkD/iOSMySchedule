//
//  DateHelp.swift
//  MySchedule
//
//  Created by Jan-Hermen Dannenberg on 27/10/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import Foundation

class DateHelp: NSObject{
    
    func getWeekNumber(date: NSDate) -> Int{
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.ISO8601)!
        let myComponents = myCalendar.components(.weekOfYear, from: date as Date)
        let weekNumber = myComponents.weekOfYear
        return weekNumber!
    }
    
    func minutesAndHoursFromDate(date: Date) -> [String:Int]{
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        return ["hours": hour, "minutes": minute]
    }
    
    
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
    
    func getStartOfCurrentWeek() -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: String(describing: NSDate()))
        
        if let date = date {
            let calendar = Calendar(identifier: .gregorian)
            
            var startDate : Date = Date()
            var interval : TimeInterval = 0
            
            if calendar.dateInterval(of: .weekOfYear, start: &startDate, interval: &interval, for: date) {
                return getUnixTime(date: startDate as NSDate)
            }
        }
        return getUnixTime(date: NSDate())
    }
    
    
    func getUnixTime(date: NSDate) -> Int{
        let result = date.timeIntervalSince1970
        return Int(result)
    }
    
    func getDayOfWeek(date:NSDate) -> Int {
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let weekDay = myCalendar.component(.weekday, from: date as Date)
        return weekDay
    }
    
}
extension Date {
    var startOfWeek: Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
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
