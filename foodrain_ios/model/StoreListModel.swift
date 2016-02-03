//
//  StoreListModel.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 28..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit

class StoreListModel: NSObject {
    var id: Int?
    var name: String?
    var phone: String?
    var address: String?
    var start_time: String?
    var end_time: String?
    var holiday: String?
    var status: Int?
    var tag: String?
    var review_cnt: Int?
    var grade_avg: Float?
    var menus = [ImageModel]()
    var images = [ImageModel]()
    
}