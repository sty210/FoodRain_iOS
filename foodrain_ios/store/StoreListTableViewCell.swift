//
//  StoreListTableViewCell.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 28..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit

class StoreListTableViewCell : UITableViewCell {
    
    var id: Int!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var storeRating: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var storeTag: UILabel!
}