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
//        let HomeViewController = (UIStoryboard (name: "home", bundle: nil).instantiateViewControllerWithIdentifier("HomeVC")) as! HomeVC
//        self.navigationController?.popToViewController(HomeViewController, animated: true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}