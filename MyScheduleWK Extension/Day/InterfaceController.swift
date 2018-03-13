//
//  InterfaceController.swift
//  MyScheduleWK Extension
//
//  Created by Jan-Hermen Dannenberg on 16/11/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import WatchKit
import Foundation
import UIKit


class InterfaceController: WKInterfaceController {
    
    
    //Setup Data
    
    var classesToday = [[String:String]]()
    
    
    //Outlets
    
    @IBOutlet var tableView: WKInterfaceTable!
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if let scheduleData = context as? [[String:String]]{
            self.classesToday = scheduleData
            populateTable()
        }
    }
    
    func populateTable(){
        if classesToday.count == 0{
            tableView.setNumberOfRows(1, withRowType: "NoClass")
            if let row = tableView.rowController(at: 0) as? NoClass{
                row.noClass.setText("No classes.")
            }
        }else{
            tableView.setNumberOfRows(classesToday.count, withRowType: "ClassTableRow")
            for i in 0..<classesToday.count{
                if let row = tableView.rowController(at: i) as? ClassTableRow{
                    row.subjectLabel.setText(classesToday[i]["subject"])
                    row.locationLabel.setText(classesToday[i]["location"])
                    
                    switch(Int(classesToday[i]["hour"]!))!{
                    case 1: row.hourImageView.setImage(#imageLiteral(resourceName: "modifiedYellow"))
                    case 2: row.hourImageView.setImage(#imageLiteral(resourceName: "modifiedYellow"))
                    case 3: row.hourImageView.setImage(#imageLiteral(resourceName: "modifiedYellow"))
                    case 4: row.hourImageView.setImage(#imageLiteral(resourceName: "modifiedYellow"))
                    case 5: row.hourImageView.setImage(#imageLiteral(resourceName: "modifiedYellow"))
                    case 6: row.hourImageView.setImage(#imageLiteral(resourceName: "modifiedYellow"))
                    case 7: row.hourImageView.setImage(#imageLiteral(resourceName: "modifiedYellow"))
                    case 8: row.hourImageView.setImage(#imageLiteral(resourceName: "modifiedYellow"))
                    case 9: row.hourImageView.setImage(#imageLiteral(resourceName: "modifiedYellow"))
                    default: print("")
                    }
//                    switch(classesToday[i]["change"]!){
//                    case "new", "modified", "moved": row.alertImageView.setImage(#imageLiteral(resourceName: "modifiedYellow"))
//                    case "cancelled": row.alertImageView.setImage(#imageLiteral(resourceName: "cancelledRed"))
//                    default: print("")
                    //}
                }
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
        if segueIdentifier == "classTapped"{
            if classesToday.count == 0{
                return ["subject": "None", "location": "None", "teacher": "None", "hour": "None", "time": "None"]
            }else{
                return classesToday[rowIndex]
            }
        }else{
            return nil
        }
    }
}
