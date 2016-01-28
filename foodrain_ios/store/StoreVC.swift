//
//  StoreVC.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 27..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit

class StoreVC: SunViewController {
    
    override func viewDidLoad() {
    }
    
    @IBAction func backToHome(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}