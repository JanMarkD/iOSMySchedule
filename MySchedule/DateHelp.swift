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
