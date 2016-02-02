//
//  DetailMenuVC.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 31..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DetailMenuVC: SunViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    let menuImages = ["chicken1","chicken2","chicken3","chicken4","chicken5","chicken6","chicken7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuImages.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("storeDetailMenuCell", forIndexPath: indexPath) as! storeDetailMenuCell
        
        //cell.id = HomeCategoryArray[indexPath.row].id
        //cell.categoryName.text = HomeCategoryArray[indexPath.row].name
        let exampleImage = menuImages[indexPath.row]
        cell.menuImageView.image = UIImage(named: exampleImage)
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}