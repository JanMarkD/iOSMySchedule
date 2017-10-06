//
//  HomeViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 08/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    //Outlets

    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var welcomeUser: UILabel!
    
    @IBOutlet weak var classRightNow: UILabel!
    
    
    //Actions
    
    @IBAction func logOut(_ sender: UIButton) {
        //logout user
    }
    
    
    
    //Functions
    
    func retrieveSchedule() -> Array<String>{
        return ["Piet Janssen", "Natuurkunde", "F201"]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let schedule = retrieveSchedule()
        
        welcomeUser.text = "Welcome, " + schedule[0]
        classRightNow.text = "You have " + schedule[1] +  ", in" + schedule[2]
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
