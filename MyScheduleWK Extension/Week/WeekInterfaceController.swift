//
//  WeekInterfaceController.swift
//  MyScheduleWK Extension
//
//  Created by Jan-Hermen Dannenberg on 17/11/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import WatchKit
import Foundation
import CoreData

class WeekInterfaceController: WKInterfaceController {
    
    
    //Setup Data
    
    let daysInWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    let classesInWeek = [[["teacher": "jag", "location": "F105", "hour": "1", "day": "2", "remark": "", "changeDescription": "", "change": "", "time": "8:20-9:10", "subject": "wisb"], ["teacher": "hod", "hour": "2", "day": "2", "remark": "", "changeDescription": "", "change": "", "time": "9:10-10:00", "subject": "wo"], ["teacher": "keh", "location": "F004", "hour": "3", "day": "2", "remark": "", "changeDescription": "", "change": "", "time": "10:00-10:50", "subject": "schk"], ["teacher": "bet", "location": "F005", "hour": "4", "day": "2", "remark": "", "changeDescription": "", "change": "", "time": "11:25-12:15", "subject": "nlt"], ["teacher": "hil", "location": "F209", "hour": "5", "day": "2", "remark": "", "changeDescription": "", "change": "", "time": "12:15-13:05", "subject": "netl"], ["teacher": "was", "location": "B3J", "hour": "6", "day": "2", "remark": "", "changeDescription": "", "change": "", "time": "13:05-13:55", "subject": "gd"]], [["teacher": "jag", "location": "F105", "hour": "2", "day": "3", "remark": "", "changeDescription": "", "change": "", "time": "9:10-10:00", "subject": "wisb"], ["teacher": "faa", "location": "F105", "hour": "3", "day": "3", "remark": "", "changeDescription": "", "change": "", "time": "10:00-10:50", "subject": "nat"], ["teacher": "wyk", "location": "F209", "hour": "4", "day": "3", "remark": "", "changeDescription": "", "change": "", "time": "11:25-12:15", "subject": "entl"], ["teacher": "tew", "location": "A205", "hour": "5", "day": "3", "remark": "", "changeDescription": "", "change": "", "time": "12:15-13:05", "subject": "mo"], ["teacher": "zwb", "location": "F202", "hour": "6", "day": "3", "remark": "", "changeDescription": "Les vervalt", "change": "cancelled", "time": "13:05-13:55", "subject": "dutl"], ["hour": "6", "day": "3", "remark": "", "changeDescription": "Nieuwe activiteit", "change": "new", "time": "13:05-13:55", "subject": "act"], ["hour": "7", "day": "3", "remark": "", "changeDescription": "Nieuwe activiteit", "change": "new", "time": "14:20-15:10", "subject": "act"], ["hour": "8", "day": "3", "remark": "", "changeDescription": "Nieuwe activiteit", "change": "new", "time": "15:10-16:00", "subject": "act"], ["hour": "9", "day": "3", "remark": "", "changeDescription": "Nieuwe activiteit", "change": "new", "time": "16:00-16:50", "subject": "act"]], [], [["teacher": "tew", "location": "F101", "hour": "2", "day": "5", "remark": "", "changeDescription": "Les vervalt", "change": "cancelled", "time": "9:10-10:00", "subject": "mo"], ["teacher": "jag", "location": "F105", "hour": "3", "day": "5", "remark": "", "changeDescription": "Les vervalt", "change": "cancelled", "time": "10:00-10:50", "subject": "wisb"], ["teacher": "zwb", "location": "F210", "hour": "4", "day": "5", "remark": "", "changeDescription": "Les vervalt", "change": "cancelled", "time": "11:25-12:15", "subject": "dutl"], ["teacher": "faa", "location": "F201", "hour": "5", "day": "5", "remark": "", "changeDescription": "Les vervalt", "change": "cancelled", "time": "12:15-13:05", "subject": "nat"], ["teacher": "keh", "location": "F004", "hour": "6", "day": "5", "remark": "", "changeDescription": "Les vervalt", "change": "cancelled", "time": "13:05-13:55", "subject": "schk"], ["teacher": "bet", "location": "F107", "hour": "7", "day": "5", "remark": "", "changeDescription": "Les vervalt", "change": "cancelled", "time": "14:20-15:10", "subject": "nlt"]], [["teacher": "faa", "location": "F201", "hour": "1", "day": "6", "remark": "", "changeDescription": "Les vervalt", "change": "cancelled", "time": "8:20-9:10", "subject": "nat"], ["teacher": "shd", "location": "F208", "hour": "1", "day": "6", "remark": "", "changeDescription": "Nieuwe activiteit", "change": "new", "time": "8:20-9:10", "subject": "act"], ["teacher": "shd", "location": "F208", "hour": "2", "day": "6", "remark": "", "changeDescription": "Nieuwe activiteit", "change": "new", "time": "9:10-10:00", "subject": "act"], ["teacher": "hil", "location": "F209", "hour": "3", "day": "6", "remark": "", "changeDescription": "Les vervalt", "change": "cancelled", "time": "10:00-10:50", "subject": "netl"], ["hour": "4", "day": "6", "remark": "", "changeDescription": "Nieuwe activiteit", "change": "new", "time": "11:25-12:15", "subject": "act"], ["teacher": "jag", "location": "F105", "hour": "5", "day": "6", "remark": "", "changeDescription": "Les vervalt", "change": "cancelled", "time": "12:15-13:05", "subject": "wisb"], ["hour": "5", "day": "6", "remark": "", "changeDescription": "Nieuwe activiteit", "change": "new", "time": "12:15-13:05", "subject": "act"]]]
    
    //Outlets
    
    @IBOutlet var tableView: WKInterfaceTable!
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        populateData()
    }
    
    func populateData(){
        tableView.setNumberOfRows(daysInWeek.count, withRowType: "DayTableRow")
        for i in 0..<daysInWeek.count{
            if let row = tableView.rowController(at: i) as? DayTableRow{
                row.dayLable.setText(daysInWeek[i])
                row.hoursLabel.setText(String(classesInWeek[i].count))
            }
        }
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        if segueIdentifier == "dayTapped"{
            return classesInWeek[rowIndex]
        }else{
            return nil
        }
    }
    
}
