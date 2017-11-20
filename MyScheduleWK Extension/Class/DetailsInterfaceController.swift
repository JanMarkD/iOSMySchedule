//
//  DetailsInterfaceController.swift
//  MyScheduleWK Extension
//
//  Created by Jan-Hermen Dannenberg on 16/11/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import WatchKit
import Foundation


class DetailsInterfaceController: WKInterfaceController {
    
    
    //Setup Data
    
    let numberOfRows = 7
    
    var lessonData = [String:String]()
    
    
    //Outlets
    
    @IBOutlet var tableView: WKInterfaceTable!

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let lesson = context as? [String:String]{
            lessonData = lesson
            populateData()
        }
    }
    
    func populateData(){
        tableView.setRowTypes(["SubjectRow", "LocationRow", "TeacherRow", "HourRow", "TimeRow", "RemarksRow", "ChangesRow"])
        if let row = tableView.rowController(at: 0) as? SubjectRow{
            row.subjectLabel.setText(lessonData["subject"])
        }
        if let row = tableView.rowController(at: 1) as? LocationRow{
            row.locationLabel.setText(lessonData["location"])
        }
        if let row = tableView.rowController(at: 2) as? TeacherRow{
            row.teacherLabel.setText(lessonData["teacher"])
        }
        if let row = tableView.rowController(at: 3) as? HourRow{
            row.hourLabel.setText(lessonData["hour"])
        }
        if let row = tableView.rowController(at: 4) as? TimeRow{
            row.timeLabel.setText(lessonData["time"])
        }
        if let row = tableView.rowController(at: 5) as? RemarksRow{
            row.remarksLabel.setText(lessonData["remark"])
        }
        if let row = tableView.rowController(at: 6) as? ChangesRow{
            row.changesLabel.setText(lessonData["changeDescription"])
        }
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
}
