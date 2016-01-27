//
//  SunViewController.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 27..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit

class SunViewController: UIViewController {
    var statusBarHidden: Bool?
    var navigationBarHidden: Bool?
    
    override func viewDidLoad() {
        statusBarHidden = true
        navigationBarHidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    /*override func prefersStatusBarHidden() -> Bool {
        return true
    }*/
}