//
//  Store.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 30..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation

class Store: NSObject {
    var page: Int?
    var row = [StoreListModel]()
    
    override init() {
        self.page = 1
        //self.row = 
    }
}