//
//  GoodsWebViewController.swift
//  Arita
//
//  Created by DcBunny on 15/8/18.
//  Copyright (c) 2015年 DcBunny. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class GoodsWebViewController: UIViewController, UIWebViewDelegate
{
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    let categoryArray: [String: String] = [
        "20": "趣玩", "21": "数码", "22": "文具", "23": "日用",
        "24": "母婴", "25": "箱包", "26": "电器", "27": "厨房",
        "28": "家居", "29": "女装", "30": "男装", "31": "配饰"
    ]
    
    var goodJson: JSON = ""
    
    var isLike = false
    
    @IBOutlet weak var goodWebView: UIWebView!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let category = self.categoryArray[self.goodJson["channel_ID"].stringValue]!
        self.titleLabel.text = "良品 | \(category)"
        let goodId = self.goodJson["ID"].stringValue
        let url = NSURL(string: "http://112.74.192.226/ios/goods_detail?id=\(goodId)")
        let request = NSURLRequest(URL: url!)
        self.goodWebView.loadRequest(request)
        self.goodWebView.delegate = self
        
        let userId = NSUserDefaults.standardUserDefaults().stringForKey("userid")
        if userId != nil {
            let parameters = [
                "id": userId!,
                "goodsID": goodId
            ]
            Alamofire.request(.GET, "http://112.74.192.226/ios/is_like_goods", parameters: parameters)
                .response { request, _, aJson, error in
                    let result = NSString(data: aJson!, encoding: NSUTF8StringEncoding)
                    if result == "000000" {
                        self.likeBtn.setImage(UIImage(named: "downCollected"), forState: UIControlState.Normal)
                        self.isLike = true
                    } else {
                        self.likeBtn.setImage(UIImage(named: "downCollect"), forState: UIControlState.Normal)
                        self.isLike = false
                    }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 隐藏status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: - UIWebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {
//        println("Web view did finish load.")
    }
    
    //MARK: - event response
    @IBAction func backToList() {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func shareGood(sender: UIButton) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let thirdPartShareController = ThirdPartShareController()
            thirdPartShareController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            thirdPartShareController.providesPresentationContextTransitionStyle = true
            thirdPartShareController.definesPresentationContext = true
            thirdPartShareController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            thirdPartShareController.shareType = 1
            thirdPartShareController.articleJson = self.goodJson
            let goodId = self.goodJson["ID"].stringValue
            thirdPartShareController.articleUrl = NSURL(string: "http://112.74.192.226/ios/goods_detail?id=\(goodId)")!
            self.presentViewController(thirdPartShareController , animated:true, completion: nil)
        })
    }
    
    @IBAction func likeGood(sender: UIButton) {
        let userId = NSUserDefaults.standardUserDefaults().stringForKey("userid")
        if (userId == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let thirdPartLoginController = ThirdPartLoginController()
                thirdPartLoginController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                thirdPartLoginController.providesPresentationContextTransitionStyle = true
                thirdPartLoginController.definesPresentationContext = true
                thirdPartLoginController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
                self.presentViewController(thirdPartLoginController , animated:true, completion: nil)
            })
            return
        }
        
        let goodId = self.goodJson["ID"].stringValue
        let parameters = [
            "id": userId!,
            "goodsID": goodId
        ]
        
        if !self.isLike {
            self.likeBtn.setImage(UIImage(named: "downCollected"), forState: UIControlState.Normal)
            self.isLike = true

            Alamofire.request(.GET, "http://112.74.192.226/ios/add_like_goods", parameters: parameters)
                .response { request, _, aJson, error in
                    _ = NSString(data: aJson!, encoding: NSUTF8StringEncoding)
            }
        } else {
            self.likeBtn.setImage(UIImage(named: "downCollect"), forState: UIControlState.Normal)
            self.isLike = false
            
            Alamofire.request(.GET, "http://112.74.192.226/ios/del_like_goods", parameters: parameters)
                .response { request, _, aJson, error in
                    _ = NSString(data: aJson!, encoding: NSUTF8StringEncoding)
            }
        }
    }
}
