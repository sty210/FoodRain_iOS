//
//  ReviewModel.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 2. 1..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit

class ReviewModel: NSObject {
    var id: Int?
    var store_id: Int?
    var user_id: Int?
    var user_image: String?
    var nickname: String?
    var grade: Float?
    var detail: String?
    var created_at: String?
    var updated_dat: String?
    var images = [ImageModel]()
}