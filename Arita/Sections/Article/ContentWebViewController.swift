//
//  ContentWebViewController.swift
//  Arita
//
//  Created by DcBunny on 15/8/18.
//  Copyright (c) 2015年 DcBunny. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ContentWebViewController: UIViewController, UIWebViewDelegate
{
    @IBOutlet weak var contenWebView: UIWebView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var downBarImage: UIImageView!
    
    var articleJson: JSON = ""
    var segueId: String = ""
    var viewTitle: String = ""
    var isLike = false
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        switch self.segueId {
            case "Tata":
                self.titleImage.image = UIImage(named: "tataTitle")
                self.downBarImage.image = UIImage(named: "tataTitle")
            
            case "cySegue":
                self.titleImage.image = UIImage(named: "cyTitle")
                self.downBarImage.image = UIImage(named: "cyTitle")
            
            case "sjSegue":
                self.titleImage.image = UIImage(named: "sjTitle")
                self.downBarImage.image = UIImage(named: "sjTitle")
            
            case "shSegue":
                self.titleImage.image = UIImage(named: "shTitle")
                self.downBarImage.image = UIImage(named: "shTitle")
            
            default :
                break
        }
        
        self.articleTitleLabel.text = self.viewTitle
        
        let articleId = self.articleJson["ID"].stringValue
        let url = NSURL(string: "http://112.74.192.226/ios/article_detail?id=\(articleId)")
        let request = NSURLRequest(URL: url!)
        
        self.contenWebView.loadRequest(request)
        self.contenWebView.delegate = self
        
        let userId = NSUserDefaults.standardUserDefaults().stringForKey("userid")
        if userId != nil {
            let parameters = [
                "id": userId!,
                "articleID": articleId
            ]
            Alamofire.request(.GET, "http://112.74.192.226/ios/is_like_article", parameters: parameters)
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
    
    @IBAction func shareArticle(sender: UIButton) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let thirdPartShareController = ThirdPartShareController()
            thirdPartShareController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            thirdPartShareController.providesPresentationContextTransitionStyle = true
            thirdPartShareController.definesPresentationContext = true
            thirdPartShareController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            thirdPartShareController.shareType = 0
            thirdPartShareController.articleJson = self.articleJson
            let articleId = self.articleJson["ID"].stringValue
            thirdPartShareController.articleUrl = NSURL(string: "http://112.74.192.226/ios/article_detail?id=\(articleId)")!
            self.presentViewController(thirdPartShareController , animated:true, completion: nil)
        })
    }
    
    @IBAction func goToComment(sender: UIButton) {
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
        
        let commentViewController = CommentViewController()
        commentViewController.articleId = self.articleJson["ID"].stringValue
        self.presentViewController(commentViewController, animated: true, completion: nil)
    }
    
    @IBAction func likeArticle(sender: UIButton) {
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
        
        let articleId = self.articleJson["ID"].stringValue
        let parameters = [
            "id": userId!,
            "articleID": articleId
        ]
        
        if !self.isLike {
            self.likeBtn.setImage(UIImage(named: "downCollected"), forState: UIControlState.Normal)
            self.isLike = true
            
            Alamofire.request(.GET, "http://112.74.192.226/ios/add_like_article", parameters: parameters)
                .response { request, _, aJson, error in
                    _ = NSString(data: aJson!, encoding: NSUTF8StringEncoding)
            }
        } else {
            self.likeBtn.setImage(UIImage(named: "downCollect"), forState: UIControlState.Normal)
            self.isLike = false
            
            Alamofire.request(.GET, "http://112.74.192.226/ios/del_like_article", parameters: parameters)
                .response { request, _, aJson, error in
                    _ = NSString(data: aJson!, encoding: NSUTF8StringEncoding)
            }
        }
    }
}
