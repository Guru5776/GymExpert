//
//  MyTabBarController.swift
//  GymExpert
//
//  Created by Admin on 1/7/19.
//  Copyright © 2019 Nikita Tkachenko. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .darkBlue
        tabBar.tintColor = .lightRed
    }
}
