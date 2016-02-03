//
//  HomeVC.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 25..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CoreLocation

class HomeVC: SunViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var regionNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var HomeCategoryArray = [HomeCategoryModel]()
    var locationManager: CLLocationManager!
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        print(locations[0].coordinate.longitude)
        print(locations[0].coordinate.latitude)
        
        let param = ["longitude": locations[0].coordinate.longitude, "latitude": locations[0].coordinate.latitude]
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
                                
                                self.regionNameLabel.text = region.address
                            }
                        }
                    }
                }
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus){
        print("1")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        self.tabBarController?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.redColor()], forState: .Selected)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    
        
        /*
        //사용자에게 권한 요청
        locationManager.requestWhenInUseAuthorization()
        //정확도 설정 : 10미터 이내의 정확도(더 정확한 설정도 가능하지만 배터리소모량 증가함)
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        //위치변화 감지 반경설정(설정안함)
        locationManager.distanceFilter = kCLDistanceFilterNone
        //위치 업데이트 시작
        locationManager.startUpdatingLocation()
        //경위도를 얻어옴
        let location: CLLocation = CLLocation()
        let currentLatitude: CLLocationDistance = location.coordinate.latitude
        let currentLongitude: CLLocationDistance = location.coordinate.longitude
        
        print("경위도 테스트 시작!")
        print(currentLatitude)
        print(currentLongitude)
        print("경위도 테스트 끝!")
        */
        
        
        self.HomeCategoryArray.removeAll()
        
        //API호출
        Alamofire.request(.GET, "http://10.10.0.58:9090/api/categories.json", parameters: nil)
            .responseJSON {
                response in
                print("요청 시작!")
                //API호출 결과
                if let JSON = response.result.value {
                    if let results = JSON as? NSArray {
                            for rs in results {
                                if let dict1 = rs as? NSDictionary {
                                    let CategoryModel = HomeCategoryModel()
                                    CategoryModel.id = dict1["id"] as? Int
                                    CategoryModel.name = dict1["name"] as? String
                                    
                                    self.HomeCategoryArray.append(CategoryModel)
                                }
                            }
                        self.collectionView.reloadData()
                    }
                }
        print("요청 끝남!")
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let preferences = NSUserDefaults.standardUserDefaults()

        if preferences.objectForKey("myAddress") != nil {
            regionNameLabel.text = preferences.objectForKey("myAddress") as? String
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.HomeCategoryArray.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as! HomeCategoryCell
 
        cell.id = HomeCategoryArray[indexPath.row].id
        cell.categoryName.text = HomeCategoryArray[indexPath.row].name
        cell.categoryImage.image = UIImage(named: "ready")
        //cell.categoryImage.highlightedImage = UIImage(named: "testimg1")
        
        /*
        
        cell.id = HomeCategoryArray[indexPath.row].id;
        let imagePath = HomeCategoryArray[indexPath.row].cellImageViewStr!;
        
        Alamofire.request(.GET, imagePath).response() {
            //imagePath가 가지고있는 url로 이미지를 로드하여 UIImageView에 세팅한다
            (_, _, data, _) in
            let image = UIImage(data:data!)
            cell.categoryImage.image = image
        }
        */
        
        
        return cell;
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let StoreListsController = (UIStoryboard (name: "store", bundle: nil).instantiateViewControllerWithIdentifier("StoreVC")) as! StoreVC
        StoreListsController.categoryId = HomeCategoryArray[indexPath.row].id
        StoreListsController.receivedCategoryName = HomeCategoryArray[indexPath.row].name!
        for _ in HomeCategoryArray {
            StoreListsController.storeListArray.append(Store())
        }

        self.navigationController?.pushViewController(StoreListsController, animated: true)
    }
    @IBAction func setRegion(sender: AnyObject) {
        let SetRegionController = (UIStoryboard (name: "regionsetting", bundle: nil).instantiateViewControllerWithIdentifier("SetRegionVC")) as! SetRegionVC
        self.navigationController?.pushViewController(SetRegionController, animated: true)
    }
}