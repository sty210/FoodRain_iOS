//
//  DetailReviewVC.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 31..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DetailReviewVC: SunViewController, UITableViewDelegate, UITableViewDataSource{
    
    var receivedId: Int?
    var reviewListArray: ReviewArrayModel!
    var isAlreadyDataLoaded: Bool = false
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewListArray = ReviewArrayModel()
        
        
        let requestURL = "http://192.168.0.2:3000/api/reviews.json"
       
        if isAlreadyDataLoaded == false {
        Alamofire.request(.GET, requestURL, parameters: ["store_id": self.receivedId!, "page": self.reviewListArray.page!])
            .responseJSON {
                response in
                
                print("requestURL : "+requestURL)
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.result)   // result of response serialization
                
                //API호출 결과
                if let JSON = response.result.value {
                    if let JSON_ = JSON as? NSDictionary {
                        if let results = JSON_["rows"] as? NSArray {
                        print(results)
                            for rs in results {
                                if let dict = rs as? NSDictionary {
                                    
                                    let review = ReviewModel()
                                    review.id = dict["id"] as? Int
                                    review.store_id = dict["store_id"] as? Int
                                    
                                    
                                    if let user = dict["user"] as? NSDictionary {
                                            review.user_id = user["user_id"] as? Int
                                            review.nickname = user["nickname"] as? String
                                            review.user_image = user["main_image"] as? String
                                    }
                                    
                                    
                                    review.detail = dict["detail"] as? String
                                    review.grade = dict["grade"] as? Float
                                    review.created_at = dict["created_at"] as? String
                                    //review.images =
                                    
                                    
                                    self.reviewListArray.row.append(review)
                                }
                            }
                        }
                    }
                }
                self.reviewListArray.page = self.reviewListArray.page! + 1
                self.tableView.reloadData()
            }
            isAlreadyDataLoaded = true
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewListArray.row.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("storeDetailReviewCell", forIndexPath: indexPath) as! storeDetailReviewCell
        
        cell.id = reviewListArray.row[indexPath.row].id
        cell.user_id = reviewListArray.row[indexPath.row].user_id
        cell.store_id = reviewListArray.row[indexPath.row].store_id
        cell.user_image = reviewListArray.row[indexPath.row].user_image
        cell.created_at.text = "작성시간 : "+reviewListArray.row[indexPath.row].created_at!
        cell.nickname.text = "닉네임 : "+reviewListArray.row[indexPath.row].nickname!
        cell.grade.text = "평점 : "+String(reviewListArray.row[indexPath.row].grade!)+"/5.0"
        cell.detail.text = "내용 : "+reviewListArray.row[indexPath.row].detail!
        cell.userProfileImageView.image = UIImage(named: "profileimageexample")

        /*
        let imagePath = reviewListArray[indexPath.row].main_image!;
        
        Alamofire.request(.GET, imagePath).response() {
        //imagePath가 가지고있는 url로 이미지를 로드하여 UIImageView에 세팅한다
        (_, _, data, _) in
        let image = UIImage(data:data!)
        cell.userProfileImageView.image = image
        }
        */
        
        //tableView.rowHeight = UITableViewAutomaticDimension
        //cell.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
}