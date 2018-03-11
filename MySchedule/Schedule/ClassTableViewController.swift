//
//  ClassTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 27/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit
import CoreData

// TODO: Design tableviewcells and text colors.

class ClassTableViewController: UITableViewController {
    
    //Setup Data
    
    var classData = Lesson()
    
    let numberOfRowsInSection = [5,1,1]
    
    //Outlets
    
    @IBOutlet weak var subject: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var teacher: UILabel!
    
    @IBOutlet weak var hour: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var remark: UILabel!
    
    @IBOutlet weak var descriptionChange: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Checks if data is empty, if not fills in data.

        if let subjectString = classData.subject{
            if subjectString != ""{
                subject.text = subjectString
            }
            self.navigationItem.title = subjectString
        }
        if let locationString = classData.location{
            if locationString != ""{
                location.text = locationString
            }
        }
        if let teacherString = classData.teacher{
            if teacherString != ""{
                teacher.text = teacherString
            }
        }
        if let hourString = classData.hour{
            if hourString != ""{
                hour.text = hourString
            }
        }
        if let timeString = classData.time{
            if timeString != ""{
                time.text = timeString
            }
        }
        if let remarkString = classData.remarks{
            if remarkString != ""{
                remark.text = remarkString
            }
        }
        if let descriptionString = classData.changeDescription{
            if descriptionString != ""{
                descriptionChange.text = descriptionString
            }
        }
        
        //Cell height and background.
        
        tableView.rowHeight = 46
        
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "Background home"))
    }
    
    //Set up tableview sections, rows and headers.

    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfRowsInSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = UIColor.white
        }
    }
}
