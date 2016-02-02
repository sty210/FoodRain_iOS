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

class StoreVC: SunViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
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
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    
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
    
    @IBOutlet weak var Indicator1: UIActivityIndicatorView!
    @IBOutlet weak var Indicator2: UIActivityIndicatorView!
    @IBOutlet weak var Indicator3: UIActivityIndicatorView!
    @IBOutlet weak var Indicator4: UIActivityIndicatorView!
    @IBOutlet weak var Indicator5: UIActivityIndicatorView!
    @IBOutlet weak var Indicator6: UIActivityIndicatorView!
    @IBOutlet weak var Indicator7: UIActivityIndicatorView!
    @IBOutlet weak var Indicator8: UIActivityIndicatorView!
    @IBOutlet weak var Indicator9: UIActivityIndicatorView!
    @IBOutlet weak var Indicator10: UIActivityIndicatorView!
    @IBOutlet weak var Indicator11: UIActivityIndicatorView!
    
//    var storeListArray = [StoreListModel]()
    var mainTableView: UITableView!
    var categoryId: Int?
    var isAlreadyDataLoaded = [false,false,false,false,false,false,false,false,false,false,false]
    var moreDataFlag: Bool = false
    var currentCategoryIndex: Int? = 1
    var storeListArray = [Store]()
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SelectedCategoryName.text = receivedCategoryName
        
    }
    
    override func viewDidLayoutSubviews() {
            setTableViewsPosition()
    }
    
    func setTableViewsPosition(){
        
        if categoryId == 1 {
            mainTableView = tableView1
            self.chickenButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
        else if categoryId == 2{
            mainTableView = tableView2
            self.pizzaButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
        else if categoryId == 3{
            mainTableView = tableView3
            self.chinessButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
        else if categoryId == 4{
            mainTableView = tableView4
            self.pigFootButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
        else if categoryId == 5{
            mainTableView = tableView5
            self.KoreanButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
        else if categoryId == 6{
            mainTableView = tableView6
            self.nightFoodButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
        else if categoryId == 7{
            mainTableView = tableView7
            self.soupButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
        else if categoryId == 8{
            mainTableView = tableView8
            self.japaneseButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
        else if categoryId == 9{
            mainTableView = tableView9
            self.foodPackButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
        else if categoryId == 10{
            mainTableView = tableView10
            self.fastFoodButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
        else if categoryId == 11{
            mainTableView = tableView11
            self.etcButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
        
        showStoresByCategory()
    }
    
    
    func showStoresByCategory(){
        currentCategoryIndex = categoryId!-1
        
        if isAlreadyDataLoaded[currentCategoryIndex!] == false {
            Alamofire.request(.GET, "http://192.168.0.2:3000/api/stores.json", parameters: ["category": categoryId!, "page": self.storeListArray[currentCategoryIndex!].page!])
            .responseJSON { response in
                if let JSON = response.result.value {
                    if let JSON_ = JSON as? NSDictionary {
                        print("!!!!!!!!!!!!!!!!!!!!!!!!!!")
                        if let records = JSON_["records"] as? Int {
                            self.storeListArray[self.currentCategoryIndex!].records = records
                        }
                        
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
            self.isAlreadyDataLoaded[self.currentCategoryIndex!] = true
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
        cell.reviewCount.text = "리뷰 " + String(storeListArray[currentCategoryIndex!].row[indexPath.row].review_cnt!)
        //cell.storeTag.text = storeListDictArray[currentCategoryIndex!].row[indexPath.row].tag
        //cell.storeTag.text = "전화주문 가능"
        cell.storeTag.text = ""
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
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.storeListArray[currentCategoryIndex!].records > 0 {
            if self.storeListArray[currentCategoryIndex!].row.count-1 == ((tableView.indexPathsForVisibleRows?.last)! as NSIndexPath).row {
                
                startIndicator()
                isAlreadyDataLoaded[currentCategoryIndex!] = false
                showStoresByCategory()
                isAlreadyDataLoaded[currentCategoryIndex!] = true
                stopIndicatior()
                
            }
        }
    }

    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.isKindOfClass(UITableView) {
            
        } else {
            
            if tableScrollView.bounds.origin.x == 0 {
                self.chickenButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
            else if tableScrollView.bounds.origin.x == self.screenWidth * 1{
                self.pizzaButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
            else if tableScrollView.bounds.origin.x == self.screenWidth * 2{
                self.chinessButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
            else if tableScrollView.bounds.origin.x == self.screenWidth * 3{
                self.pigFootButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
            else if tableScrollView.bounds.origin.x == self.screenWidth * 4{
                self.KoreanButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
            else if tableScrollView.bounds.origin.x == self.screenWidth * 5{
                self.nightFoodButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
            else if tableScrollView.bounds.origin.x == self.screenWidth * 6{
                self.soupButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
            else if tableScrollView.bounds.origin.x == self.screenWidth * 7{
                self.japaneseButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
            else if tableScrollView.bounds.origin.x == self.screenWidth * 8{
                self.foodPackButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
            else if tableScrollView.bounds.origin.x == self.screenWidth * 9{
                self.fastFoodButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }
            else if tableScrollView.bounds.origin.x == self.screenWidth * 10{
                self.etcButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            }

        }
    }
    
    
    
    @IBAction func backToHome(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    @IBAction func onTouchTopScrollViewItem1(sender: AnyObject) {
        topScrollView.bounds.origin.x = 0
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.bounds.origin.x = self.screenWidth * 0
        categoryId = 1
        setAllBtnsColorReset()
        chickenButton.backgroundColor = UIColor.init(red: 255, green: 186, blue: 197, alpha: 0.5)
    }
    @IBAction func onTouchTopScrollViewItem2(sender: AnyObject) {
        topScrollView.bounds.origin.x = 0
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.bounds.origin.x = self.screenWidth * 1
        categoryId = 2
        setAllBtnsColorReset()
        pizzaButton.backgroundColor = UIColor.init(red: 255, green: 186, blue: 197, alpha: 0.5)
    }
    @IBAction func onTouchTopScrollViewItem3(sender: AnyObject) {
        topScrollView.bounds.origin.x = 0
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.bounds.origin.x = self.screenWidth * 2
        categoryId = 3
        setAllBtnsColorReset()
        chinessButton.backgroundColor = UIColor.init(red: 255, green: 186, blue: 197, alpha: 0.5)
    }
    @IBAction func onTouchTopScrollViewItem4(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 0.61
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.bounds.origin.x = self.screenWidth * 3
        categoryId = 4
        setAllBtnsColorReset()
        pigFootButton.backgroundColor = UIColor.init(red: 255, green: 186, blue: 197, alpha: 0.5)
    }
    @IBAction func onTouchTopScrollViewItem5(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 2.1
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = self.screenWidth * 4
        categoryId = 5
        setAllBtnsColorReset()
        KoreanButton.backgroundColor = UIColor.init(red: 255, green: 186, blue: 197, alpha: 0.5)
    }
    @IBAction func onTouchTopScrollViewItem6(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 3.35
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = self.screenWidth * 5
        categoryId = 6
        setAllBtnsColorReset()
        nightFoodButton.backgroundColor = UIColor.init(red: 255, green: 186, blue: 197, alpha: 0.5)
    }
    @IBAction func onTouchTopScrollViewItem7(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 4.35
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = self.screenWidth * 6
        categoryId = 7
        setAllBtnsColorReset()
        soupButton.backgroundColor = UIColor.init(red: 255, green: 186, blue: 197, alpha: 0.5)
    }
    @IBAction func onTouchTopScrollViewItem8(sender: AnyObject) {
        //topScrollView.bounds.origin.x = chickenButton.frame.size.width * 5 + (chickenButton.frame.size.width/2)
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 5.87
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = self.screenWidth * 7
        categoryId = 8
        setAllBtnsColorReset()
        japaneseButton.backgroundColor = UIColor.init(red: 255, green: 186, blue: 197, alpha: 0.5)
    }
    @IBAction func onTouchTopScrollViewItem9(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 7.34
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = self.screenWidth * 8
        categoryId = 9
        setAllBtnsColorReset()
        foodPackButton.backgroundColor = UIColor.init(red: 255, green: 186, blue: 197, alpha: 0.5)
    }
    @IBAction func onTouchTopScrollViewItem10(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 7 + (chickenButton.frame.size.width/2)
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = self.screenWidth * 9
        categoryId = 10
        setAllBtnsColorReset()
        fastFoodButton.backgroundColor = UIColor.init(red: 255, green: 186, blue: 197, alpha: 0.5)
    }
    @IBAction func onTouchTopScrollViewItem11(sender: AnyObject) {
        topScrollView.bounds.origin.x = chickenButton.frame.size.width * 7 + (chickenButton.frame.size.width/2)
        SelectedCategoryName.text = sender.titleLabel!!.text
        tableScrollView.contentOffset.x = self.screenWidth * 10
        categoryId = 11
        setAllBtnsColorReset()
        etcButton.backgroundColor = UIColor.init(red: 255, green: 186, blue: 197, alpha: 0.5)
    }
  

    func setAllBtnsColorReset(){
        chickenButton.backgroundColor = UIColor.init(red: 34, green: 63, blue: 69, alpha: 0)
        pizzaButton.backgroundColor = UIColor.init(red: 34, green: 63, blue: 69, alpha: 0)
        chinessButton.backgroundColor = UIColor.init(red: 34, green: 63, blue: 69, alpha: 0)
        pigFootButton.backgroundColor = UIColor.init(red: 34, green: 63, blue: 69, alpha: 0)
        KoreanButton.backgroundColor = UIColor.init(red: 34, green: 63, blue: 69, alpha: 0)
        nightFoodButton.backgroundColor = UIColor.init(red: 34, green: 63, blue: 69, alpha: 0)
        soupButton.backgroundColor = UIColor.init(red: 34, green: 63, blue: 69, alpha: 0)
        japaneseButton.backgroundColor = UIColor.init(red: 34, green: 63, blue: 69, alpha: 0)
        foodPackButton.backgroundColor = UIColor.init(red: 34, green: 63, blue: 69, alpha: 0)
        fastFoodButton.backgroundColor = UIColor.init(red: 34, green: 63, blue: 69, alpha: 0)
        etcButton.backgroundColor = UIColor.init(red: 34, green: 63, blue: 69, alpha: 0)
    }
    
    func startIndicator(){
        self.Indicator1.hidden = false
        self.Indicator2.hidden = false
        self.Indicator3.hidden = false
        self.Indicator4.hidden = false
        self.Indicator5.hidden = false
        self.Indicator6.hidden = false
        self.Indicator7.hidden = false
        self.Indicator8.hidden = false
        self.Indicator9.hidden = false
        self.Indicator10.hidden = false
        self.Indicator11.hidden = false
    }
    
    func stopIndicatior(){
        self.Indicator1.hidden = true
        self.Indicator2.hidden = true
        self.Indicator3.hidden = true
        self.Indicator4.hidden = true
        self.Indicator5.hidden = true
        self.Indicator6.hidden = true
        self.Indicator7.hidden = true
        self.Indicator8.hidden = true
        self.Indicator9.hidden = true
        self.Indicator10.hidden = true
        self.Indicator11.hidden = true
    }
    
    
}