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
    
    let classesInWeek = [[[String:String]](),[[String:String]](),[[String:String]](),[[String:String]](),[[String:String]]()]
    
    
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
