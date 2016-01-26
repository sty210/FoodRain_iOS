//
//  HomeVC.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 25..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func viewDidLoad() {
        print("viewDidLoad() is completed.")
        //self.navigationItem.title = "FoodRain"
        //self.title = "FoodRain"
    }
    
    /*override func viewWillAppear(animated: Bool) {
        navigationItem.title = "FoodRain"
    }*/
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView =
        collectionView.dequeueReusableSupplementaryViewOfKind(kind,
            withReuseIdentifier: "RegionCell",
            forIndexPath: indexPath)
            as! HomeRegionReusableView
        switch kind {
            case UICollectionElementKindSectionHeader:
                headerView.testLabel.text = "내위치"
                return headerView
            default:
                return headerView
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as! HomeCategoryCell
        //cell.categoryBtn.setImage(UIImage(named: "store_normal"), forState: UIControlState.Normal)
        //cell.categoryBtn.setImage(UIImage(named: "store_pressed"), forState: UIControlState.Highlighted)
        
        cell.categoryImage.image = UIImage(named: "LaunchImg")
        cell.categoryImage.highlightedImage = UIImage(named: "testimg1")
        
        
        
        return cell;
    }
    
}