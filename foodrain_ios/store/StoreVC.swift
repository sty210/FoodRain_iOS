//
//  StoreVC.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 27..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class StoreVC: SunViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var topScrollView: UIScrollView!
    @IBOutlet weak var tableScrollView: UIScrollView!
    
    @IBOutlet weak var chickenButton: UIButton!
    @IBOutlet weak var pizzaButton: UIButton!
    @IBOutlet weak var chinessButton: UIButton!
    @IBOutlet weak var pigFootButton: UIButton!
    @IBOutlet weak var KoreanButton: UIButton!
    @IBOutlet weak var nightFoodButton: UIButton!
    @IBOutlet weak var soupButton: UIButton!
    @IBOutlet weak var japaneseButton: UIButton!
    @IBOutlet weak var foodPackButton: UIButton!
    @IBOutlet weak var fastFoodButton: UIButton!
    @IBOutlet weak var etcButton: UIButton!
    
    @IBOutlet weak var SelectedCategoryName: UILabel!
    var receivedCategoryName: String!
    
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var tableView3: UITableView!
    @IBOutlet weak var tableView4: UITableView!
    @IBOutlet weak var tableView5: UITableView!
    @IBOutlet weak var tableView6: UITableView!
    @IBOutlet weak var tableView7: UITableView!
    @IBOutlet weak var tableView8: UITableView!
    @IBOutlet weak var tableView9: UITableView!
    @IBOutlet weak var tableView10: UITableView!
    @IBOutlet weak var tableView11: UITableView!
    
    
//    var storeListArray = [StoreListModel]()
    var mainTableView: UITableView!
    var categoryId: Int?
    var isAlreadyDataLoaded = ["false","false","false","false","false","false","false","false","false","false","false"]
    var currentCategoryIndex: Int? = 1

    
    var storeListArray = [Store]()
    
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.automaticallyAdjustsScrollViewInsets = false
        SelectedCategoryName.text = receivedCategoryName;
        startViewByCategory()
    }
    
    
    func startViewByCategory(){
        
        
        //mainTableView = tableView+categoryId!
        if categoryId == 1{
            mainTableView = tableView1
            topScrollView.bounds.origin.x = 0
            tableScrollView.bounds.origin.x = 0
        }else if categoryId == 2{
            mainTableView = tableView2
            topScrollView.bounds.origin.x = 0
            //tableScrollView.bounds.origin.x = tableView1.frame.size.width * 1
            tableScrollView.contentOffset.x  = tableView1.frame.size.width * 1
        }else if categoryId == 3{
            mainTableView = tableView3
            topScrollView.bounds.origin.x = 0
            //tableScrollView.bounds.origin.x = tableView1.frame.size.width * 2
            tableScrollView.contentOffset.x  = tableView1.frame.size.width * 2
        }else if categoryId == 4{
            mainTableView = tableView4
            topScrollView.bounds.origin.x = chickenButton.frame.size.width * 1
            tableScrollView.bounds.origin.x = tableView1.frame.size.width * 3
        }else if categoryId == 5{
            mainTableView = tableView5
            topScrollView.bounds.origin.x = chickenButton.frame.size.width * 2
            tableScrollView.bounds.origin.x = tableView1.frame.size.width * 4
        }else if categoryId == 6{
            mainTableView = tableView6
            topScrollView.bounds.origin.x = chickenButton.frame.size.width * 3
            tableScrollView.bounds.origin.x = 375 * 5
        }else if categoryId == 7{
            mainTableView = tableView7
            topScrollView.bounds.origin.x = chickenButton.frame.size.width * 4
            tableScrollView.bounds.origin.x = 375 * 6
        }else if categoryId == 8{
            mainTableView = tableView8
            topScrollView.bounds.origin.x = chickenButton.frame.size.width * 5 + (chickenButton.frame.size.width/2)
            tableScrollView.bounds.origin.x = 375 * 7
        }else if categoryId == 9{
            mainTableView = tableView9
            topScrollView.bounds.origin.x = chickenButton.frame.size.width * 7
            tableScrollView.bounds.origin.x = 375 * 8
        }else if categoryId == 10{
            mainTableView = tableView10
            topScrollView.bounds.origin.x = chickenButton.frame.size.width * 7 + (chickenButton.frame.size.width/2)
            tableScrollView.bounds.origin.x = 375 * 9
        }else if categoryId == 11{
            mainTableView = tableView11
            topScrollView.bounds.origin.x = chickenButton.frame.size.width * 7 + (chickenButton.frame.size.width/2)
            tableScrollView.bounds.origin.x = 375 * 2
        }
        //tableScrollView.contentOffset.x = tableScrollView.frame.size.width * (CGFloat(categoryId!)-1)
        currentCategoryIndex = categoryId!-1
        
        
        if isAlreadyDataLoaded[categoryId!-1] == "false" {
            Alamofire.request(.GET, "http://192.168.0.2:3000/api/stores.json", parameters: ["category": categoryId!, "page": self.storeListArray[currentCategoryIndex!].page!])
            .responseJSON { response in
                if let JSON = response.result.value {
                    print(JSON)
                    if let JSON_ = JSON as? NSDictionary {
                        if let results = JSON_["rows"] as? NSArray {
                            let categoryTable = self.storeListArray[self.currentCategoryIndex!]
                            for rs in results {
                                if let dict = rs as? NSDictionary {
                                    
                                    let store = StoreListModel()
                                    store.id = dict["id"] as? Int
                                    store.name = dict["name"] as? String
                                    store.address = dict["address"] as? String
                                    //store.status = dict["status"] as? Int
                                    //store.tag = dict["tag"] as? String
                                    store.review_cnt = dict["review_cnt"] as? Int
                                    store.grade_avg = dict["grade_avg"] as? Float
                                    //store.main_image = dict["main_image"] as? String
                                    
                                    print(store.id)
                                    print(store.name)
                                    print(store.address)
                                    //print(store.status)
                                    //print(store.tag)
                                    print(store.review_cnt)
                                    print(store.grade_avg)
                                    print(store.main_image)
                                    
                                    
                                    //self.storeListArray.append(store)
                                    //let test = self.storeListArray[self.currentCategoryIndex!]
                                    //test.page = test.page! + 1
                                    categoryTable.row.append(store)
                                }
                            }
                            categoryTable.page = categoryTable.page! + 1
                        }
                    }
                }
                self.mainTableView.reloadData()
            }
            isAlreadyDataLoaded[categoryId!-1] = "true"
        }
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeListArray[currentCategoryIndex!].row.count
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCellWithIdentifier("storeTableViewCell", forIndexPath: indexPath) as! StoreListTableViewCell


        cell.id = storeListArray[currentCategoryIndex!].row[indexPath.row].id
        cell.storeRating.text = "평점 : " + String(storeListArray[currentCategoryIndex!].row[indexPath.row].grade_avg!) + "/5.0"
        cell.storeName.text = storeListArray[currentCategoryIndex!].row[indexPath.row].name
        cell.reviewCount.text = "리뷰개수 : " + String(storeListArray[currentCategoryIndex!].row[indexPath.row].review_cnt!)
        //cell.storeTag.text = storeListDictArray[currentCategoryIndex!].row[indexPath.row].tag
        cell.storeTag.text = "전화주문 가능"
        
        cell.storeImage.image = UIImage(named: "ready")
        
        /*
        let imagePath = StoreListArray[indexPath.row].main_image!;
        
        Alamofire.request(.GET, imagePath).response() {
            //imagePath가 가지고있는 url로 이미지를 로드하여 UIImageView에 세팅한다
            (_, _, data, _) in
            let image = UIImage(data:data!)
            cell.storeImage.image = image
        }
        */
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedStoreDetail = (UIStoryboard (name: "store", bundle: nil).instantiateViewControllerWithIdentifier("StoreDetailVC")) as! StoreDetailVC
        
        selectedStoreDetail.receivedId = storeListArray[currentCategoryIndex!].row[indexPath.row].id
        selectedStoreDetail.receivedTitle = storeListArray[currentCategoryIndex!].row[indexPath.row].name
        
        
        self.navigationController?.pushViewController(selectedStoreDetail, animated: true)
    }
    
    /*func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }*/
    
    
    
    
    
    
    @IBAction func backToHome(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    @IBAction func onTouchTopScrollViewItem1(sender: AnyObject) {
        topScrollView.bounds.origin.x = 0
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.bounds.origin.x = tableView1.frame.size.width * 0
        categoryId = 1
        startViewByCategory()
    }
    @IBAction func onTouchTopScrollViewItem2(sender: AnyObject) {
        topScrollView.bounds.origin.x = 0
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.bounds.origin.x = tableView1.frame.size.width * 1
        categoryId = 2
        startViewByCategory()
    }
    @IBAction func onTouchTopScrollViewItem3(sender: AnyObject) {
        topScrollView.bounds.origin.x = 0
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.bounds.origin.x = tableView1.frame.size.width * 2
        categoryId = 3
        startViewByCategory()
    }
    @IBAction func onTouchTopScrollViewItem4(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 1
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.bounds.origin.x = tableView1.frame.size.width * 3
        categoryId = 4
        startViewByCategory()
    }
    @IBAction func onTouchTopScrollViewItem5(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 2
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = tableView1.frame.size.width * 4
        categoryId = 5
        startViewByCategory()
    }
    @IBAction func onTouchTopScrollViewItem6(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 3
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = tableView1.frame.size.width * 5
        categoryId = 6
        startViewByCategory()
    }
    @IBAction func onTouchTopScrollViewItem7(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 4
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = tableView1.frame.size.width * 6
        categoryId = 7
        startViewByCategory()
    }
    @IBAction func onTouchTopScrollViewItem8(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 5 + (chickenButton.frame.size.width/2)
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = tableView1.frame.size.width * 7
        categoryId = 8
        startViewByCategory()
    }
    @IBAction func onTouchTopScrollViewItem9(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 7
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = tableView1.frame.size.width * 8
        categoryId = 9
        startViewByCategory()
    }
    @IBAction func onTouchTopScrollViewItem10(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 7 + (chickenButton.frame.size.width/2)
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = tableView1.frame.size.width * 9
        categoryId = 10
        startViewByCategory()
    }
    @IBAction func onTouchTopScrollViewItem11(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 7 + (chickenButton.frame.size.width/2)
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = tableView1.frame.size.width * 10
        categoryId = 11
        startViewByCategory()
    }
  

    
    
    
}