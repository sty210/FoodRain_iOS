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
import CoreLocation

class SetRegionVC: SunViewController , UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var RegionArray = [SetRegionModel]()
    var locationManager: CLLocationManager = CLLocationManager()
    var myLongitude: Float? = 0.0
    var myLatitude: Float? = 0.0
    @IBOutlet weak var mIndcator: UIActivityIndicatorView!
    
    @IBAction func setLocationByCurrentXY(sender: AnyObject) {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        print(locations[0].coordinate.longitude)
        print(locations[0].coordinate.latitude)
        
        let param = ["longitude": String(locations[0].coordinate.longitude), "latitude": String(locations[0].coordinate.latitude)]
        print(String(myLongitude!)+" , "+String(myLatitude!)+"로 요청!")
        mIndcator.hidden = false
        //API호출
        Alamofire.request(.GET, "http://10.10.0.58:9090/api/regions.json", parameters: param)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let results = JSON as? NSArray {
                        for rs in results {
                            if let dict = rs as? NSDictionary {
                                let region = SetRegionModel()
                                region.address = dict["address"] as? String
                                
                                if let loc = dict["location"] as? NSDictionary {
                                    region.longitude = loc["longitude"] as? Float
                                    region.latitude = loc["latitude"] as? Float
                                }
                                
                                
                                let preferences = NSUserDefaults.standardUserDefaults()
                                
                                preferences.setValue(region.address!, forKey: "myAddress")
                                preferences.setFloat(region.longitude!, forKey: "myLongitude")
                                preferences.setFloat(region.latitude!, forKey: "myLatitude")
                                print("현재 지역을")
                                print(region.address!)
                                print(region.longitude!)
                                print(region.latitude!)
                                print("로 설정!")
                                
                                //  Save to disk
                                preferences.synchronize()
                                
                            }
                        }
                    }
                }
                self.mIndcator.hidden = true
                self.navigationController?.popViewControllerAnimated(true)
        }
        
        

    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        print("SetRegionVC - 권한 설정 부분.")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.showsScopeBar = true
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        
        RegionArray.removeAll()
        let param = ["name": searchBar.text!]
        mIndcator.hidden = false
        Alamofire.request(.GET, "http://10.10.0.58:9090/api/regions.json", parameters: param)
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let results = JSON as? NSArray {
                        for rs in results {
                            if let dict = rs as? NSDictionary {
                                let region = SetRegionModel()
                                region.address = dict["address"] as? String
                                
                                if let loc = dict["location"] as? NSDictionary {
                                    region.longitude = loc["longitude"] as? Float
                                    region.latitude = loc["latitude"] as? Float
                                }
                                self.RegionArray.append(region)
                            }
                        }
                    }
                }
                self.mIndcator.hidden = true
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
        
        cell.addressLabel.text = RegionArray[indexPath.row].address
        //cell.Address
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
                
        let preferences = NSUserDefaults.standardUserDefaults()
        
        preferences.setValue(RegionArray[indexPath.row].address!, forKey: "myAddress")
        preferences.setFloat(RegionArray[indexPath.row].longitude!, forKey: "myLongitude")
        preferences.setFloat(RegionArray[indexPath.row].latitude!, forKey: "myLatitude")
        
        print("검색지역을")
        print(RegionArray[indexPath.row].address!)
        print(RegionArray[indexPath.row].longitude!)
        print(RegionArray[indexPath.row].latitude!)
        print("로 설정!")
        
        //  Save to disk
        preferences.synchronize()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    @IBAction func backToHome(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}