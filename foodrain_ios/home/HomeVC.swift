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

class HomeVC: SunViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var regionNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var HomeCategoryArray = [HomeCategoryModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HomeCategoryArray.removeAll()
        
        //API호출
        Alamofire.request(.GET, "http://10.10.0.54:9090/api/categorycodes.json", parameters: nil)
            .responseJSON {
                response in
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.result)   // result of response serialization
                
                //API호출 결과
                if let JSON = response.result.value {
                    if let results = JSON as? NSArray {
                        print(results)
                            for rs in results {
                                if let dict1 = rs as? NSDictionary {
                                    let CategoryModel = HomeCategoryModel()
                                    CategoryModel.id = dict1["id"] as? Int
                                    CategoryModel.name = dict1["name"] as? String
                                    
                                    print(CategoryModel.id)
                                    print(CategoryModel.name)
                                    
                                    self.HomeCategoryArray.append(CategoryModel)
                                }
                            }
                        self.collectionView.reloadData()
                    }
                }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let preferences = NSUserDefaults.standardUserDefaults()

        
        if preferences.objectForKey("RegionName") != nil {
            regionNameLabel.text = preferences.objectForKey("RegionName") as? String
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
        cell.categoryImage.highlightedImage = UIImage(named: "testimg1")
        
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
        self.navigationController?.pushViewController(StoreListsController, animated: true)
    }
    @IBAction func setRegion(sender: AnyObject) {
        let SetRegionController = (UIStoryboard (name: "home", bundle: nil).instantiateViewControllerWithIdentifier("SetRegionVC")) as! SetRegionVC
        self.navigationController?.pushViewController(SetRegionController, animated: true)
    }
}