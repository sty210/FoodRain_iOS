//
//  SetRegionVC.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 27..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class SetRegionVC: SunViewController , UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var RegionArray = [SetRegionModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.showsScopeBar = true
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        
        RegionArray.removeAll()
        let param = ["name": searchBar.text!]
        
        Alamofire.request(.GET, "http://192.168.0.2:3000/api/regioncodes.json", parameters: param)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let results = JSON as? NSArray {
                        for rs in results {
                            if let dict = rs as? NSDictionary {
                                let region = SetRegionModel()
                                region.id = dict["id"] as? Int
                                region.name = dict["name"] as? String
                                
                                self.RegionArray.append(region)
                            }
                        }
                    }
                }
                self.tableView.reloadData()
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.RegionArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SetRegionCell", forIndexPath: indexPath) as! SetRegionCell
        
        cell.addressLabel.text = RegionArray[indexPath.row].name
        //cell.Address
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
                
        let preferences = NSUserDefaults.standardUserDefaults()
                
        preferences.setInteger(RegionArray[indexPath.row].id!, forKey: "RegionCode")
        preferences.setValue(RegionArray[indexPath.row].name!, forKey: "RegionName")
                
        //  Save to disk
        preferences.synchronize()
    
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    @IBAction func backToHome(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}