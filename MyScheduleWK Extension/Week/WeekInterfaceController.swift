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
    
    let classesInWeek = [[["teacher": "jag", "location": "F105", "hour": "1", "day": "2", "remark": "", "changeDescription": "", "time": "8:20-9:10", "subject": "wisb"], ["teacher": "hod", "hour": "2", "day": "2", "remark": "", "changeDescription": "", "time": "9:10-10:00", "subject": "wo"], ["teacher": "keh", "location": "F004", "hour": "3", "day": "2", "remark": "", "changeDescription": "", "time": "10:00-10:50", "subject": "schk"], ["teacher": "bet", "location": "F005", "hour": "4", "day": "2", "remark": "", "changeDescription": "", "time": "11:25-12:15", "subject": "nlt"], ["teacher": "hil", "location": "F209", "hour": "5", "day": "2", "remark": "", "changeDescription": "", "time": "12:15-13:05", "subject": "netl"], ["teacher": "was", "location": "B3J", "hour": "6", "day": "2", "remark": "", "changeDescription": "", "time": "13:05-13:55", "subject": "gd"]], [["teacher": "jag", "location": "F105", "hour": "2", "day": "3", "remark": "", "changeDescription": "", "time": "9:10-10:00", "subject": "wisb"], ["teacher": "faa", "location": "F105", "hour": "3", "day": "3", "remark": "", "changeDescription": "", "time": "10:00-10:50", "subject": "nat"], ["teacher": "wyk", "location": "F209", "hour": "4", "day": "3", "remark": "", "changeDescription": "", "time": "11:25-12:15", "subject": "entl"], ["teacher": "tew", "location": "A205", "hour": "5", "day": "3", "remark": "", "changeDescription": "", "time": "12:15-13:05", "subject": "mo"], ["teacher": "zwb", "location": "F202", "hour": "6", "day": "3", "remark": "", "changeDescription": "Les vervalt", "time": "13:05-13:55", "subject": "dutl"], ["remark": "", "changeDescription": "Nieuwe activiteit", "hour": "6", "time": "13:05-13:55", "day": "3", "subject": "act"], ["remark": "", "changeDescription": "Nieuwe activiteit", "hour": "7", "time": "14:20-15:10", "day": "3", "subject": "act"], ["remark": "", "changeDescription": "Nieuwe activiteit", "hour": "8", "time": "15:10-16:00", "day": "3", "subject": "act"], ["remark": "", "changeDescription": "Nieuwe activiteit", "hour": "9", "time": "16:00-16:50", "day": "3", "subject": "act"]], [], [["teacher": "tew", "location": "F101", "hour": "2", "day": "5", "remark": "", "changeDescription": "Les vervalt", "time": "9:10-10:00", "subject": "mo"], ["teacher": "jag", "location": "F105", "hour": "3", "day": "5", "remark": "", "changeDescription": "Les vervalt", "time": "10:00-10:50", "subject": "wisb"], ["teacher": "zwb", "location": "F210", "hour": "4", "day": "5", "remark": "", "changeDescription": "Les vervalt", "time": "11:25-12:15", "subject": "dutl"], ["teacher": "faa", "location": "F201", "hour": "5", "day": "5", "remark": "", "changeDescription": "Les vervalt", "time": "12:15-13:05", "subject": "nat"], ["teacher": "keh", "location": "F004", "hour": "6", "day": "5", "remark": "", "changeDescription": "Les vervalt", "time": "13:05-13:55", "subject": "schk"], ["teacher": "bet", "location": "F107", "hour": "7", "day": "5", "remark": "", "changeDescription": "Les vervalt", "time": "14:20-15:10", "subject": "nlt"]], [["teacher": "faa", "location": "F201", "hour": "1", "day": "6", "remark": "", "changeDescription": "Les vervalt", "time": "8:20-9:10", "subject": "nat"], ["teacher": "shd", "location": "F208", "hour": "1", "day": "6", "remark": "", "changeDescription": "Nieuwe activiteit", "time": "8:20-9:10", "subject": "act"], ["teacher": "shd", "location": "F208", "hour": "2", "day": "6", "remark": "", "changeDescription": "Nieuwe activiteit", "time": "9:10-10:00", "subject": "act"], ["teacher": "hil", "location": "F209", "hour": "3", "day": "6", "remark": "", "changeDescription": "Les vervalt", "time": "10:00-10:50", "subject": "netl"], ["remark": "", "changeDescription": "Nieuwe activiteit", "hour": "4", "time": "11:25-12:15", "day": "6", "subject": "act"], ["teacher": "jag", "location": "F105", "hour": "5", "day": "6", "remark": "", "changeDescription": "Les vervalt", "time": "12:15-13:05", "subject": "wisb"], ["remark": "", "changeDescription": "Nieuwe activiteit", "hour": "5", "time": "12:15-13:05", "day": "6", "subject": "act"]]]
    
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
