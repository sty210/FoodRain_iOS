//
//  DetaillnfoVC.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 31..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DetaillnfoVC: SunViewController{
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var hoiday: UILabel!
    @IBOutlet weak var storeTel: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    var mStoreTel: String?
    var mStoreAddress: String?
    var mStartTime: String?
    var mEndTime: String?
    var mHoiday: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func inputData() {
        deliveryTime.text = String(mStartTime! + " - " + mEndTime!)
        hoiday.text = mHoiday!
        storeTel.text = mStoreTel!
        storeAddress.text = mStoreAddress!
    }
    
}