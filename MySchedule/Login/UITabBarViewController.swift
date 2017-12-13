//
//  UITabBarViewController.swift
//  MySchedule
//
//  Created by Marjolein Uitbeijerse on 17-10-17.
//  Copyright © 2017 Jan-Mark Dannenberg. All rights reserved.
//

import UIKit

class UITabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Which tab the tabbarcontroller should start with.
        
        self.selectedIndex = 1
        
        tabBar.isTranslucent = true
    }
}
