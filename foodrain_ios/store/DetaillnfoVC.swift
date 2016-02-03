//
//  DetaillnfoVC.swift
//  foodrain_ios
//
//  Created by 송태양 on 2016. 1. 31..
//  Copyright © 2016년 송태양. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class DetaillnfoVC: SunViewController{
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var hoiday: UILabel!
    @IBOutlet weak var storeTel: UILabel!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var storeScrollView: UIScrollView!
    
    var mStoreTel: String?
    var mStoreAddress: String?
    var mStartTime: String?
    var mEndTime: String?
    var mHoiday: String?
    var mimageListModel = [ImageModel]()
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    var firstStoreScrollViewHeight: CGFloat = 200.0
    var firstStoreScrollViewWidth: CGFloat = 0.0
    var firstStoreScrollViewOriginX: CGFloat = 0.0
    var firstStoreScrollViewOriginY: CGFloat = 0.0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func inputData() {
        deliveryTime.text = String(mStartTime! + " - " + mEndTime!)
        hoiday.text = mHoiday!
        storeTel.text = mStoreTel!
        storeAddress.text = mStoreAddress!
        
        //scrollview의 size를 변경하기 전에 저장해 둠
        firstStoreScrollViewWidth = storeScrollView.frame.size.width
        firstStoreScrollViewHeight = storeScrollView.frame.size.height
        firstStoreScrollViewOriginX = storeScrollView.frame.origin.x
        firstStoreScrollViewOriginY = storeScrollView.frame.origin.y
        
        //store image로 등록된 사진이 하나도 없는 경우 디폴트이미지로 처리
        if mimageListModel.count == 0{
            //storeImageView.image = UIImage(named: "ready")
            let imageView = UIImageView()
            imageView.image = UIImage(named: "ready")
            imageView.frame = CGRectMake(0, 0, self.firstStoreScrollViewWidth, self.firstStoreScrollViewHeight)
            self.storeScrollView.addSubview(imageView)
        }
        else{
            //scrollview의 contentSize를 늘려 줌
            storeScrollView.contentSize = CGSize(width: screenWidth * CGFloat(mimageListModel.count), height: firstStoreScrollViewHeight)
    
            for i in 0...(mimageListModel.count-1){
                let imagePath = "http://10.10.0.58:9090" + mimageListModel[i].url!
                Alamofire.request(.GET, imagePath).response() {
                    //imagePath가 가지고있는 url로 이미지를 로드하여 UIImageView에 세팅한다
                    (_, _, data, _) in
                    let image = UIImage(data:data!)
                    let imageView = UIImageView()
                    print(image)
                    imageView.image = image
                    imageView.frame = CGRectMake(self.firstStoreScrollViewWidth * CGFloat(i), 0, self.firstStoreScrollViewWidth, self.firstStoreScrollViewHeight)
                    
                    self.storeScrollView.addSubview(imageView)
                }
                
            }

        }
        
        
    }
    
}