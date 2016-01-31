//
//  BookmarkStoreVC.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 31..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit

class BookmarkStoreVC: SunViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("storeTableViewCell", forIndexPath: indexPath) as! StoreListTableViewCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
}