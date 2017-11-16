//
//  HomeViewController.swift
//  MySchedule
//
//  Created by Jan-Mark Dannenberg on 08/09/2017.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//
import UIKit


class HomeViewController: UIViewController {
    
    var mySchedule = Array<Dictionary<String,String>>()
    
    let retriever = scheduleRetriever()
    
    
    //Outlets
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var welcomeUser: UILabel!
    
    @IBOutlet weak var classRightNow: UILabel!
    
    
    //Actions
    
    @IBAction func logOut(_ sender: UIButton) {
        //logout user
    }
    
    
    
    //Functions
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        
        
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
