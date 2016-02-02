//
//  storeDetailReviewCell.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 2. 1..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit

class storeDetailReviewCell : UITableViewCell {
    var id: Int!
    var user_id: Int!
    var store_id: Int!
    var user_image: String?
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var created_at: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var detail: UILabel!
}