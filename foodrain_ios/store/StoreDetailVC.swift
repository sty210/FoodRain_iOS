//
//  StoreDetailVC.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 30..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class StoreDetailVC: SunViewController ,UITabBarDelegate {
    @IBOutlet weak var storeTitle: UILabel!
    @IBOutlet weak var storeDetailContentsView: UIView!
    @IBOutlet weak var bottomRatingSpaceLabel: UILabel!
    
    var receivedId: Int?
    var receivedTitle: String?
    var receivedRating: Float?
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tabItem1: UITabBarItem!
    @IBOutlet weak var tabItem2: UITabBarItem!
    @IBOutlet weak var tabItem3: UITabBarItem!

    var menuVC: DetailMenuVC?
    var infoVC: DetaillnfoVC?
    var reviewVC: DetailReviewVC?
    
    let storeInfo = StoreListModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeTitle.text = receivedTitle
        bottomRatingSpaceLabel.text = "평점 : "+String(receivedRating!)+"/5.0"
        self.tabBarController?.tabBar.hidden = true


        
        
        self.tabItem1.setTitleTextAttributes(
            [NSFontAttributeName: UIFont.systemFontOfSize(14)],
            forState: .Normal)
        self.tabItem2.setTitleTextAttributes(
            [NSFontAttributeName: UIFont.systemFontOfSize(14)],
            forState: .Normal)
        self.tabItem3.setTitleTextAttributes(
            [NSFontAttributeName: UIFont.systemFontOfSize(14)],
            forState: .Normal)
        
        
        //self.receivedId = String(self.receivedId!)
        
        self.menuVC = (UIStoryboard (name: "store", bundle: nil).instantiateViewControllerWithIdentifier("DetailMenuVC")) as? DetailMenuVC
        self.infoVC = (UIStoryboard (name: "store", bundle: nil).instantiateViewControllerWithIdentifier("DetaillnfoVC")) as? DetaillnfoVC
        self.reviewVC = (UIStoryboard (name: "store", bundle: nil).instantiateViewControllerWithIdentifier("DetailReviewVC")) as? DetailReviewVC
        
        let basicUrl = "http://10.10.0.58:9090/api/stores/"
        let inputID = String(self.receivedId!)
        
        let requestURL = basicUrl + inputID + ".json"
        
        
        
        Alamofire.request(.GET, requestURL, parameters: nil)
            .responseJSON {
                response in
                
                print("requestURL : "+requestURL)
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.result)   // result of response serialization
                
                //API호출 결과
                if let JSON = response.result.value {
                    if let dict = JSON as? NSDictionary {
                        print(dict)
                        
                        self.storeInfo.id = dict["id"] as? Int
                        self.storeInfo.name = dict["name"] as? String
                        self.storeInfo.phone = dict["phone"] as? String
                        self.storeInfo.address = dict["address"] as? String
                        self.storeInfo.start_time = dict["start_time"] as? String
                        self.storeInfo.end_time = dict["end_time"] as? String
                        self.storeInfo.holiday = dict["holiday"] as? String
                        self.storeInfo.review_cnt = dict["review_count"] as? Int
                        self.storeInfo.grade_avg = dict["grade_average"] as? Float
                        
                        if let menus = dict["menus"] as? NSArray {
                            for menu in menus {
                                if let m = menu as? NSDictionary{
                                    let menumodel = ImageModel()
                                    menumodel.url = m["url"] as? String
                                    self.storeInfo.menus.append(menumodel)
                                }
                            }
                        }
                        
                        if let images = dict["images"] as? NSArray {
                            for image in images {
                                if let img = image as? NSDictionary{
                                    let imgmodel = ImageModel()
                                    imgmodel.url = img["url"] as? String
                                    self.storeInfo.images.append(imgmodel)
                                }
                            }
                        }
                        
                    }
                }
                
                
                
                self.menuVC!.mImageListModel = self.storeInfo.menus

                self.infoVC!.mStoreTel = self.storeInfo.phone
                self.infoVC!.mStoreAddress = self.storeInfo.address
                self.infoVC!.mStartTime = self.storeInfo.start_time
                self.infoVC!.mEndTime = self.storeInfo.end_time
                self.infoVC!.mHoiday = self.storeInfo.holiday
                self.infoVC!.mimageListModel = self.storeInfo.images
                
                self.reviewVC!.receivedId = self.storeInfo.id
                self.reviewVC?.reviewCount = self.storeInfo.review_cnt!
                self.tabItem3.title = "리뷰("+String(self.storeInfo.review_cnt!)+")"

                
                self.tabBar.selectedItem = self.tabBar.items![0] as UITabBarItem;
                self.tabBar(self.tabBar,didSelectItem: self.tabItem1)

                
        }

        
    }
    
    
    
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
      
        switch item.tag {
            
        case 1:
            self.menuVC!.view.frame = CGRectMake(0, 0, self.storeDetailContentsView.frame.size.width, self.storeDetailContentsView.frame.size.height);
            self.storeDetailContentsView.insertSubview(self.menuVC!.view, belowSubview: self.tabBar)
            self.menuVC?.inputData()
            break
            
        case 2:
                //self.infoVC!.view.frame.height = self.storeDetailContentsView.frame.height
            self.infoVC!.view.frame = CGRectMake(0, 0, self.storeDetailContentsView.frame.size.width, self.storeDetailContentsView.frame.size.height);
            self.storeDetailContentsView.insertSubview(self.infoVC!.view, belowSubview: self.tabBar)
            self.infoVC?.inputData()
            break
            
        case 3:
            self.reviewVC!.view.frame = CGRectMake(0, 0, self.storeDetailContentsView.frame.size.width, self.storeDetailContentsView.frame.size.height);
            self.storeDetailContentsView.insertSubview(self.reviewVC!.view, belowSubview: self.tabBar)
            break
            
        default:
            break
        }
    
    }

    
    
    
    @IBAction func callToStore(sender: AnyObject) {

        var tellNumber = String(self.infoVC!.mStoreTel!)
        // '-' 기호 제거
        tellNumber = tellNumber.stringByReplacingOccurrencesOfString("-", withString: "", range: nil)
        // 공백 제거
        tellNumber = tellNumber.stringByReplacingOccurrencesOfString(" ", withString: "", range: nil)
        print(tellNumber)
        // 해당 번호로 전화 걸기
        if let phoneCallURL = NSURL(string: "tel:\(tellNumber)") {
            let application = UIApplication.sharedApplication()
            if application.canOpenURL(phoneCallURL) {
                application.openURL(phoneCallURL)
            }
            else{
                print("failed")
            }
        }
    }
    
    @IBAction func backToStoreList(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}