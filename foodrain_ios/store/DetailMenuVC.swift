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

class DetailMenuVC: SunViewController {
    var mImageListModel = [ImageModel]()
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    var realContentPartHeight: CGFloat?
    var scrollViewHieght: CGFloat = 0.0
    var loadFlag: Bool = false
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realContentPartHeight = screenHeight-169
    }
    
    
    func inputData() {
        
        if mImageListModel.count == 0{
            let imageView = UIImageView()
            imageView.image = UIImage(named: "ready")
            imageView.frame = CGRectMake(0, 0, screenWidth, realContentPartHeight!)
            self.scrollView.addSubview(imageView)
        }
        else{
            //한번 불러왔으면 더이상 안불러옴.
            if loadFlag == false{
                for i in 0...(mImageListModel.count-1){
                    mIndicator.hidden = false
                    let imagePath = "http://10.10.0.58:9090" + mImageListModel[i].url!
                    Alamofire.request(.GET, imagePath).response() {
                        //imagePath가 가지고있는 url로 이미지를 로드하여 UIImageView에 세팅한다
                        (_, _, data, _) in
                    
                        let image = UIImage(data:data!)
                        let imageView = UIImageView()
                        print(image)
                        imageView.image = image
                    
                        let imageWidth = image!.size.width
                        let imageHeight = image!.size.height
                        let ratio = imageHeight/imageWidth
                    
                        imageView.frame = CGRectMake(0, self.scrollViewHieght, self.screenWidth, self.screenWidth*ratio)
                        self.scrollViewHieght = self.scrollViewHieght + self.screenWidth*ratio
                        self.scrollView.contentSize = CGSize(width: self.screenWidth, height: self.scrollViewHieght)
                    
                        self.scrollView.addSubview(imageView)
                        self.mIndicator.hidden = true
                        self.loadFlag = true
                    }
                }
                
            }
            
        }
    
    }
}