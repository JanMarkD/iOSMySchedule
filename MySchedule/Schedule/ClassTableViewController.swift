//
//  ClassTableViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 27/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class ClassTableViewController: UITableViewController {
    
    
    //Setup Data
    
    var classData = Dictionary<String, String>()
    
    let numberOfRowsInSection = [5,1,1]
    
    //Outlets
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var remark: UILabel!
    @IBOutlet weak var descriptionChange: UILabel!
    
    
    //Functions
    
    
    
    
    //Actions
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let subjectString = classData["subject"]{
            if subjectString != ""{
                subject.text = subjectString
            }
            self.navigationItem.title = subjectString
        }
        if let locationString = classData["location"]{
            if locationString != ""{
                location.text = locationString
            }
        }
        if let teacherString = classData["teacher"]{
            if teacherString != ""{
                teacher.text = teacherString
            }
        }
        if let hourString = classData["hour"]{
            if hourString != ""{
                hour.text = hourString
            }
        }
        if let timeString = classData["time"]{
            if timeString != ""{
                time.text = timeString
            }
        }
        if let remarkString = classData["remark"]{
            if remarkString != ""{
                remark.text = remarkString
            }
        }
        if let descriptionString = classData["changeDescription"]{
            if descriptionString != ""{
                descriptionChange.text = descriptionString
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfRowsInSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection[section]
    }
}
