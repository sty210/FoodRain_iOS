//
//  ReviewArrayModel.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 2. 1..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
class ReviewArrayModel: NSObject {
    var page: Int?
    var row = [ReviewModel]()
    
    override init() {
        self.page = 1
        //self.row =
    }
}
